locals {
  users_config = jsondecode(file("${path.module}/users.json"))

  catalog_config = [
    "sales_dev",
    "sales_prod",
    "marketing_dev",
    "marketing_prod"
  ]

  # Standard schemas for most catalogs
  standard_schemas = ["bronze", "silver", "gold"]

  # Special schemas for specific catalogs (if needed)
  custom_schemas = {
    "marketing_dev" = ["bronze", "silver", "gold", "experiments"]
    # Add more custom configs here if needed
  }

  # Generate schema configurations dynamically
  schemas_config = flatten([
    for catalog in local.catalog_config : [
      for schema in lookup(local.custom_schemas, catalog, local.standard_schemas) : {
        catalog_name = catalog
        schema_name  = schema
      }
    ]
  ])
}