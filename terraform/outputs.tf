output "notebook_paths" {
  description = "Paths to all created notebooks"
  value       = {
    for key, notebook in databricks_notebook.notebooks : key => notebook.path
  }
}

output "current_user" {
  description = "Current Databricks user"
  value       = data.databricks_current_user.me.user_name
}

output "notebook_base_path" {
  description = "Base path for all notebooks"
  value       = databricks_directory.shared_notebooks.path
}