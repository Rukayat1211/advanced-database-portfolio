# Portfolio Activity 3: Database Administration, Security & Performance Report

## 1. Indexing Strategy & Query Optimization

To ensure optimal query execution speeds as dataset size scales, targeted indexes were created based on query execution patterns:

* **`idx_orders_customer_id` (B-Tree):** Accelerates foreign key joins between `customers` and `orders`. Prevents costly sequential scans during user dashboard rendering.
* **`idx_orders_status_date` (Composite B-Tree):** Optimizes multi-column filtering for order status reporting filtered by recent transaction dates.
* **`idx_products_attributes_gin` (GIN Index):** Enables fast containment queries (`@>`) on semi-structured JSONB data inside the `attributes` column (e.g., matching brand or specs without full table scans).

### Performance Verification (`EXPLAIN ANALYZE`)
Without indexing, filtering orders by `customer_id` requires a full sequential scan ($O(N)$ time complexity). With the B-tree index, PostgreSQL executes an **Index Scan** ($O(\log N)$ time complexity), reducing execution time significantly on large datasets.

---

## 2. Security Posture & Role-Based Access Control (RBAC)

The Principle of Least Privilege (PoLP) was enforced through granular user roles:

| Role Name | Access Scope | Intended Principal |
| :--- | :--- | :--- |
| `app_admin` | Full DDL/DML access across schema | System Administrators |
| `app_staff` | `SELECT`, `INSERT`, `UPDATE` on orders, items, deliveries | Support & Operations Team |
| `app_read_only` | `SELECT` only on all tables | Business Analysts & Auditors |

### Row-Level Security (RLS)
To enforce multi-tenant isolation, Row-Level Security was enabled on the `orders` table. The policy ensures that logged-in application users can only query records where `customer_id` matches their authenticated session context (`app.current_customer_id`).

---

## 3. Transaction Management & ACID Properties

SwiftCart guarantees data integrity through strict adherence to ACID principles using PostgreSQL transactions:

* **Atomicity:** Payment processing and order creation are wrapped in `BEGIN ... COMMIT` blocks. If payment fails, the order insertion rolls back completely (`ROLLBACK`).
* **Consistency:** Constraints (`CHECK`, `FOREIGN KEY`, `NOT NULL`) prevent invalid states (e.g., ordering negative quantities or assigning orders to non-existent customers).
* **Isolation:** Default `READ COMMITTED` isolation level prevents dirty reads while concurrent customer checkouts occur.
* **Durability:** Write-Ahead Logging (WAL) ensures committed transactions persist even during unexpected server crashes.
