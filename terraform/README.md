# Terraform Configuration

This directory contains Terraform configuration for managing Databricks infrastructure.

## Configuration Variables

### Resource Creation Controls

The following variables control whether certain resources are created or referenced:

#### `create_catalogs` (default: `true`)
- **`true`**: Create catalogs via Terraform (requires Databricks Premium/Enterprise)
- **`false`**: Reference existing catalogs via data sources (for Free Edition)

#### `create_groups` (default: `true`) 
- **`true`**: Create groups via Terraform
- **`false`**: Reference existing groups via data sources

#### `create_schemas` (default: `true`)
- **`true`**: Create schemas via Terraform
- **`false`**: Reference existing schemas via data sources

## Usage Scenarios

### Local Development (Default)
For local development where you have full control:
```bash
terraform plan    # Uses defaults: create_catalogs=true, create_groups=true
terraform apply
```

### CI/CD with Free Edition
For automated deployment in Databricks Free Edition:
```bash
terraform plan -var="create_catalogs=false" -var="create_groups=false" -var="create_schemas=false"
terraform apply -var="create_catalogs=false" -var="create_groups=false" -var="create_schemas=false"
```

### Mixed Environment
Create some resources, reference others:
```bash
terraform plan -var="create_catalogs=false" -var="create_groups=true"
terraform apply -var="create_catalogs=false" -var="create_groups=true"
```

## Prerequisites by Scenario

### When `create_catalogs=false`
You must manually create these catalogs in Databricks UI:
- `sales_dev`
- `sales_prod`
- `marketing_dev`
- `marketing_prod`

### When `create_groups=false`
You must ensure these groups exist in Databricks:
- `platform_admins` (mapped from `admins`)
- `pilot`

### When `create_schemas=false`
You must ensure these schemas exist in their respective catalogs:
- `bronze`, `silver`, `gold` in all catalogs
- `experiments` in `marketing_dev` catalog

## Troubleshooting

### Error: "cannot create catalog"
```
Error: cannot create catalog: Please use the UI to create a catalog with Default Storage.
```
**Solution**: Set `create_catalogs=false` and create catalogs manually in UI.

### Error: "Group with name X already exists"
```
Error: cannot create group: Group with name platform_admins already exists.
```
**Solution**: Set `create_groups=false` and reference existing groups.

### Error: "Schema X already exists"
```
Error: cannot create schema: Schema 'bronze' already exists
```
**Solution**: Set `create_schemas=false` and reference existing schemas.

## File Structure

- `variables.tf` - Input variables and configuration options
- `main.tf` - Users, notebooks, directories, and datasets
- `groups.tf` - Group management (conditional creation)
- `catalogs.tf` - Catalog and schema management (conditional creation)
- `locals.tf` - Dynamic configuration processing
- `outputs.tf` - Resource references for external consumption
- `versions.tf` - Provider configuration