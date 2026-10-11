-- ============================================================
-- MIT 8103 Advanced Database Systems - Portfolio Activity 3
-- Indexing & Query Optimization Script for SwiftCart
-- Target DBMS: PostgreSQL
-- ============================================================

-- 1. Single-Column B-Tree Index on High-Frequency Lookups
-- Accelerates foreign key lookups and order filtering by customer
CREATE INDEX idx_orders_customer_id ON orders(customer_id);

-- 2. Composite B-Tree Index for Filtering & Range Operations
-- Speeds up date-range filtering and status queries in dashboard reporting
CREATE INDEX idx_orders_status_date ON orders(order_status, order_date DESC);

-- 3. B-Tree Index on Delivery Tracking
-- Enables fast equality lookups for customer logistics tracking
CREATE INDEX idx_delivery_tracking ON delivery_records(tracking_number);

-- 4. GIN Index on JSONB Attributes Column
-- Enables high-performance querying inside unstructured product metadata
CREATE INDEX idx_products_attributes_gin ON products USING GIN (attributes);

-- Example Verification Queries using EXPLAIN ANALYZE
EXPLAIN ANALYZE 
SELECT * FROM orders 
WHERE customer_id = 1 AND order_status = 'Delivered';

EXPLAIN ANALYZE 
SELECT product_id, product_name, attributes 
FROM products 
WHERE attributes @> '{"brand": "TechCorp"}';
