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

-- Create a transient table to save retention costs
CREATE TRANSIENT TABLE analytics.staging.temp_load (
    id INTEGER,
    payload VARIANT,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
