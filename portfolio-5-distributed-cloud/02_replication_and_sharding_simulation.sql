-- ============================================================
-- MIT 8103 Advanced Database Systems - Portfolio Activity 5
-- PostgreSQL Horizontal Declarative Partitioning & Replication Monitoring
-- Target Database: PostgreSQL 15+
-- ============================================================

-- 1. Declarative Hash Partitioning for Sharding Simulation (Orders Table)
DROP TABLE IF EXISTS orders_partitioned CASCADE;

CREATE TABLE orders_partitioned (
    order_id SERIAL,
    customer_id INT NOT NULL,
    order_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(10, 2) NOT NULL,
    order_status VARCHAR(20) DEFAULT 'Pending',
    PRIMARY KEY (order_id, customer_id)
) PARTITION BY HASH (customer_id);

-- Create 2 Shard Partitions based on Hash Modulo
CREATE TABLE orders_shard_1 PARTITION OF orders_partitioned
    FOR VALUES WITH (MODULUS 2, REMAINDER 0);

CREATE TABLE orders_shard_2 PARTITION OF orders_partitioned
    FOR VALUES WITH (MODULUS 2, REMAINDER 1);

-- Insert Sample Orders to Demonstrate Automatic Routing to Shard Nodes
INSERT INTO orders_partitioned (customer_id, total_amount, order_status) VALUES
(101, 250.00, 'Completed'), -- Routes to Shard Node
(102, 450.50, 'Processing'),-- Routes to Shard Node
(103, 89.99, 'Completed'),  -- Routes to Shard Node
(104, 1200.00, 'Pending');   -- Routes to Shard Node

-- Verify Routing across Shard Partitions
SELECT 'Shard 1 Records' AS shard, COUNT(*) FROM orders_shard_1
UNION ALL
SELECT 'Shard 2 Records' AS shard, COUNT(*) FROM orders_shard_2;

-- 2. Replication Monitoring Query (Executed on Primary Database Node)
-- Evaluates write-ahead logging (WAL) lag across secondary read replicas
SELECT 
    client_addr AS replica_ip,
    usename AS replication_user,
    application_name,
    state,
    sync_state,
    pg_wal_lsn_diff(pg_current_wal_lsn(), replay_lsn) AS replication_lag_bytes
FROM pg_stat_replication;
