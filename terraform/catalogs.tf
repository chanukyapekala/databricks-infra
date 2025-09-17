# Create catalogs
resource "databricks_catalog" "custom_catalogs" {
  for_each       = toset(local.catalog_config)
  name           = each.key
  comment        = "Catalog managed by Terraform"
  properties     = {}
  isolation_mode = "OPEN"
  storage_root   = "s3://dbstorage-prod-nj0pi/uc/841f0d32-d62a-458b-b2f9-34aa65ce130e/76a86886-8a5f-4f4b-b890-a352622aaad1"
}

# Create schemas
resource "databricks_schema" "custom_schemas" {
  for_each      = { for schema in local.schemas_config : "${schema.catalog_name}.${schema.schema_name}" => schema }
  catalog_name  = each.value.catalog_name
  name          = each.value.schema_name
  comment       = "Schema managed by Terraform"
  properties    = {}
  force_destroy = true

  depends_on = [databricks_catalog.custom_catalogs]
}

# Grant catalog permissions
resource "databricks_grants" "catalog_grants" {
  for_each = databricks_catalog.custom_catalogs
  catalog  = each.value.name

  grant {
    principal  = "chanukya.pekala@gmail.com"
    privileges = ["USE_CATALOG", "CREATE_SCHEMA"]
  }

  depends_on = [databricks_catalog.custom_catalogs, databricks_user.users]
}

# Grant schema permissions
resource "databricks_grants" "schema_grants" {
  for_each = databricks_schema.custom_schemas
  schema   = each.key

  grant {
    principal  = "chanukya.pekala@gmail.com"
    privileges = ["USE_SCHEMA", "CREATE_TABLE"]
  }

  depends_on = [databricks_schema.custom_schemas, databricks_user.users]
}