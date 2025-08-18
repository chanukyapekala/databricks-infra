# Data source for current user
data "databricks_current_user" "me" {}

locals {
  users_config = jsondecode(file("${path.module}/users.json"))

  # Create map of group names to display names
  group_names = {
    for group_name, display_name in var.allowed_groups :
    group_name => display_name
    if contains(distinct(flatten([for user in local.users_config.users : user.groups])), group_name)
  }

  # Filter out reserved catalog names
  catalog_names = toset([
    for catalog in distinct(flatten([
      for user in local.users_config.users : keys(user.catalog_permissions)
    ])) : catalog
    if !contains(["samples", "main", "hive_metastore"], catalog)
  ])
}

# Data source for existing catalogs
data "databricks_catalog" "existing_catalogs" {
  for_each = toset(["main", "samples"])
  name     = each.key
}

# Create custom catalogs
resource "databricks_catalog" "custom_catalogs" {
  for_each   = local.catalog_names
  name       = each.key
  comment    = "Catalog managed by Terraform"
  properties = {}

  depends_on = [data.databricks_catalog.existing_catalogs]
}

# Create notebook directory
resource "databricks_directory" "shared_notebooks" {
  path = "/Shared/terraform-managed"
}

# Create notebook
resource "databricks_notebook" "hello_world" {
  path           = "${databricks_directory.shared_notebooks.path}/hello-world"
  language       = var.notebook_language
  content_base64 = base64encode(file("${path.module}/templates/hello-world.py"))
}

# Create groups
resource "databricks_group" "groups" {
  for_each     = local.group_names
  display_name = each.value
}

# Try to get existing users first
resource "databricks_user" "users" {
  for_each     = { for user in local.users_config.users : user.user_name => user }
  user_name    = each.value.user_name
  display_name = each.value.display_name
  force        = true  # This allows updating existing users

  lifecycle {
    ignore_changes = [external_id]
  }
}

# Add users to groups
resource "databricks_group_member" "user_groups" {
  for_each = {
    for mapping in flatten([
      for user in local.users_config.users : [
        for group_name in user.groups : {
          user_name = user.user_name
          group     = group_name
          key       = "${user.user_name}-${group_name}"
        }
      ]
    ]) : mapping.key => mapping
  }
  group_id  = databricks_group.groups[each.value.group].id
  member_id = databricks_user.users[each.value.user_name].id

  depends_on = [databricks_group.groups, databricks_user.users]
}

# Set catalog permissions using grants
resource "databricks_grants" "catalog_grants" {
  for_each = {
    for pair in flatten([
      for user in local.users_config.users : [
        for catalog, permission in user.catalog_permissions : {
          user_name  = user.user_name
          catalog    = catalog
          permission = permission
        }
        if contains(keys(data.databricks_catalog.existing_catalogs), catalog) || contains(keys(databricks_catalog.custom_catalogs), catalog)
      ]
    ]) : "${pair.user_name}-${pair.catalog}" => pair
  }
  catalog = each.value.catalog
  grant {
    principal  = databricks_user.users[each.value.user_name].id
    privileges = [each.value.permission]
  }

  depends_on = [databricks_catalog.custom_catalogs, databricks_user.users]
}