-- Accidentally drop a table
-- DROP TABLE analytics.marts.dim_customers;

-- Restore it
-- UNDROP TABLE analytics.marts.dim_customers;

-- Restore a dropped schema
-- UNDROP SCHEMA analytics.marts;

-- Restore a dropped database
-- UNDROP DATABASE analytics;

-- Rename the replacement table if one was re-created
-- ALTER TABLE analytics.marts.dim_customers RENAME TO analytics.marts.dim_customers_v2;

-- Restore the original
-- UNDROP TABLE analytics.marts.dim_customers;
