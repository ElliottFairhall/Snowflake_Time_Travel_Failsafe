# ⏳ Snowflake Time Travel & Fail-safe

> Architecture and design rationale: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)

[![Snowflake](https://img.shields.io/badge/Snowflake-Cloud%20Data%20Platform-29B5E8?style=flat&logo=snowflake)](https://www.snowflake.com/)
[![SQL](https://img.shields.io/badge/SQL-Snowflake%20Dialect-lightgrey)](https://docs.snowflake.com/)
[![Status](https://img.shields.io/badge/Status-Educational-success)](https://github.com/ElliottFairhall/Snowflake_Time_Travel_Failsafe)

A guide to mastering Snowflake's Continuous Data Protection (CDP) features: **Time Travel** and **Fail-safe**. Learn how
to query historical data, recover dropped objects, create point-in-time clones, and manage storage costs effectively.

______________________________________________________________________

## Key Features

- **Historical Queries**: Using `AT` and `BEFORE` clauses to access previous data states.
- **Zero-Copy Cloning**: Creating database and schema clones at a specific timestamp.
- **Data Recovery**: Restoring tables and schemas using the `UNDROP` command.
- **Retention Strategy**: Configuring `DATA_RETENTION_TIME_IN_DAYS` and understanding Fail-safe costs.

______________________________________________________________________

## Project Structure

```text
Snowflake_Time_Travel_Failsafe/
├── README.md               # You are here
├── Tutorial/
│   └── TIME_TRAVEL_FAILSAFE_TUTORIAL.md # Step-by-step walkthrough
├── scripts/                # Extracted CDP SQL operations
│   ├── 01_querying_historical_data.sql
│   ├── 02_cloning_point_in_time.sql
│   ├── 03_restoring_dropped_objects.sql
│   └── 04_configuring_data_retention.sql
├── notebook/
│   └── Time_Travel_Failsafe_Tutorial.ipynb
└── data/                   # Initialised as empty
```

______________________________________________________________________

## Getting Started

> **Environment Setup:** Before beginning, execute `scripts/00_setup_environment.sql` to provision the necessary
> databases, schemas, and sample data for this project.

1. Read the **[Time Travel & Fail-safe Tutorial](Tutorial/TIME_TRAVEL_FAILSAFE_TUTORIAL.md)**.
2. Experiment with the historical queries in `scripts/01_querying_historical_data.sql`.

______________________________________________________________________

## Author

**Elliott Fairhall** *Data Engineering Educational Series*
