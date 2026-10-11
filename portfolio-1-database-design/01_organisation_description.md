# Portfolio Activity 1: Organisation & Case Study Specification

## 1. Selected Organisation & Scenario
* **Organisation Name:** SwiftCart E-Commerce Platform
* **Scenario Type:** Simulated Multi-Vendor E-Commerce System
* **Nature of the Business:** SwiftCart is an online retail platform providing automated inventory management, customer order processing, secure payment handling, and real-time shipment logistics tracking.

---

## 2. Users of the Database
1. **Customers (Buyers):** Registered shoppers who browse product catalogs, manage shopping carts, place orders, make payments, and monitor order fulfillment status.
2. **Store Administrators & Inventory Managers:** Operational staff responsible for onboarding products, updating pricing, configuring product attributes, monitoring stock levels, and managing returns.
3. **Logistics & Delivery Personnel:** External couriers and fulfillment staff who update shipping statuses, record tracking details, and confirm final package delivery.

---

## 3. Major Data Stored
* **Customers:** `customer_id`, `full_name`, `email`, `phone_number`, `shipping_address`, `registration_date`.
* **Products & Attributes:** `product_id`, `category_id`, `product_name`, `price`, `stock_quantity`, `attributes` (e.g., color, size, technical specs).
* **Orders & Order Items:** `order_id`, `customer_id`, `order_date`, `order_status`, `product_id`, `quantity`, `unit_price`.
* **Payments:** `payment_id`, `order_id`, `payment_method`, `payment_status`, `amount`, `payment_date`.
* **Delivery Records:** `delivery_id`, `order_id`, `tracking_number`, `courier_name`, `delivery_status`, `estimated_delivery_date`.

---

## 4. Key Database Operations Supported
1. **Add & Update Products:** Create new inventory items, attach dynamic attributes, and modify unit prices.
2. **Place Orders:** Process multi-item customer checkout operations, compute sub-totals, and record line-item transactions atomically.
3. **Update Stock:** Deduct inventory quantities dynamically upon checkout completion and handle stock replenishments.
4. **Track Delivery:** Assign unique tracking codes, record dispatch timestamps, and update shipping milestones (*Dispatched*, *In Transit*, *Delivered*).
