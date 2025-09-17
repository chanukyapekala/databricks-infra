# Data source for current user
data "databricks_current_user" "me" {}

# Create users from JSON file
resource "databricks_user" "users" {
  for_each     = local.users_config
  user_name    = each.value.user_name
  display_name = each.value.display_name
  force        = true

  lifecycle {
    ignore_changes = [external_id]
  }
}

# Create base notebook directory
resource "databricks_directory" "course_root" {
  path             = "/Shared/terraform-managed/course"
  delete_recursive = true
}

# Create notebooks directory
resource "databricks_directory" "notebooks_dir" {
  path             = "${databricks_directory.course_root.path}/notebooks"
  depends_on       = [databricks_directory.course_root]
  delete_recursive = true
}

# Create datasets directory
resource "databricks_directory" "datasets_dir" {
  path       = "${databricks_directory.course_root.path}/datasets"
  depends_on = [databricks_directory.course_root]
}

# Upload notebooks
resource "databricks_notebook" "notebooks" {
  for_each        = local.notebooks
  path            = "${databricks_directory.notebooks_dir.path}/${dirname(each.key)}/${each.value}"
  language        = var.notebook_language
  content_base64  = fileexists("${path.module}/course/notebooks/${each.key}") ? base64encode(file("${path.module}/course/notebooks/${each.key}")) : base64encode("")
  depends_on      = [databricks_directory.notebooks_dir]
}