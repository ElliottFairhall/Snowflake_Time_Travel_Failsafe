# 🚀 Snowflake Time Travel & Fail-safe Tutorial

## 🎯 Learning Objectives

1. 🧠 Understand the concept of Time Travel and how it provides access to historical data within Snowflake.

2. 🛠️ Master querying, cloning, and restoring data at previous points in time.

3. 🔗 Learn the relationship between Time Travel, Fail-safe, and data retention policies.

## 📚 Table of Contents

- [🚀 Snowflake Time Travel & Fail-safe Tutorial](#-snowflake-time-travel--fail-safe-tutorial)
  - [🎯 Learning Objectives](#-learning-objectives)
  - [📚 Table of Contents](#-table-of-contents)
    - [🎉 Introduction](#-introduction)
    - [📝 Introduction to Time Travel](#-introduction-to-time-travel)
    - [🔍 Querying Historical Data](#-querying-historical-data)
    - [📋 Cloning at a Point in Time](#-cloning-at-a-point-in-time)
    - [♻️ Restoring Dropped Objects](#%EF%B8%8F-restoring-dropped-objects)
    - [🛡️ Fail-safe](#%EF%B8%8F-fail-safe)
    - [⚙️ Configuring Data Retention](#%EF%B8%8F-configuring-data-retention)
  - [💡 Tutorial](#-tutorial)
  - [🎈 Conclusion](#-conclusion)
  - [📖 Additional Resources](#-additional-resources)
  - [⚠️ Disclaimer](#%EF%B8%8F-disclaimer)

### 🎉 Introduction

Welcome to this tutorial on Time Travel and Fail-safe within Snowflake! This tutorial is designed to help you understand
and use Snowflake's built-in data protection features. By the end of this tutorial, you'll be able to confidently query
historical data, clone objects at previous points in time, and recover accidentally dropped tables. So, let's dive in!
🏊‍♀️

### 📝 Introduction to Time Travel

Time Travel is a Snowflake feature that allows you to access data as it existed at any point within a defined retention
period. This is particularly useful for:

- **Auditing**: Reviewing data as it was at a specific date and time.
- **Recovery**: Restoring data that was accidentally modified or deleted.
- **Analysis**: Comparing current data with historical snapshots.
- **Debugging**: Investigating when and how data changed.

Time Travel is enabled by default on all Snowflake accounts and does not require any additional configuration.

| Edition     | Default Retention | Maximum Retention |
| ----------- | ----------------- | ----------------- |
| Standard    | 1 day             | 1 day             |
| Enterprise+ | 1 day             | 90 days           |

### 🔍 Querying Historical Data

You can query data as it existed at a specific point in the past using the `AT` or `BEFORE` clauses.

```sql
-- Query data at a specific timestamp
SELECT *
FROM analytics.marts.dim_customers
AT (TIMESTAMP => '2026-03-24 14:00:00'::TIMESTAMP_NTZ);

-- Query data as it was 30 minutes ago
SELECT *
FROM analytics.marts.dim_customers
AT (OFFSET => -1800);  -- offset in seconds

-- Query data just before a specific query was executed
SELECT *
FROM analytics.marts.dim_customers
BEFORE (STATEMENT => '01b2c3d4-0000-0000-0000-000000000001');
```

This is especially powerful for investigating accidental changes:

```sql
-- Compare current data with data from 1 hour ago
SELECT
    current_data.customer_id,
    current_data.segment AS current_segment,
    historical_data.segment AS previous_segment
FROM analytics.marts.dim_customers AS current_data
JOIN analytics.marts.dim_customers
    AT (OFFSET => -3600) AS historical_data
    ON current_data.customer_id = historical_data.customer_id
WHERE current_data.segment != historical_data.segment;
```

### 📋 Cloning at a Point in Time

Snowflake's zero-copy cloning can be combined with Time Travel to create a clone of a table, schema, or database as it
existed at a previous point in time.

```sql
-- Clone a table as it was yesterday
CREATE TABLE analytics.staging.customers_backup
CLONE analytics.marts.dim_customers
AT (TIMESTAMP => '2026-03-24 00:00:00'::TIMESTAMP_NTZ);

-- Clone an entire schema as it was 2 hours ago
CREATE SCHEMA analytics.marts_backup
CLONE analytics.marts
AT (OFFSET => -7200);

-- Clone a database at a specific point
CREATE DATABASE analytics_backup
CLONE analytics
AT (TIMESTAMP => '2026-03-24 12:00:00'::TIMESTAMP_NTZ);
```

Zero-copy cloning means only the metadata is duplicated initially — storage costs only accrue as the clone diverges from
the original.

### ♻️ Restoring Dropped Objects

If a table, schema, or database is accidentally dropped, you can restore it using the `UNDROP` command — provided it is
still within the Time Travel retention period.

```sql
-- Accidentally drop a table
DROP TABLE analytics.marts.dim_customers;

-- Restore it
UNDROP TABLE analytics.marts.dim_customers;

-- Restore a dropped schema
UNDROP SCHEMA analytics.marts;

-- Restore a dropped database
UNDROP DATABASE analytics;
```

If you have already created a new object with the same name, you can rename it first and then restore the original:

```sql
-- Rename the replacement table
ALTER TABLE analytics.marts.dim_customers RENAME TO analytics.marts.dim_customers_v2;

-- Restore the original
UNDROP TABLE analytics.marts.dim_customers;
```

### 🛡️ Fail-safe

Fail-safe is a non-configurable, Snowflake-managed data protection layer that provides an additional 7 days of data
recovery **after** the Time Travel retention period has expired. Key points:

- Fail-safe is available only on **permanent** tables (not transient or temporary tables).
- Data in Fail-safe can only be recovered by Snowflake Support — it is not accessible via SQL.
- Fail-safe incurs additional storage costs.
- It is designed for disaster recovery, not routine data access.

```
|--- Time Travel (1-90 days) ---|--- Fail-safe (7 days) ---|
     User-accessible via SQL          Snowflake Support only
```

### ⚙️ Configuring Data Retention

You can configure the Time Travel retention period at the account, database, schema, or table level.

```sql
-- Set retention at the table level
ALTER TABLE analytics.marts.dim_customers
SET DATA_RETENTION_TIME_IN_DAYS = 30;

-- Set retention at the schema level
ALTER SCHEMA analytics.marts
SET DATA_RETENTION_TIME_IN_DAYS = 14;

-- Set retention at the database level
ALTER DATABASE analytics
SET DATA_RETENTION_TIME_IN_DAYS = 7;

-- Check current retention setting
SHOW TABLES LIKE 'DIM_CUSTOMERS' IN SCHEMA analytics.marts;
```

To reduce storage costs for non-critical data, consider using **transient** tables, which have a maximum retention of 1
day and no Fail-safe:

```sql
CREATE TRANSIENT TABLE analytics.staging.temp_load (
    id INTEGER,
    payload VARIANT,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
```

## 💡 Tutorial

In this tutorial, we'll be exploring how to use Time Travel to query historical data, create point-in-time clones, and
recover accidentally dropped objects. We'll also examine the relationship between Time Travel, Fail-safe, and storage
costs to help you design an effective data retention strategy.

By the end of this tutorial, you'll have gained a comprehensive understanding of how to leverage Snowflake's built-in
data protection features to safeguard your data and recover from mistakes with confidence.

## 🎈 Conclusion

In conclusion, Time Travel and Fail-safe are powerful data protection features that are built into Snowflake by default.
Time Travel allows you to query, clone, and restore data at any point within your retention period, whilst Fail-safe
provides an additional safety net for disaster recovery. Together, they ensure that your data is protected against
accidental changes, deletions, and system failures — giving you peace of mind and the confidence to work with your data
platform.

## 📖 Additional Resources

- [Time Travel Documentation](https://docs.snowflake.com/en/user-guide/data-time-travel)
- [Fail-safe Documentation](https://docs.snowflake.com/en/user-guide/data-failsafe)
- [Understanding Storage Costs](https://docs.snowflake.com/en/user-guide/data-cdp-storage-costs)
- [UNDROP Command Reference](https://docs.snowflake.com/en/sql-reference/sql/undrop-table)

## ⚠️ Disclaimer

Please note that whilst we strive to keep this tutorial up-to-date, Snowflake's features and capabilities may change
over time. Always refer to the [official Snowflake documentation](https://docs.snowflake.com/) for the most accurate and
current information.
