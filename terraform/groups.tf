# Create all groups
resource "databricks_group" "groups" {
  for_each = toset(local.group_names)
  display_name = each.key == "admins" ? "platform_admins" : (
    each.key == "users" ? "platform_users" : each.key
  )
}

# Add users to their groups
resource "databricks_group_member" "user_groups" {
  for_each = {
    for mapping in local.user_group_mappings : "${mapping.user}-${mapping.group}" => {
      user = mapping.user
      group = mapping.group
    }
  }

  group_id  = databricks_group.groups[each.value.group].id
  member_id = databricks_user.users[each.value.user].id

  depends_on = [
    databricks_user.users,
    databricks_group.groups
  ]
}

# Debug output to verify mappings
output "group_names" {
  value = local.group_names
}

output "user_group_mappings" {
  value = local.user_group_mappings
}