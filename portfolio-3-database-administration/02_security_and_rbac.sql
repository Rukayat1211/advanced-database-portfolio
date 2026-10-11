-- ============================================================
-- MIT 8103 Advanced Database Systems - Portfolio Activity 3
-- Security & Role-Based Access Control (RBAC) Script
-- Target DBMS: PostgreSQL
-- ============================================================

-- 1. Create Granular Database Roles
DROP ROLE IF EXISTS app_admin;
DROP ROLE IF EXISTS app_staff;
DROP ROLE IF EXISTS app_read_only;

CREATE ROLE app_admin WITH LOGIN PASSWORD 'AdminSecurePass2026!';
CREATE ROLE app_staff WITH LOGIN PASSWORD 'StaffSecurePass2026!';
CREATE ROLE app_read_only WITH LOGIN PASSWORD 'ReadOnlyPass2026!';

-- 2. Schema Privileges
GRANT ALL PRIVILEGES ON DATABASE postgres TO app_admin;

-- Staff Privileges: Read/Write access on daily operational tables
GRANT SELECT, INSERT, UPDATE ON TABLE orders, order_items, delivery_records, payments TO app_staff;
GRANT SELECT ON TABLE customers, products, categories TO app_staff;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO app_staff;

-- Read-Only Privileges: Reporting and audit access only
GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_read_only;

-- 3. Row-Level Security (RLS) Implementation
-- Ensure customers can only view their own order data
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS customer_orders_isolation ON orders;
CREATE POLICY customer_orders_isolation ON orders
    FOR SELECT
    USING (customer_id = NULLIF(current_setting('app.current_customer_id', true), '')::INTEGER);

-- Audit Column Enforcement
ALTER TABLE customers ADD COLUMN IF NOT EXISTS last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
