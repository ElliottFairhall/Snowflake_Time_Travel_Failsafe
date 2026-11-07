-- =============================================================================
-- 00_SETUP_ENVIRONMENT
-- =============================================================================
-- Purpose:    Provision the necessary databases, schemas, and sample data
--             to serve as the foundation for the Time Travel tutorial.
-- =============================================================================

-- WARNING: this script uses CREATE OR REPLACE TABLE as a reset-to-sample-data step. It replaces the tables below,
-- so re-running it discards changes you made to them (Time Travel keeps the old version only while retention
-- allows). The database names carry the tutorial prefix TT_, so it does not touch another tutorial's tables.

USE ROLE SYSADMIN;

-- 1. Create base DBs and Schemas
CREATE DATABASE IF NOT EXISTS TT_ANALYTICS;
CREATE SCHEMA IF NOT EXISTS TT_ANALYTICS.MARTS;
CREATE SCHEMA IF NOT EXISTS TT_ANALYTICS.STAGING;

-- 2. Create and populate Customer dimension for Time Travel querying
CREATE OR REPLACE TABLE TT_ANALYTICS.MARTS.DIM_CUSTOMERS (
    CUSTOMER_ID INT,
    CUSTOMER_NAME VARCHAR,
    SEGMENT VARCHAR
);

-- Note: To execute the scripts tracking changes over time, you should run the
-- below commands, wait some time (or modify records), and use Time Travel.
INSERT INTO TT_ANALYTICS.MARTS.DIM_CUSTOMERS VALUES
    (1, 'Enterprise Corp', 'Enterprise'),
    (2, 'Mid-Market Limited', 'Mid-Market');

-- Create a transient environment
CREATE DATABASE IF NOT EXISTS TT_ANALYTICS_TRANSIENT;
