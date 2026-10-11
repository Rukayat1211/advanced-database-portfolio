-- ============================================================
-- MIT 8103 Advanced Database Systems - Portfolio Activity 2
-- Complex Analytical Queries for SwiftCart E-Commerce Platform
-- Target DBMS: PostgreSQL
-- ============================================================

-- ------------------------------------------------------------
-- QUERY 1: Customer Order & Spend Summary (Multi-Table JOIN & Aggregation)
-- Business Objective: Retrieve total spending, total completed orders, 
-- and last order date per customer.
-- ------------------------------------------------------------
SELECT 
    c.customer_id,
    c.full_name,
    c.email,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0.00) AS total_spent,
    MAX(o.order_date) AS last_order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id AND o.order_status != 'Cancelled'
GROUP BY c.customer_id, c.full_name, c.email
ORDER BY total_spent DESC;


-- ------------------------------------------------------------
-- QUERY 2: Top Selling Product Categories (CTEs & Subqueries)
-- Business Objective: Analyze revenue and total items sold per product category.
-- ------------------------------------------------------------
WITH CategorySales AS (
    SELECT 
        cat.category_id,
        cat.category_name,
        SUM(oi.quantity) AS total_units_sold,
        SUM(oi.quantity * oi.unit_price) AS category_revenue
    FROM categories cat
    JOIN products p ON cat.category_id = p.category_id
    JOIN order_items oi ON p.product_id = oi.product_id
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY cat.category_id, cat.category_name
)
SELECT 
    category_id,
    category_name,
    total_units_sold,
    category_revenue,
    ROUND((category_revenue / (SELECT SUM(category_revenue) FROM CategorySales)) * 100, 2) AS revenue_percentage
FROM CategorySales
ORDER BY category_revenue DESC;


-- ------------------------------------------------------------
-- QUERY 3: Customer Order Ranking via Window Functions
-- Business Objective: Rank each customer's individual orders by value 
-- using ROW_NUMBER() and DENSE_RANK().
-- ------------------------------------------------------------
SELECT 
    o.order_id,
    c.full_name AS customer_name,
    o.order_date,
    o.total_amount,
    DENSE_RANK() OVER (PARTITION BY o.customer_id ORDER BY o.total_amount DESC) AS customer_order_rank,
    RANK() OVER (ORDER BY o.total_amount DESC) AS overall_order_rank
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status != 'Cancelled';


-- ------------------------------------------------------------
-- QUERY 4: Delivery Performance & Logistics SLA Tracking
-- Business Objective: Identify delivery fulfillment times and track 
-- orders delivered ahead of or past the estimated delivery date.
-- ------------------------------------------------------------
SELECT 
    d.delivery_id,
    o.order_id,
    c.full_name AS customer_name,
    d.courier_name,
    d.tracking_number,
    d.estimated_delivery_date,
    d.actual_delivery_date,
    CASE 
        WHEN d.actual_delivery_date::date <= d.estimated_delivery_date THEN 'On Time / Early'
        WHEN d.actual_delivery_date::date > d.estimated_delivery_date THEN 'Delayed'
        ELSE 'In Transit / Pending'
    END AS fulfillment_status
FROM delivery_records d
JOIN orders o ON d.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id;
