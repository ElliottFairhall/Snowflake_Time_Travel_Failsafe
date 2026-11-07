-- Accidentally drop a table
-- DROP TABLE tt_analytics.marts.dim_customers;

-- Restore it
-- UNDROP TABLE tt_analytics.marts.dim_customers;

-- Restore a dropped schema
-- UNDROP SCHEMA tt_analytics.marts;

-- Restore a dropped database
-- UNDROP DATABASE tt_analytics;

-- Rename the replacement table if one was re-created
-- ALTER TABLE tt_analytics.marts.dim_customers RENAME TO tt_analytics.marts.dim_customers_v2;

-- Restore the original
-- UNDROP TABLE tt_analytics.marts.dim_customers;
