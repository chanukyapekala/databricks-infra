variable "notebook_language" {
  description = "The language of the notebook"
  type        = string
  default     = "PYTHON"
}

variable "notebook_subdirs" {
  type    = list(string)
  default = ["0x_week", "01_week", "02_week"]
}

variable "notebooks" {
  type = map(string)
  default = {
    "0x_week/00_databricks_fundamentals.py" = "PYTHON"
    "0x_week/01_unity_catalog_deep_dive.py" = "PYTHON"
    "0x_week/02_cluster_management.py"      = "PYTHON"
    "0x_week/03_spark_on_databricks.py"     = "PYTHON"
    "01_week/01_getting_started.py"        = "PYTHON"
    "02_week/02_data_ingestion.py"         = "PYTHON"
  }
}
