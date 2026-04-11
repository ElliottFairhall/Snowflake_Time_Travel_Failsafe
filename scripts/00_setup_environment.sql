-- =============================================================================
-- 00_SETUP_ENVIRONMENT
-- =============================================================================
-- Purpose:    Provision the necessary databases, schemas, and sample data
--             to serve as the foundation for the Time Travel tutorial.
-- =============================================================================

USE ROLE SYSADMIN;

-- 1. Create base DBs and Schemas
CREATE DATABASE IF NOT EXISTS ANALYTICS;
CREATE SCHEMA IF NOT EXISTS ANALYTICS.MARTS;
CREATE SCHEMA IF NOT EXISTS ANALYTICS.STAGING;

-- 2. Create and populate Customer dimension for Time Travel querying
CREATE OR REPLACE TABLE ANALYTICS.MARTS.DIM_CUSTOMERS (
    CUSTOMER_ID INT,
    CUSTOMER_NAME VARCHAR,
    SEGMENT VARCHAR
);

-- Note: To execute the scripts tracking changes over time, you should run the
-- below commands, wait some time (or modify records), and use Time Travel.
INSERT INTO ANALYTICS.MARTS.DIM_CUSTOMERS VALUES
    (1, 'Enterprise Corp', 'Enterprise'),
    (2, 'Mid-Market Limited', 'Mid-Market');

-- Create a transient environment
CREATE DATABASE IF NOT EXISTS ANALYTICS_TRANSIENT;
