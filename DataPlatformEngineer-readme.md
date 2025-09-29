# Data Platform Engineer Guide - Infrastructure Management

*"I want to manage Databricks infrastructure with Terraform and control the full stack"*

## 🚀 Quick Setup

### Prerequisites
1. **Sign up for Databricks Free Trial**: [databricks.com/try-databricks](https://databricks.com/try-databricks)
2. **Get workspace URL** and **create Personal Access Token**:
   - User Settings → Developer → Access Tokens → Generate New Token

### Full Stack Setup
```bash
# 1. Clone and setup environment
git clone <repo-url> && cd databricks-infra

# 2. Install Poetry and dependencies
curl -sSL https://install.python-poetry.org | python3 -
poetry install

# 3. Setup development tools
poetry shell
pre-commit install

# 4. Configure Databricks CLI
brew tap databricks/tap && brew install databricks  # macOS
databricks auth login  # Use your workspace URL and token

# 5. Initialize Terraform
cd terraform && terraform init
```

## 🏗️ Infrastructure Architecture

```
databricks-infra/
├── 📁 terraform/           # Infrastructure as Code
│   ├── main.tf            # Users, notebooks, directories
│   ├── catalogs.tf        # Unity Catalog management
│   ├── groups.tf          # User groups and permissions
│   ├── variables.tf       # Configuration options
│   └── users.json         # User definitions and group assignments
├── 📁 course/             # Learning materials (managed by Terraform)
└── 📁 src/                # Python CLI tools
```

## ⚡ Deployment Modes

### Local Development (Full Control)
```bash
# Creates all resources including catalogs and groups
terraform plan
terraform apply
```

### CI/CD Mode (Existing Infrastructure)
```bash
# Uses existing catalogs/groups, only manages notebooks and permissions
terraform plan -var="create_catalogs=false" -var="create_groups=false"
terraform apply -var="create_catalogs=false" -var="create_groups=false"
```

## 🔧 Managing Infrastructure

### Catalogs (Databricks Free Edition Workflow)
Due to Free Edition limitations, catalogs must be created manually first:

1. **Create catalog in UI**: Databricks workspace → Data → Create Catalog
2. **Import to Terraform**:
   ```bash
   terraform import 'databricks_catalog.custom_catalogs["my_catalog"]' my_catalog
   ```
3. **Terraform manages schemas and permissions automatically**

### Users and Groups
Edit `terraform/users.json`:
```json
{
  "users": [
    {
      "email": "user@company.com",
      "groups": ["platform_users"],
      "permissions": {
        "catalogs": ["analytics_catalog", "ml_catalog"]
      }
    }
  ]
}
```

Then apply:
```bash
terraform apply
```

### Custom Schema Management
Edit `terraform/locals.tf` to customize schema patterns:
```hcl
custom_schemas = {
  "analytics_catalog" = ["staging", "marts", "metrics"]
  "ml_catalog" = ["features", "models", "experiments"]
}
```

## 🛠️ CLI Commands

### Project Management
```bash
poetry run python -m src.cli status        # Project health check
poetry run generate-datasets               # Create sample data
poetry run validate-notebooks              # Validate all notebooks
```

### Development Workflow
```bash
poetry run pytest                          # Run test suite
poetry run pre-commit run --all-files     # Quality checks
```

## 🌍 Environment Configuration

### Development Environment
```bash
export TF_VAR_create_catalogs=true
export TF_VAR_create_groups=true
terraform apply
```

### Production/CI Environment
```bash
export TF_VAR_create_catalogs=false  
export TF_VAR_create_groups=false
terraform apply
```

## 🚨 Troubleshooting

### Common Issues

**"Cannot create catalog" Error**
- **Solution**: Use Free Edition manual creation + import pattern
- Databricks Free Edition requires UI-based catalog creation

**"Group already exists" Error**
- **Solution**: Set `create_groups=false` and use data sources
- Groups may have been created in previous runs

**"Permission denied" Error**
- **Solution**: Ensure your token has admin privileges
- Check token scopes include workspace access

**Terraform State Issues**
```bash
# Reset specific resource
terraform state rm 'databricks_catalog.custom_catalogs["problematic_catalog"]'

# Reimport resource
terraform import 'databricks_catalog.custom_catalogs["catalog_name"]' catalog_name
```

## 🔄 CI/CD Integration

### GitHub Actions
The repository includes automated deployment via `.github/workflows/deploy.yml`:
- **Triggers**: Push to `main` or `bugfix/*` branches
- **Mode**: Uses existing catalogs/groups (`create_catalogs=false`)
- **Secrets**: Requires `DATABRICKS_HOST` and `DATABRICKS_TOKEN`

### Local vs CI Differences
| Aspect | Local Development | CI/CD |
|--------|------------------|-------|
| Catalog Creation | ✅ Can create | ❌ Uses existing |
| Group Creation | ✅ Can create | ❌ Uses existing |
| User Management | ✅ Full control | ✅ Full control |
| Notebook Deployment | ✅ Full control | ✅ Full control |

## 📋 Best Practices

1. **Always run `terraform plan` first** to review changes
2. **Use separate environments** for development and production
3. **Version control your `users.json`** changes
4. **Test locally before CI/CD deployment**
5. **Monitor Terraform state** for drift detection
6. **Keep tokens secure** - never commit to Git

## 🤝 Contributing

1. **Setup development environment**:
   ```bash
   poetry install --with dev,terraform,notebooks
   pre-commit install
   ```

2. **Quality checks before commit**:
   ```bash
   poetry run pre-commit run --all-files
   poetry run pytest
   poetry run validate-notebooks
   ```

**Ready to manage Databricks infrastructure? Start with the setup above!** 🔧