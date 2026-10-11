# Portfolio Activity 5: Distributed & Cloud Database Architecture Design

## Executive Summary
This document details the distributed, multi-region database topology and cloud deployment strategy for the **SwiftCart** platform to ensure 99.99% availability, zero data loss, and sub-10ms read latencies.

---

## 1. System Topology & Replication Strategy

SwiftCart utilizes a **Multi-Region Primary-Replica Topology** managed via managed cloud services (AWS Aurora PostgreSQL / CockroachDB):

* **Primary Read/Write Region (Primary Cloud Region - e.g., us-east-1):**  
  Handles all transactional writes (orders, payment updates, inventory deduction).
* **Cross-Region Read Replicas (Secondary Regions - e.g., eu-west-1, ap-southeast-1):**  
  Maintains asynchronous, streaming physical replication to serve low-latency local catalog reads and search traffic.
* **Failover & High Availability (HA):**  
  Automated multi-AZ (Availability Zone) synchronous failover with virtual IP rerouting in case of node failure (Recovery Point Objective RPO = 0, Recovery Time Objective RTO < 30 seconds).

---

## 2. Horizontal Partitioning (Sharding Strategy)

To scale database write capacity beyond single-node physical resource limits, SwiftCart implements key-based database sharding on the `orders` and `order_items` datasets:

* **Shard Key Selection:** `customer_id` (Hash-based partitioning).
* **Rationale:** Ensures all order records and history for a given customer reside on the same physical database shard node, eliminating the need for expensive multi-node distributed cross-shard JOINs during customer account lookups.

+-----------------------------------------------------------------------+
|                           API Gateway / Proxy                         |
+-----------------------------------------------------------------------+
|
+-------------------------+-------------------------+
| (Shard Router / Hash Key based on customer_id)    |
v                                                   v
+------------------------+                          +------------------------+
|   Shard Node 1 (A-M)   |                          |   Shard Node 2 (N-Z)   |
| Orders, Customer Data  |                          | Orders, Customer Data  |
+------------------------+                          +------------------------+


---

## 3. Data Consistency & Distributed Consensus

* **Two-Phase Commit (2PC) / Saga Pattern:**  
  For distributed microservice transactions (e.g., deducting inventory while processing a credit card payment across separate database clusters), SwiftCart uses the **Saga Orchestration Pattern** to guarantee eventual consistency across microservices via compensation transactions.
* **Consensus Engine:**  
  Raft consensus protocol coordinates metadata and leader election across cross-region clust
