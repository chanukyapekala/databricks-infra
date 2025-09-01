# main.tf

# Data source for current user
data "databricks_current_user" "me" {}

locals {
  # Create map of group names to display names
  group_names = {
    for group_name, display_name in var.allowed_groups :
    group_name => display_name
    if contains(distinct(flatten([for user in local.users_config.users : user.groups])), group_name)
  }
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

# Create or update users
resource "databricks_user" "users" {
  for_each     = { for user in local.users_config.users : user.user_name => user }
  user_name    = each.value.user_name
  display_name = each.value.display_name
  force        = true

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