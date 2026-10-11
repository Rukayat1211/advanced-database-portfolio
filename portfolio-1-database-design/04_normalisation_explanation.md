# Portfolio Activity 1: Normalisation Breakdown (3NF Proof)

## 1. Overview & Objectives
This document provides formal technical proof that the **SwiftCart** relational database schema satisfies **Third Normal Form (3NF)**. The normalisation process eliminates data redundancy, prevents insertion/update/deletion anomalies, and enforces structural integrity across all tables.

---

## 2. Unnormalised Form (UNF)
In an unnormalised state, all e-commerce attributes exist within a single flat table containing multi-valued fields and repeating groups.

```text
UNF_Orders(order_id, customer_name, customer_email, shipping_address, order_date, 
           item_1_name, item_1_price, item_1_qty, item_2_name, item_2_price, item_2_qty, 
           category_name, category_description, payment_method, payment_status, tracking_number)
