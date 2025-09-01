# Databricks notebook source
# MAGIC %md
# MAGIC # Hello World Notebook
# MAGIC
# MAGIC This is a simple notebook created by Terraform.

# COMMAND ----------

print("Hello from Databricks!")

# COMMAND ----------

# MAGIC %md
# MAGIC ## Sample DataFrame Creation

# COMMAND ----------

from pyspark.sql import SparkSession
spark = SparkSession.builder.getOrCreate()

data = [(1, "Hello"), (2, "World")]
df = spark.createDataFrame(data, ["id", "value"])
df.show()