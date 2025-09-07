# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Terraform-based Infrastructure as Code (IaC) repository for managing Databricks Free Edition resources. The infrastructure manages catalogs, schemas, users, groups, and their access controls within a Databricks workspace.

## Core Architecture

### Terraform Structure
- **Provider Configuration**: `versions.tf` - Databricks provider ~> 1.29, uses 'dev' profile
- **Resource Definitions**: Split across multiple files for modularity:
  - `main.tf` - Users, groups, notebooks, and group memberships
  - `catalogs.tf` - Catalogs, schemas, and their permission grants
  - `variables.tf` - Input variables with sensible defaults
  - `locals.tf` - Dynamic configuration processing and schema generation
  - `outputs.tf` - Resource references for external consumption

### Configuration Data
- **User Management**: `users.json` contains user definitions with group assignments and permissions
- **Catalog Configuration**: Defined in `locals.tf` as a list of catalog names
- **Schema Configuration**: Dynamic generation with standard schemas (bronze, silver, gold) and custom schema overrides per catalog

### Resource Dependencies
Key dependency chain: Catalogs → Schemas → Permission Grants
- Catalogs must be created before schemas
- Permission grants depend on both resources and users being available

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

### Template Management
- Notebook templates stored in `templates/` directory
- `hello-world.py` template deployed to `/Shared/terraform-managed/hello-world`