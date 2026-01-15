-- See https://docs.snowflake.com/en/user-guide/data-engineering/dbt-projects-on-snowflake-dependencies#create-an-external-access-integration-in-snowflake-for-dbt-dependencies

USE ROLE ACCOUNTADMIN;

-- Create NETWORK RULE for external access integration

CREATE OR REPLACE NETWORK RULE SNOWFLAKE_INFRA.DBTDEMO.DBT_NR
  MODE = EGRESS
  TYPE = HOST_PORT
  -- Minimal URL allowlist that is required for dbt deps
  VALUE_LIST = (
    'hub.getdbt.com',
    'codeload.github.com'
    );

-- Create EXTERNAL ACCESS INTEGRATION for dbt access to external dbt package locations
CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION DBT_EA_INTEGRATION
  ALLOWED_NETWORK_RULES = (SNOWFLAKE_INFRA.DBTDEMO.DBT_NR)
  ENABLED = TRUE;