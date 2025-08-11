-- For Admin Role

CREATE USER admin_role WITH PASSWORD 'adminRole';
CREATE USER data_engineer_role WITH PASSWORD 'dataengineerRole';
CREATE USER data_analyst_role WITH PASSWORD 'analystRole';

-- Give full control of the entire database for Admin_role
GRANT ALL PRIVILEGES ON DATABASE dvdrental TO admin_role;

-- Give full control on the schema
GRANT ALL PRIVILEGES ON SCHEMA dvddw TO admin_role;

-- Give full control on all tables
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA dvddw TO admin_role;

-- Ensure future tables also have privileges
ALTER DEFAULT PRIVILEGES IN SCHEMA dvddw GRANT ALL PRIVILEGES ON TABLES TO admin_role;

-- Full control on sequences (for SERIAL keys)
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA dvddw TO admin_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA dvddw GRANT ALL PRIVILEGES ON SEQUENCES TO admin_role;


-- Allow schema usage and object creation for data_engineer_role
GRANT USAGE, CREATE ON SCHEMA dvddw TO data_engineer_role;

-- Allow read/write on all tables
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA dvddw TO data_engineer_role;

-- Allow sequence usage (for inserting into SERIAL columns)
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA dvddw TO data_engineer_role;

-- Ensure privileges apply to future tables/sequences
ALTER DEFAULT PRIVILEGES IN SCHEMA dvddw GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO data_engineer_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA dvddw GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO data_engineer_role;

--
-- Allow schema usage (can see objects, but not modify) for data_analyst_role.
GRANT USAGE ON SCHEMA dvddw TO data_analyst_role;

-- Allow read-only on all tables
GRANT SELECT ON ALL TABLES IN SCHEMA dvddw TO data_analyst_role;

-- Ensure privileges apply to future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA dvddw GRANT SELECT ON TABLES TO data_analyst_role;

SELECT * FROM pg_catalog.pg_roles;
