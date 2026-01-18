# Zepto SQL Analysis Project

## 📌 Project Overview
This project focuses on analyzing grocery product data inspired by Zepto's quick-commerce business model using SQL.  
The objective is to derive insights related to pricing, discounts, inventory availability, and revenue contribution.

## 🛠 Tools Used
- MySQL
- MySQL Workbench
- GitHub

## 📂 Dataset
The dataset contains product-level information including:
- Category and product name
- MRP and discount percentage
- Discounted selling price
- Available inventory
- Product weight
- Stock status
- Order quantity

## 🧱 Database Design
A structured SQL table was designed with an auto-incrementing `sku_id` as the primary key to uniquely identify each product.

## 🔍 Analysis Performed
### Simple Analysis
- Identified in-stock products
- Filtered products based on discount and weight
- Sorted products by pricing

### Intermediate Analysis
- Calculated discount amounts
- Analyzed average pricing by category
- Evaluated inventory distribution

### Advanced Analysis
- Calculated product-level and category-level revenue
- Identified high discount impact products
- Ranked products by revenue using window functions

## 📈 Key Insights
- Products with higher discounts do not always generate higher revenue
- Certain categories contribute disproportionately to total revenue
- Inventory levels can be optimized using demand-based insights

## 🚀 Conclusion
This project demonstrates practical SQL skills including data modeling, aggregation, filtering, and advanced analytical queries applicable to real-world e-commerce scenarios.
