# Databricks Learning Platform

A comprehensive learning platform for Databricks, featuring a structured 5-week course with hands-on notebooks covering everything from platform fundamentals to advanced job orchestration.

## 🎯 What You'll Learn

This course takes you from Databricks beginner to proficient practitioner through 16 hands-on notebooks:

- **Week 1**: Master Databricks fundamentals, Unity Catalog, and cluster management
- **Week 2**: Learn data ingestion from files, APIs, databases, and cloud storage
- **Week 3**: Build advanced data transformations and aggregations
- **Week 4**: Create end-to-end data processing workflows
- **Week 5**: Orchestrate complex jobs and automate data pipelines

## 🚀 Quick Start

### Prerequisites
- Access to a Databricks workspace (Free Edition supported)
- Basic Python knowledge
- Familiarity with SQL concepts

### Accessing the Course
1. **Log into your Databricks workspace**
2. **Navigate to the course materials**:
   ```
   /Shared/terraform-managed/course/notebooks/
   ```
3. **Start with Week 1**:
   ```
   01_week/00_databricks_fundamentals.py
   ```

### Course Structure
```
📁 course/notebooks/
├── 📂 01_week/          # Databricks Fundamentals (4 notebooks)
├── 📂 02_week/          # Data Ingestion (4 notebooks)
├── 📂 03_week/          # Data Transformations (3 notebooks)
├── 📂 04_week/          # End-to-End Workflows (2 notebooks)
└── 📂 05_week/          # Job Orchestration (3 notebooks)
```

## 📚 Detailed Course Outline

### Week 1: Foundation & Platform Mastery
- **00_databricks_fundamentals** - Platform architecture, runtime, and best practices
- **01_unity_catalog_deep_dive** - Data governance, catalogs, and permissions
- **02_cluster_management** - Compute optimization and cost management
- **03_spark_on_databricks** - Distributed computing and performance tuning

### Week 2: Data Ingestion Mastery
- **04_file_ingestion** - Working with CSV, JSON, Parquet files
- **05_api_ingest** - REST API integration and real-time data
- **06_database_ingest** - JDBC connections and database integration
- **07_s3_ingest** - Cloud storage patterns and data lakehouse

### Week 3: Advanced Transformations
- **08_simple_transformations** - Data cleaning and basic operations
- **09_window_transformations** - Advanced analytics with window functions
- **10_aggregations** - Complex grouping and statistical operations

### Week 4: Production Workflows
- **11_file_to_aggregation** - Complete file processing pipeline
- **12_api_to_aggregation** - Real-time API data to insights

### Week 5: Automation & Orchestration
- **13_create_job_with_notebook** - Scheduled notebook execution
- **14_create_job_with_wheel** - Python package deployment
- **15_orchestrate_tasks_in_job** - Multi-task workflow orchestration

## 🎓 Learning Path

### Beginner Track (Weeks 1-2)
Start here if you're new to Databricks or distributed computing.

### Intermediate Track (Weeks 3-4)
Jump here if you're comfortable with Spark and want to focus on data engineering patterns.

### Advanced Track (Week 5)
Perfect for those ready to build production data pipelines and automation.

## 🔧 Additional Resources

### Sample Datasets
Course includes realistic sample datasets for hands-on practice:
- E-commerce transaction data
- API response examples
- Time-series data for analytics

### Deployment
This course infrastructure is managed with Terraform. For technical deployment details, see [CLAUDE.md](./CLAUDE.md).

## 🆘 Getting Help

### Common Issues
1. **Can't find notebooks?** Check that you're in the correct workspace and have access to `/Shared/` folders
2. **Data access problems?** Verify your Unity Catalog permissions and catalog access

### Support Channels
- **Technical Issues**: Review [CLAUDE.md](./CLAUDE.md) for developer guidance
- **Course Content**: Each notebook includes troubleshooting sections
- **Platform Help**: Consult Databricks documentation for platform-specific questions

## 📈 Course Progression

Track your progress through the course:

- [ ] **Week 1 Complete** - Understand Databricks fundamentals
- [ ] **Week 2 Complete** - Master data ingestion patterns  
- [ ] **Week 3 Complete** - Build complex transformations
- [ ] **Week 4 Complete** - Create end-to-end workflows
- [ ] **Week 5 Complete** - Orchestrate production pipelines

## 🌟 Next Steps

After completing this course, you'll be ready to:
- Build production data pipelines in Databricks
- Implement data lakehouse architectures
- Optimize Spark jobs for performance and cost
- Create automated data workflows
- Apply data governance and security best practices

Happy learning! 🚀