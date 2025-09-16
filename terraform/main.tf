# Data source for current user
data "databricks_current_user" "me" {}

# Local variables for configuration
locals {
  # Create map of group names to display names
  group_names = {
    for group_name, display_name in var.allowed_groups :
    group_name => display_name
    if contains(distinct(flatten([for user in var.users : user.groups])), group_name)
  }


  # Get all Python files recursively from notebooks directory
  notebook_files = fileset("${path.module}/course/notebooks", "**/*.py")

  # Create a map of notebook paths and their corresponding destination paths
  notebooks = {
    for file in local.notebook_files :
    file => replace(
      replace(file, "/", "_"),
      ".py",
      ""
    )
  }

  # Flatten user-group mappings
  user_group_mappings = flatten([
    for user in var.users : [
      for group_name in user.groups : {
        user_name = user.user_name
        group     = group_name
        key       = "${user.user_name}-${group_name}"
      }
    ]
  ])
}

# Create users from JSON file
resource "databricks_user" "users" {
  for_each     = { for user in local.users_config.users : user.user_name => user }
  user_name    = each.value.user_name
  display_name = each.value.display_name
  force        = true

  lifecycle {
    ignore_changes = [external_id]
  }
}

# Create base notebook directory
resource "databricks_directory" "shared_notebooks" {
  path = "/Shared/terraform-managed"
}

# Dynamically create notebooks
resource "databricks_notebook" "notebooks" {
  for_each       = local.notebooks
  path           = "${databricks_directory.shared_notebooks.path}/${each.value}"
  language       = var.notebook_language
  content_base64 = base64encode(file("${path.module}/course/notebooks/${each.key}"))
}

# Create groups
resource "databricks_group" "groups" {
  for_each     = local.group_names
  display_name = each.value
}

# Add users to groups
resource "databricks_group_member" "user_groups" {
  for_each = {
    for mapping in local.user_group_mappings : mapping.key => mapping
    if contains(keys(local.group_names), mapping.group)
  }

  group_id  = databricks_group.groups[each.value.group].id
  member_id = databricks_user.users[each.value.user_name].id

  depends_on = [databricks_group.groups, databricks_user.users]
}