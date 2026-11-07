-- Clone a table as it was yesterday
CREATE TABLE tt_analytics.staging.customers_backup
CLONE tt_analytics.marts.dim_customers
AT (TIMESTAMP => '2026-03-24 00:00:00'::TIMESTAMP_NTZ);

-- Clone an entire schema as it was 2 hours ago
CREATE SCHEMA analytics.marts_backup
CLONE tt_analytics.marts
AT (OFFSET => -7200);

-- Clone a database at a specific point
CREATE DATABASE analytics_backup
CLONE analytics
AT (TIMESTAMP => '2026-03-24 12:00:00'::TIMESTAMP_NTZ);
