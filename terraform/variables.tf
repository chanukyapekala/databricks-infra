variable "notebook_language" {
  description = "The language of the notebook"
  type        = string
  default     = "PYTHON"
}

variable "notebook_subdirs" {
  type    = list(string)
  default = ["01_week", "02_week"]
}

variable "notebooks" {
  type = map(string)
  default = {
    "01_week/01_getting_started.py" = "PYTHON"
    "02_week/02_data_ingestion.py"  = "PYTHON"
  }
}
