# Portfolio Activity 4: NoSQL & Advanced Data Models Technical Report

## 1. Relational vs. NoSQL Paradigm Evaluation

SwiftCart uses a hybrid data management strategy: PostgreSQL for transactional operations (orders, billing, inventory) and MongoDB for dynamic content delivery (product catalog, search specs, customer product reviews).

| Feature / Dimension | Relational (PostgreSQL) | Document NoSQL (MongoDB) |
| :--- | :--- | :--- |
| **Data Structure** | Normalized tables with strict schemas | Dynamic, unstructured JSON/BSON documents |
| **Scaling Mechanism** | Vertical (Scale-Up) | Horizontal Sharding (Scale-Out) |
| **ACID Compliance** | Strict ACID enforcement across joins | Document-level atomicity (BASE model) |
| **Use Case Scope** | Financial ledgers, payment processing | Product catalogs, search, review aggregation |

---

## 2. Dynamic Catalog Modeling & Schema Flexibility

E-commerce catalogs feature diverse product lines where rigid relational schemas require numerous nullable columns or complex EAV (Entity-Attribute-Value) tables. 

MongoDB resolves this by embedding varying attributes inside dynamic document keys. For instance, a laptop document contains RAM and processor attributes, whereas a kitchen blender document stores wattage without altering table schemas or executing schema migrations.

```json
// Flexible document payload storing varied product specifications
{
  "product_id": 101,
  "product_name": "UltraBook Pro 15",
  "attributes": { "ram": "16GB", "storage": "512GB SSD" }
}
