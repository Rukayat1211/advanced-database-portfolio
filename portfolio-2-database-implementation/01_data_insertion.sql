-- ============================================================
-- MIT 8103 Advanced Database Systems - Portfolio Activity 2
-- Data Insertion Script for SwiftCart E-Commerce Platform
-- Target DBMS: PostgreSQL
-- ============================================================

-- Clear existing data (in reverse dependency order)
TRUNCATE delivery_records, payments, order_items, orders, products, categories, customers RESTART IDENTITY CASCADE;

-- 1. Insert Categories
INSERT INTO categories (category_name, description) VALUES
('Electronics', 'Gadgets, personal computing, and consumer electronics'),
('Home Appliances', 'Kitchen appliances, climate control, and home items'),
('Fashion & Apparel', 'Clothing, footwear, and fashion accessories'),
('Books & Stationery', 'Physical books, educational materials, and office supplies'),
('Sports & Fitness', 'Fitness gear, outdoor equipment, and sportswear');

-- 2. Insert Customers
INSERT INTO customers (full_name, email, phone_number, shipping_address, registration_date) VALUES
('Amina Yusuf', 'amina.yusuf@example.com', '+2348012345678', '12 Marina Road, Lagos Island, Lagos', '2025-01-15 09:30:00'),
('Chidi Okonkwo', 'chidi.okonkwo@example.com', '+2348023456789', '45 Independence Layout, Enugu', '2025-02-01 11:15:00'),
('Fatima Bello', 'fatima.bello@example.com', '+2348034567890', '8 Kano Road, Kaduna', '2025-02-10 14:20:00'),
('David Adebayo', 'david.adebayo@example.com', '+2348045678901', '22 Allen Avenue, Ikeja, Lagos', '2025-03-05 16:45:00'),
('Emeka Nwosu', 'emeka.nwosu@example.com', '+2348056789012', '15 Trans Amadi, Port Harcourt', '2025-03-20 10:00:00');

-- 3. Insert Products
INSERT INTO products (category_id, product_name, price, stock_quantity, attributes) VALUES
(1, 'UltraBook Laptop 15"', 1200.00, 25, '{"brand": "TechCorp", "ram": "16GB", "storage": "512GB SSD"}'),
(1, 'Wireless Noise-Canceling Headphones', 250.00, 50, '{"brand": "SoundPro", "battery_life": "30hrs", "color": "Black"}'),
(1, 'Smart Fitness Watch', 180.00, 40, '{"brand": "FitLife", "water_proof": true, "screen": "AMOLED"}'),
(2, 'Smart Blender 1000W', 95.00, 15, '{"brand": "HomeChef", "capacity": "2L", "speeds": 5}'),
(2, 'Air Fryer XL 5.5L', 140.00, 20, '{"brand": "CrispMaster", "power": "1800W"}'),
(3, 'Men Leather Jacket', 110.00, 30, '{"size": "L", "color": "Brown", "material": "Genuine Leather"}'),
(3, 'Women Running Shoes', 85.00, 45, '{"size": "38", "color": "Pink/White", "type": "Athletic"}'),
(4, 'Database System Concepts (8th Ed)', 75.00, 100, '{"author": "Silberschatz", "format": "Hardcover", "pages": 1376}'),
(5, 'Adjustable Dumbbell Set 20kg', 130.00, 12, '{"weight_range": "2kg-20kg", "material": "Cast Iron"}');

-- 4. Insert Orders
INSERT INTO orders (customer_id, order_date, order_status, total_amount) VALUES
(1, '2025-04-01 10:15:00', 'Delivered', 1450.00),
(2, '2025-04-03 14:30:00', 'Delivered', 235.00),
(3, '2025-04-05 09:00:00', 'Dispatched', 180.00),
(4, '2025-04-08 16:20:00', 'Processing', 335.00),
(1, '2025-04-10 11:45:00', 'Pending', 75.00),
(5, '2025-04-11 13:10:00', 'Cancelled', 250.00);

-- 5. Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1200.00),
(1, 2, 1, 250.00),
(2, 4, 1, 95.00),
(2, 5, 1, 140.00),
(3, 3, 1, 180.00),
(4, 3, 1, 180.00),
(4, 8, 1, 75.00),
(4, 6, 1, 80.00),
(5, 8, 1, 75.00),
(6, 2, 1, 250.00);

-- 6. Insert Payments
INSERT INTO payments (order_id, payment_method, payment_status, amount, payment_date) VALUES
(1, 'Credit Card', 'Completed', 1450.00, '2025-04-01 10:18:00'),
(2, 'Debit Card', 'Completed', 235.00, '2025-04-03 14:32:00'),
(3, 'Bank Transfer', 'Completed', 180.00, '2025-04-05 09:05:00'),
(4, 'Mobile Money', 'Completed', 335.00, '2025-04-08 16:22:00'),
(5, 'Credit Card', 'Pending', 75.00, '2025-04-10 11:45:00'),
(6, 'Debit Card', 'Failed', 250.00, '2025-04-11 13:12:00');

-- 7. Insert Delivery Records
INSERT INTO delivery_records (order_id, tracking_number, courier_name, delivery_status, estimated_delivery_date, actual_delivery_date) VALUES
(1, 'TRK-2025-001', 'DHL Express', 'Delivered', '2025-04-04', '2025-04-03 15:00:00'),
(2, 'TRK-2025-002', 'FedEx', 'Delivered', '2025-04-07', '2025-04-06 12:30:00'),
(3, 'TRK-2025-003', 'SpeedAfriq Logistics', 'In Transit', '2025-04-12', NULL),
(4, 'TRK-2025-004', 'DHL Express', 'Pending', '2025-04-15', NULL);
