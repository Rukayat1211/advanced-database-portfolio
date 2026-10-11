# Portfolio Activity 3: Advanced Database Concepts & Security Administration

## Executive Summary
This folder contains the database administration, performance optimization, indexing, role-based access control (RBAC), and Row-Level Security (RLS) implementation for **SwiftCart**.

---

## Deliverables Included

1. **`01_indexing_and_performance.sql`**  
   SQL script creating single-column, composite B-Tree, and GIN indexes (for JSONB attributes) alongside `EXPLAIN ANALYZE` optimization checks.

2. **`02_security_and_rbac.sql`**  
   Security script configuring Role-Based Access Control (`app_admin`, `app_staff`, `app_read_only`) and enforcing Row-Level Security (RLS) policies for multi-tenant data isolation.

3. **`03_database_administration_report.md`**  
   Technical administration report explaining index performance results, security posture, transaction management, and ACID compliance guarantees.
