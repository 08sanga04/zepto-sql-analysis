/* =====================================================
   PROJECT NAME : Zepto SQL Data Analysis
   DATABASE     : MySQL
   AUTHOR       : Sangram Singh Chouhan
   DESCRIPTION  : End-to-end SQL analysis on quick-commerce
                  grocery product data inspired by Zepto
   ===================================================== */

/* =====================================================
   1. DATABASE CREATION
   ===================================================== */
   
create database zepto_sql_project;

/* =====================================================
   2. TABLE CREATION
   ===================================================== */
   
CREATE TABLE zepto (
    sku_id INT AUTO_INCREMENT PRIMARY KEY,
    
    category VARCHAR(100) NOT NULL,
    name VARCHAR(150) NOT NULL,
    
    mrp DECIMAL(10,2) NOT NULL,
    discount_percent DECIMAL(5,2),
    
    available_quantity INT NOT NULL,
    discounted_selling_price DECIMAL(10,2),
    
    weight_in_gms INT,
    out_of_stock BOOLEAN DEFAULT FALSE,
    
    quantity INT
);

/* =====================================================
   3. DATA EXPLORATION
   Objective: Understand dataset size, structure,
              categories, and missing values
   ===================================================== */
   
-- Total number of records
SELECT COUNT(*) 
FROM zepto;

-- Sample Data Preview
SELECT * 
FROM zepto 
LIMIT 10;

-- To know different product category 
SELECT DISTINCT category 
FROM zepto;

-- TO Find Out Null values
select * 
from zepto
where name is null
or Category is null
or MRP is null
or DiscountPercent is null
or AvailableQuantity is null
or DiscountedSellingPrice is null
or WeightInGms is null
or OutOfStock is null
or Quantity is null;

-- List all products that are currently in stock
SELECT *
FROM zepto
WHERE outofstock = FALSE;

-- List of products in stock vs out_of_stock
select outofstock, count(sku_id)
From zepto
group by OutOfStock;

-- List of product names present multiple times
select name, count(sku_id) as 'No of SKUs'
from zepto
group by name
having count(sku_id) > 1
order by count(sku_id) desc;

/* =====================================================
   4. DATA CLEANING
   Objective: Ensure data quality and consistency
   ===================================================== */

-- List of product with price = 0
select *
from zepto
where mrp = 0 or DiscountedSellingPrice = 0;


-- Remove products with zero MRP
delete from zepto where MRP=0;  

-- Convert paise to rupees
UPDATE zepto
SET mrp = mrp/100.0,
DiscountedSellingPrice = DiscountedSellingPrice/100.0;

-- Validate cleaned pricing
select mrp,DiscountedSellingPrice 
from zepto;

/* =====================================================
   5. BUSINESS INSIGHTS & ANALYSIS
   Objective: Generate actionable insights related to
              pricing, discounts, revenue, and inventory
   ===================================================== */

-- Q1️. Find the top 10 best-value products based on discount percentage
SELECT sku_id,
       name,
       category,
       mrp,
       discountpercent,
       discountedsellingprice
FROM zepto
ORDER BY discountpercent DESC
LIMIT 10;

SELECT*
FROM zepto
LIMIT 5; 


-- Q2. Products with high MRP but out of stock.
SELECT sku_id,
       name,
       category,
       mrp
FROM zepto
WHERE mrp > 300 AND outofstock = true;


-- Q3. Estimated revenue for each category
SELECT category,
       SUM(discountedsellingprice * quantity) AS estimated_revenue
FROM zepto
GROUP BY category
ORDER BY estimated_revenue DESC;

-- Q4. Products with MRP > ₹500 and discount < 10%
SELECT sku_id,
       name,
       category,
       mrp,
       discountpercent
FROM zepto
WHERE mrp > 500
  AND discountpercent < 10;

-- Q5. Top 5 categories with highest average discount
SELECT category,
       AVG(discountpercent) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Price per gram for products above 100g (best value first)
SELECT name,
       category,
       weightingms,
       discountedsellingprice,
       ROUND(discountedsellingprice / weightingms, 2) AS price_per_gram
FROM zepto
WHERE weightingms > 100
ORDER BY price_per_gram ASC;

-- Q7. Group products into Low, Medium, and Bulk weight categories
SELECT name,
       category,
       weightingms,
       CASE
           WHEN weightingms < 200 THEN 'Low'
           WHEN weightingms BETWEEN 200 AND 500 THEN 'Medium'
           ELSE 'Bulk'
       END AS weight_category
FROM zepto;

-- Q8. Total inventory weight per category
SELECT category,
       SUM(weightingms * availablequantity) AS total_inventory_weight_gms
FROM zepto
GROUP BY category
ORDER BY total_inventory_weight_gms DESC;








      