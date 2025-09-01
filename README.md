# Databricks Free Edition Infrastructure

Infrastructure as Code (IaC) for Databricks (Free Edition) resources using Terraform.

## Overview

This repository manages Databricks infrastructure components including catalogs, schemas, and their access controls.

## File Structure

### Terraform Files
- `providers.tf` - Databricks provider configuration
- `variables.tf` - Input variables and environment configurations
- `main.tf` - Resource definitions for catalogs and schemas
- `locals.tf` - Local variables for resource naming and configuration
- `outputs.tf` - Output definitions for resource references

### Python Files
- `scripts/validate.py` - Validates infrastructure configuration
- `scripts/utils.py` - Helper functions for infrastructure management

## Authentication

Authentication is handled through the Databricks CLI:

1. Install Databricks CLI:
```bash
pip install databricks-cli

2. configure CLI:
```bash
databricks auth login
```

## Catalogs
Databricks Free edition supports to create catalog through UI only. So, we need to create catalog manually through UI, import the catalogs to terraform state and add schemas + grants accordingly.
To import an existing catalog into Terraform state, use the following command:
```bash
terraform import 'databricks_catalog.custom_catalogs["<catalog_name>"]' <catalog_name>
```
Replace `<catalog_resource_name>` with the name you want to use in your Terraform configuration and `<catalog_name>` with the actual name of the catalog in Databricks.
For example, if you have a catalog named `marketing_dev` and you want to import it with the resource name `marketing_dev`, the command would be:
```bash
terraform import 'databricks_catalog.custom_catalogs["marketing_dev"]' marketing_dev
```