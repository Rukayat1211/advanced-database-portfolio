# Portfolio Activity 5: Distributed & Cloud Database Exercise

## Executive Summary
This directory contains the multi-region topology design, horizontal table partitioning (sharding simulation), and replication health monitoring scripts for **SwiftCart**'s cloud database architecture.

---

## Deliverables Included

1. **`01_distributed_architecture_design.md`**  
   Detailed evaluation of primary-replica topology, hash-based sharding strategy on `customer_id`, RTO/RPO targets, and distributed transaction consistency using the Saga pattern.

2. **`02_replication_and_sharding_simulation.sql`**  
   PostgreSQL declarative hash partitioning implementation simulating multi-shard routing and administrative system views (`pg_stat_replication`) to track cross-region replication lag.
