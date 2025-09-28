variable "notebook_language" {
  description = "The language of the notebook"
  type        = string
  default     = "PYTHON"
}

variable "create_catalogs" {
  description = "Whether to create catalogs (set to false for Free Edition or CI/CD)"
  type        = bool
  default     = true
}

variable "create_groups" {
  description = "Whether to create groups (set to false if groups already exist)"
  type        = bool
  default     = true
}

variable "create_schemas" {
  description = "Whether to create schemas (set to false if schemas already exist)"
  type        = bool
  default     = true
}

variable "notebook_subdirs" {
  type    = list(string)
  default = ["01_week", "02_week", "03_week", "04_week", "05_week"]
}

variable "notebooks" {
  type = map(string)
  default = {
    # Week 1: Databricks Fundamentals
    "01_week/00_databricks_fundamentals.py" = "PYTHON"
    "01_week/01_unity_catalog_deep_dive.py" = "PYTHON"
    "01_week/02_cluster_management.py"      = "PYTHON"
    "01_week/03_spark_on_databricks.py"     = "PYTHON"
    
    # Week 2: Data Ingestion
    "02_week/04_file_ingestion.py"          = "PYTHON"
    "02_week/05_api_ingest.py"              = "PYTHON"
    "02_week/06_database_ingest.py"         = "PYTHON"
    "02_week/07_s3_ingest.py"               = "PYTHON"
    
    # Week 3: Data Transformations
    "03_week/08_simple_transformations.py"  = "PYTHON"
    "03_week/09_window_transformations.py"  = "PYTHON"
    "03_week/10_aggregations.py"            = "PYTHON"
    
    # Week 4: End-to-End Workflows
    "04_week/11_file_to_aggregation.py"     = "PYTHON"
    "04_week/12_api_to_aggregation.py"      = "PYTHON"
    
    # Week 5: Job Orchestration
    "05_week/13_create_job_with_notebook.py" = "PYTHON"
    "05_week/14_create_job_with_wheel.py"    = "PYTHON"
    "05_week/15_orchestrate_tasks_in_job.py" = "PYTHON"
  }
}
