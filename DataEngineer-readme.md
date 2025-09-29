# Data Engineer Guide - Databricks Course

*"I want to learn Databricks through hands-on notebooks and work with data"*

## 🚀 Quick Start

### Prerequisites
1. **Sign up for Databricks Free Trial**: [databricks.com/try-databricks](https://databricks.com/try-databricks)
2. **Complete workspace setup** (no credit card required)

### Get Started in 3 Steps
```bash
# 1. Access your Databricks workspace via browser
# 2. Navigate to: Workspace → Shared → Import
# 3. Import notebooks from this repository's course/notebooks/ directory
# 4. Start with: 01_week/00_databricks_fundamentals.py
```

## 📚 Course Structure (5 Weeks, 16 Notebooks)

| Week | Focus | Notebooks | What You'll Learn |
|------|-------|-----------|-------------------|
| **1** | Databricks Fundamentals | 4 | Platform mastery, Unity Catalog, cluster management |
| **2** | Data Ingestion | 4 | Files, APIs, databases, cloud storage patterns |  
| **3** | Data Transformations | 3 | Advanced Spark operations, window functions |
| **4** | End-to-End Workflows | 2 | Complete pipeline development |
| **5** | Job Orchestration | 3 | Production automation and monitoring |

## 🎯 Learning Paths

### 🟢 New to Databricks (2-3 weeks)
- Week 1: Complete all notebooks to understand platform
- Week 2: Focus on file ingestion with sample datasets

### 🟡 Know Spark/Data Engineering (2 weeks)  
- Week 3: Master complex transformations and analytics
- Week 4: Build complete end-to-end pipelines

### 🔴 Production Ready (1 week)
- Week 5: Job orchestration and workflow automation

## 📝 Working with Notebooks

### Option 1: Direct Workspace (Simplest)
1. **Upload notebooks**: Import all from `course/notebooks/` to your workspace
2. **Upload datasets**: Import sample data from `course/datasets/`
3. **Create catalogs**: Follow notebook instructions for manual catalog creation
4. **Start learning**: Begin with Week 1

### Option 2: Sync from Local Repository
```bash
# 1. Clone repository
git clone <repo-url> && cd databricks-infra

# 2. Install Databricks CLI  
curl -fsSL https://raw.githubusercontent.com/databricks/setup-cli/main/install.sh | sh
databricks auth login

# 3. Sync notebooks to workspace
databricks workspace import-dir course/notebooks /Shared/course-notebooks --overwrite
```

## 🗂️ Course Content Details

### Week 1: Foundation & Platform Mastery
- `00_databricks_fundamentals.py` - Platform architecture and best practices
- `01_unity_catalog_deep_dive.py` - Data governance and permissions  
- `02_cluster_management.py` - Compute optimization and cost management
- `03_spark_on_databricks.py` - Distributed computing and performance

### Week 2: Data Ingestion Mastery  
- `04_file_ingestion.py` - CSV, JSON, Parquet with Delta Lake integration
- `05_api_ingest.py` - REST APIs, authentication, real-time streaming
- `06_database_ingest.py` - JDBC connections and database integration
- `07_s3_ingest.py` - Cloud storage patterns and data lakehouse

### Week 3: Advanced Transformations
- `08_simple_transformations.py` - Data cleaning and basic operations
- `09_window_transformations.py` - Advanced analytics with window functions  
- `10_aggregations.py` - Complex grouping and statistical operations

### Week 4: Production Workflows
- `11_file_to_aggregation.py` - Complete file processing pipeline
- `12_api_to_aggregation.py` - Real-time API data to insights

### Week 5: Automation & Orchestration
- `13_create_job_with_notebook.py` - Scheduled notebook execution
- `14_create_job_with_wheel.py` - Python package deployment
- `15_orchestrate_tasks_in_job.py` - Multi-task workflow orchestration

## 💡 Tips for Success

- **Start with Week 1** even if you know Spark - Databricks has unique features
- **Run every code cell** - hands-on practice is key
- **Modify the code** - experiment with different parameters
- **Use sample datasets** provided in `course/datasets/`
- **Create your own data** to test different scenarios

## ❓ Need Help?

- **Notebook issues**: Check troubleshooting sections within each notebook
- **Databricks questions**: Refer to [Databricks documentation](https://docs.databricks.com/)
- **Course issues**: Use GitHub Issues in this repository

**Ready to start your Databricks journey? Begin with Week 1!** 🚀