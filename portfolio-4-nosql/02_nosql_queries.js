// ============================================================
// MIT 8103 Advanced Database Systems - Portfolio Activity 4
// MongoDB Shell Scripts & Aggregation Framework for SwiftCart
// Target Database: MongoDB (Document-Oriented NoSQL)
// ============================================================

// 1. Insert Sample Product Documents with Embedded Reviews and Attributes
db.products.insertMany([
  {
    product_id: 101,
    product_name: "UltraBook Pro 15",
    category: { category_id: 1, category_name: "Electronics" },
    price: 1250.00,
    stock_quantity: 45,
    attributes: { brand: "TechCorp", ram: "16GB", storage: "512GB SSD", color: "Space Gray" },
    reviews: [
      { review_id: 1, customer_name: "Amina Yusuf", rating: 5, comment: "Excellent speed and display!", created_at: "2026-03-10" },
      { review_id: 2, customer_name: "Chidi Okonkwo", rating: 4, comment: "Great laptop, battery life is decent.", created_at: "2026-03-12" }
    ]
  },
  {
    product_id: 102,
    product_name: "Smart Blender X",
    category: { category_id: 2, category_name: "Home Appliances" },
    price: 180.00,
    stock_quantity: 120,
    attributes: { brand: "HomeEase", wattage: "1200W", capacity: "2L" },
    reviews: [
      { review_id: 3, customer_name: "Fatima Bello", rating: 5, comment: "Blends smoothly and fast.", created_at: "2026-03-15" }
    ]
  }
]);

// 2. Querying Nested Document Attributes
// Find all products manufactured by "TechCorp"
db.products.find({ "attributes.brand": "TechCorp" });

// 3. Document Updating & Array Push
// Add a new review to UltraBook Pro 15 without altering table schemas
db.products.updateOne(
  { product_id: 101 },
  { 
    $push: { 
      reviews: { 
        review_id: 4, 
        customer_name: "David Adebayo", 
        rating: 5, 
        comment: "Best laptop for software development!", 
        created_at: "2026-04-01" 
      } 
    } 
  }
);

// 4. Aggregation Pipeline: Calculate Average Product Rating
db.products.aggregate([
  { $unwind: "$reviews" },
  { 
    $group: { 
      _id: "$product_name", 
      avgRating: { $avg: "$reviews.rating" }, 
      totalReviews: { $sum: 1 } 
    } 
  },
  { $sort: { avgRating: -1 } }
]);
