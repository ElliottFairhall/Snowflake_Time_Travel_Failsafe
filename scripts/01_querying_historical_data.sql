-- Query data at a specific timestamp
SELECT *  -- noqa: AM04
FROM tt_analytics.marts.dim_customers
AT (TIMESTAMP => '2026-03-24 14:00:00'::TIMESTAMP_NTZ);

-- Query data as it was 30 minutes ago
SELECT *  -- noqa: AM04
FROM tt_analytics.marts.dim_customers
AT (OFFSET => -1800);  -- offset in seconds

-- Query data just before a specific query was executed
SELECT *  -- noqa: AM04
FROM tt_analytics.marts.dim_customers
BEFORE (STATEMENT => '01b2c3d4-0000-0000-0000-000000000001');

-- Compare current data with data from 1 hour ago
SELECT
    current_data.customer_id,
    current_data.segment AS current_segment,
    historical_data.segment AS previous_segment
FROM tt_analytics.marts.dim_customers AS current_data
INNER JOIN tt_analytics.marts.dim_customers
    AT (OFFSET => -3600) AS historical_data
    ON current_data.customer_id = historical_data.customer_id
WHERE current_data.segment != historical_data.segment;
