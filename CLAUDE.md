# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Terraform-based Infrastructure as Code (IaC) repository for managing Databricks Free Edition resources. The infrastructure manages catalogs, schemas, users, groups, notebooks, and their access controls within a Databricks workspace. It includes a comprehensive course structure with 16 notebooks organized across 5 weeks covering Databricks fundamentals through advanced job orchestration.

## Core Architecture

### Terraform Structure
- **Provider Configuration**: `terraform/versions.tf` - Databricks provider ~> 1.29, uses 'dev' profile
- **Resource Definitions**: Split across multiple files for modularity:
  - `terraform/main.tf` - Users, notebooks, directories, and datasets
  - `terraform/groups.tf` - Groups and group memberships
  - `terraform/catalogs.tf` - Catalogs, schemas, and their permission grants
  - `terraform/variables.tf` - Input variables with notebook and directory definitions
  - `terraform/locals.tf` - Dynamic configuration processing and schema generation
  - `terraform/outputs.tf` - Resource references for external consumption

### Course Structure
- **Notebooks**: Organized in `course/notebooks/` with 5 weekly modules (16 notebooks total)
- **Datasets**: Sample data files in `course/datasets/` for hands-on exercises

### Configuration Data
- **User Management**: `terraform/users.json` contains user definitions with group assignments and permissions
- **Catalog Configuration**: Defined in `terraform/locals.tf` as a list of catalog names
- **Schema Configuration**: Dynamic generation with standard schemas (bronze, silver, gold) and custom schema overrides per catalog
- **Notebook Configuration**: All notebooks defined in `terraform/variables.tf` with week-based organization

### Resource Dependencies
Key dependency chain: Catalogs → Schemas → Permission Grants
- Catalogs must be created before schemas
- Permission grants depend on both resources and users being available
- Notebooks depend on directory structure being created first

## Development Commands

### Terraform Operations
```bash
# Initialize Terraform (run once or when providers change)
terraform init

# Plan infrastructure changes
terraform plan

# Apply infrastructure changes
terraform apply

# Import existing Databricks catalogs (Free Edition requirement)
terraform import 'databricks_catalog.custom_catalogs["<catalog_name>"]' <catalog_name>

# Destroy infrastructure
terraform destroy
```

### Authentication Setup
```bash
# Install Databricks CLI
pip install databricks-cli

# Configure authentication
databricks auth login
```

## Key Constraints and Design Decisions

### Databricks Free Edition Limitations
- Catalogs cannot be created via Terraform - must be manually created in UI first, then imported
- Uses OPEN isolation mode for catalogs
- Fixed storage root for catalog storage

### Configuration Pattern
- User configurations externalized to `users.json` for easier management
- Dynamic schema generation supports both standard and custom schema patterns
- Group creation is based on actual group usage in user configurations

### Permission Model
- Hardcoded permissions currently grant specific privileges to `chanukya.pekala@gmail.com`
- Catalog grants: USE_CATALOG, CREATE_SCHEMA
- Schema grants: USE_SCHEMA, CREATE_TABLE

## Working with This Repository

### Adding New Users
1. Edit `users.json` to add user definition with groups and permissions
2. Ensure referenced groups exist in `variables.tf` allowed_groups map
3. Run `terraform plan` and `terraform apply`

### Adding New Catalogs
1. Manually create catalog in Databricks UI
2. Add catalog name to `catalog_config` list in `locals.tf`
3. Import catalog: `terraform import 'databricks_catalog.custom_catalogs["new_catalog"]' new_catalog`
4. Update permission grants in `catalogs.tf` if needed
5. Run `terraform plan` and `terraform apply`

### Adding Custom Schemas
1. Add catalog-specific schema configuration to `custom_schemas` map in `locals.tf`
2. Run `terraform plan` and `terraform apply`

## Course Curriculum

The course is organized into 5 weeks with progressive learning objectives:

### Week 1: Databricks Fundamentals (4 notebooks)
- `00_databricks_fundamentals.py` - Platform overview, architecture, and basic concepts
- `01_unity_catalog_deep_dive.py` - Data governance, catalogs, schemas, and permissions
- `02_cluster_management.py` - Compute resources, sizing, optimization, and cost management
- `03_spark_on_databricks.py` - Distributed computing, DataFrames, performance tuning

### Week 2: Data Ingestion (4 notebooks)
- `04_file_ingestion.py` - File-based data ingestion patterns
- `05_api_ingest.py` - REST API data ingestion and processing
- `06_database_ingest.py` - Database connectivity and data extraction
- `07_s3_ingest.py` - Cloud storage integration and data lakehouse patterns

### Week 3: Data Transformations (3 notebooks)
- `08_simple_transformations.py` - Basic data transformation operations
- `09_window_transformations.py` - Advanced window functions and analytics
- `10_aggregations.py` - Complex aggregation patterns and optimization

### Week 4: End-to-End Workflows (2 notebooks)
- `11_file_to_aggregation.py` - Complete pipeline from files to analytics
- `12_api_to_aggregation.py` - End-to-end API data processing workflow

### Week 5: Job Orchestration (3 notebooks)
- `13_create_job_with_notebook.py` - Notebook-based job creation and scheduling
- `14_create_job_with_wheel.py` - Python package deployment and execution
- `15_orchestrate_tasks_in_job.py` - Multi-task job orchestration and dependencies

## Notebook Management

### Adding New Notebooks
1. Create the notebook file in the appropriate `course/notebooks/XX_week/` directory
2. Update `terraform/variables.tf` to include the new notebook in both:
   - `notebook_subdirs` (if new week directory)
   - `notebooks` map with path and language
3. Run `terraform plan` and `terraform apply` to deploy

### Modifying Notebook Structure
1. Move/rename notebook files as needed in `course/notebooks/`
2. Update `terraform/variables.tf` to match the new structure
3. Ensure all paths in the `notebooks` map are correct
4. Verify with `terraform plan` before applying

### Course Deployment
- All notebooks deployed to: `/Shared/terraform-managed/course/notebooks/`
- Directory structure preserved: `01_week/`, `02_week/`, etc.
- Datasets available at: `/Shared/terraform-managed/course/datasets/`