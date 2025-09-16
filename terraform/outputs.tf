output "notebook_path" {
  description = "Path to the created notebook"
  value       = databricks_notebook.hello_world.path
}

output "current_user" {
  description = "Current Databricks user"
  value       = data.databricks_current_user.me.user_name
}