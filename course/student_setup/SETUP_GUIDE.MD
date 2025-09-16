# Data Engineering Course Setup

## Prerequisites
- Databricks Free Edition account
- Terraform installed
- Databricks CLI installed

## Setup Steps
1. Clone this repo
2. Copy `course/terraform.tfvars.example` to `terraform/terraform.tfvars`
3. Edit `terraform.tfvars` with your details
4. Run `databricks auth login`
5. Create your catalog manually in Databricks UI
6. Run `terraform apply`
7. Open the notebook in `course/notebooks/01_getting_started.py`

That's it!