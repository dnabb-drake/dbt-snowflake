USE ROLE ACCOUNTADMIN;

CREATE OR REPLACE API INTEGRATION GITHUB_OAUTH_EA_INTEGRATION
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com')
  API_USER_AUTHENTICATION = (TYPE = SNOWFLAKE_GITHUB_APP)
  ENABLED = TRUE;

-- This integration doesn't actually store any secret, so it's safe to grant to PUBLIC¨
-- It avoids issues with the Snowsight ui using the wrong role when trying to access github repos
GRANT USAGE ON INTEGRATION GITHUB_OAUTH_EA_INTEGRATION TO ROLE PUBLIC;