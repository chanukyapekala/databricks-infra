variable "workspace_name" {
  description = "Name prefix for Databricks resources"
  type        = string
  default     = "my-databricks"
}

variable "notebook_language" {
  description = "The language of the notebook"
  type        = string
  default     = "PYTHON"
}

variable "allowed_groups" {
  description = "Map of allowed groups and their display names"
  type        = map(string)
  default     = {
    "data_scientists" = "Data Scientists"
    "data_engineers"  = "Data Engineers"
    "analysts"        = "Analysts"
    "admins"          = "Admins"
    "developers"      = "Developers"
  }
}

variable "users" {
  description = "List of users to create in Databricks workspace"
  type = list(object({
    user_name    = string
    display_name = string
    groups       = list(string)
  }))
  default = []
}