# Portfolio Activity 2: Query Execution & Analytical Report

## 1. Overview
This document presents the execution analysis for the complex PostgreSQL queries defined in `02_complex_queries.sql`. These analytical queries support business decision-making, customer segmentation, revenue analysis, and logistics monitoring for **SwiftCart**.

---

## 2. Detailed Query Breakdowns & Execution Results

### Query 1: Customer Order & Spend Summary
* **Techniques Used:** `LEFT JOIN`, `GROUP BY`, Aggregate Functions (`COUNT`, `SUM`, `MAX`), `COALESCE`.
* **Business Purpose:** Identifies high-value customers (VIPs) and customer order frequency while accounting for customers without non-cancelled orders.

#### Expected Output Data Table
| customer_id | full_name | email | total_orders | total_spent | last_order_date |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | Amina Yusuf | amina.yusuf@example.com | 2 | 1525.00 | 2025-04-10 11:45:00 |
| 4 | David Adebayo | david.adebayo@example.com | 1 | 335.00 | 2025-04-08 16:20:00 |
| 2 | Chidi Okonkwo | chidi.okonkwo@example.com | 1 | 235.00 | 2025-04-03 14:30:00 |
| 3 | Fatima Bello | fatima.bello@example.com | 1 | 180.00 | 2025-04-05 09:00:00 |
| 5 | Emeka Nwosu | emeka.nwosu@example.com | 0 | 0.00 | *NULL* |

---

### Query 2: Category Revenue Breakdown & Market Share
* **Techniques Used:** Common Table Expressions (CTE `WITH`), Multi-Table `JOIN`s, Subqueries, Percentage Calculation.
* **Business Purpose:** Measures total revenue contribution per product category for inventory planning and targeted promotions.

#### Expected Output Data Table
| category_id | category_name | total_units_sold | category_revenue | revenue_percentage |
| :--- | :--- | :--- | :--- | :--- |
| 1 | Electronics | 2 | 1450.00 | 86.05% |
| 2 | Home Appliances | 2 | 235.00 | 13.95% |

---

### Query 3: Customer Order Ranking via Window Functions
* **Techniques Used:** `DENSE_RANK() OVER (PARTITION BY ...)` and `RANK() OVER (...)`.
* **Business Purpose:** Ranks orders per individual customer to identify purchasing patterns without collapsing rows via `GROUP BY`.

#### Expected Output Data Table
| order_id | customer_name | order_date | total_amount | customer_order_rank | overall_order_rank |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | Amina Yusuf | 2025-04-01 | 1450.00 | 1 | 1 |
| 4 | David Adebayo | 2025-04-08 | 335.00 | 1 | 2 |
| 2 | Chidi Okonkwo | 2025-04-03 | 235.00 | 1 | 3 |
| 3 | Fatima Bello | 2025-04-05 | 180.00 | 1 | 4 |
| 5 | Amina Yusuf | 2025-04-10 | 75.00 | 2 | 5 |

---

### Query 4: Delivery SLA & Logistics Tracking
* **Techniques Used:** Conditional `CASE WHEN` Statements, Date Casting, Multi-Table `JOIN`s.
* **Business Purpose:** Monitors courier SLA fulfillment to identify on-time vs. delayed deliveries.

#### Expected Output Data Table
| delivery_id | order_id | customer_name | courier_name | tracking_number | fulfillment_status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 1 | Amina Yusuf | DHL Express | TRK-2025-001 | On Time / Early |
| 2 | 2 | Chidi Okonkwo | FedEx | TRK-2025-002 | On Time / Early |
| 3 | 3 | Fatima Bello | SpeedAfriq Logistics | TRK-2025-003 | In Transit / Pending |
| 4 | 4 | David Adebayo | DHL Express | TRK-2025-004 | In Transit / Pending |

---

## 3. Summary & Analytical Value
The queries demonstrate advanced data extraction capabilities required for production analytics:
1. **Aggregations & Null Handling:** `COALESCE` guarantees accurate spend figures even when orders are missing or cancelled.
2. **CTEs:** CTEs isolate revenue calculations cleanly before computing platform-wide market share percentages.
3. **Window Functions:** `DENSE_RANK()` provides precise customer-level purchase histories without requiring complex nested subqueries.
