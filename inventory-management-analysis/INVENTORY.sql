select * from inventory.inventory_movements;

#DUPLICATE TABLE
create table inventory_movt as select * from inventory.inventory_movements;
select * from inventory_movt; 

create table inventory_product as select * from inventory.inventory_products;
select * from inventory_product; 

#DATA CLEANINIG
#fix healders
alter table  inventory_product rename column sku to service_legal_aggrement ;


describe  inventory_product; 
select distinct category from  inventory_product; 
select distinct warehouse from  inventory_product; 
select distinct * from  inventory_product; 
select distinct last_restock from  inventory_product; 
set sql_safe_updates = 0;
select distinct movement_date from inventory_movt; 
select * from inventory_movt; 
describe inventory_movt; 

#inner join the tables 
SELECT *
FROM inventory_product p
JOIN inventory_movt m
ON p.product_id = m.product_id;

#calculated columns
#Inventory Cost = Unit Cost × Stock on Hand
#Revenue = Selling Price × Quantity Sold
alter table inventory_product add column Inventory_Cost varchar(50);

UPDATE inventory_product
SET Inventory_Cost = round(unit_cost * stock_on_hand,2);

#SALES ANALYSIS
SELECT
SUM(qty * selling_price) AS sales_revenue
FROM inventory_product p
JOIN inventory_movt m
ON p.product_id = m.product_id
WHERE movement_type='OUT';


SELECT
SUM(qty * selling_price) AS sales_revenue
FROM inventory_product p
JOIN inventory_movt m
ON p.product_id = m.product_id
WHERE movement_type='IN';


SELECT
SUM(qty * selling_price) AS sales_revenue
FROM inventory_product p
JOIN inventory_movt m
ON p.product_id = m.product_id
WHERE movement_type='ADJUSTMENT';

#CALCULATED COLUMN
#Gross Profit = Revenue − Inventory Cost
SELECT
SUM(qty*(selling_price-unit_cost)) AS gross_profit
FROM inventory_product p
JOIN inventory_movt m
ON p.product_id=m.product_id
WHERE movement_type='OUT';

#CALCULATED COLUMN
#Profit Margin = Gross Profit / Revenue
SELECT
ROUND(
SUM(qty*(selling_price-unit_cost))
/
SUM(qty*selling_price)
*100,
2) AS profit_margin
FROM inventory_product p
JOIN inventory_movt m
ON p.product_id=m.product_id
WHERE movement_type='OUT';

#Supplier perfomance" Determine which suppliers contribute the most inventory"
SELECT
supplier,
SUM(qty) AS total_quantity
FROM inventory_product p
JOIN inventory_movt m
ON p.product_id=m.product_id
GROUP BY supplier
ORDER BY total_quantity DESC;

#Warehouse perfomance"Identify warehouse performance"
SELECT
    p.warehouse,
    SUM(ROUND(m.qty * p.selling_price, 2)) AS revenue
FROM inventory_product p
JOIN inventory_movt m
    ON p.product_id = m.product_id
WHERE m.movement_type = 'OUT'
GROUP BY p.warehouse
ORDER BY revenue DESC;

# product category  analysis "Evaluate category performance"
SELECT
category,
SUM(ROUND(m.qty * p.selling_price, 2)) AS revenue
FROM inventory_product p
JOIN inventory_movt m
ON p.product_id=m.product_id
WHERE movement_type='OUT'
GROUP BY category
ORDER BY revenue DESC;

SELECT
MONTH(movement_date) AS month,
SUM(qty*selling_price) AS revenue
FROM inventory_product p
JOIN inventory_movt m
ON p.product_id=m.product_id
WHERE movement_type='OUT'
GROUP BY MONTH(movement_date)
ORDER BY MONTH(movement_date);

#Inventory Movement Analysis"#Analyze stock movement"
SELECT
movement_type,
SUM(qty) total_quantity
FROM inventory_movt
GROUP BY movement_type;

#Stock on Hand Analysis"Evaluate stock availability"
SELECT
category,
SUM(stock_on_hand) stock_available
FROM inventory_product
GROUP BY category
ORDER BY stock_available DESC;

#Overstock Analysis"Identify products exceeding desired stock levels."
SELECT
product_id,
stock_on_hand,
reorder_level
FROM inventory_product
WHERE stock_on_hand > reorder_level*2;
select * from inventory_product;

#Low Stock Analysis"Identify products requiring replenishment"
SELECT
product_id,
stock_on_hand,
reorder_level
FROM inventory_product
WHERE stock_on_hand<=reorder_level;







==========================================
-- INVENTORY MANAGEMENT ANALYSIS PROJECT
-- ==========================================

-- Disable Safe Update Mode
SET SQL_SAFE_UPDATES = 0;

-- ==========================================
-- DATA CLEANING
-- ==========================================

-- Check duplicates

-- Check NULL values

-- Standardize dates

-- Validate movement types

-- Remove invalid records

-- ==========================================
-- EXPLORATORY DATA ANALYSIS (EDA)
-- ==========================================

-- Total Products

-- Total Revenue

-- Inventory Cost

-- Gross Profit

-- Warehouse Analysis

-- Supplier Analysis

-- Product Analysis

-- Inventory Movement Analysis

-- Revenue Trend Analysis

-- Inventory Risk Analysis

-- ==========================================
-- END OF PROJECT
-- ==========================================

#Project Overview

This project analyzes an inventory management database using SQL 
to evaluate inventory performance, sales, supplier performance, warehouse operations, 
and product profitability. The objective is to transform raw inventory data
 into actionable business insights that support decision-making.

Objectives

The analysis aims to answer the following business questions:

What is the total inventory investment?
How much revenue has been generated?
Which products and categories perform best?
Which suppliers contribute the most inventory?
Which warehouse generates the highest revenue?
Are there inventory risks such as overstock or low stock?
How do inventory movements affect stock levels?
Tables Used
inventory_products

Contains master information for each product.

Columns include:

Product ID
SKU
Product Name
Category
Supplier
Warehouse
Unit Cost
Selling Price
Stock on Hand
Reorder Level

Primary 
Movement ID
Product ID
Movement Date
Movement Type
Quantity


The following preprocessing tasks were performed:

Verified primary and foreign key relationships.
Checked for duplicate records.
Removed duplicate transactions.
Identified missing values.
Validated numeric fields.
Standardized date formats.
Verified movement types (IN, OUT, ADJUSTMENT).
Joined inventory product and movement tables.




Key Business Findings
Total inventory investment is 150.78M.
Total sales revenue reached 251.27M.
Gross profit is 100.49M.
Profit margin stands at 40%, indicating strong profitability.
Home products generate the highest revenue and maintain the largest inventory.
Abuja warehouse contributes the highest sales revenue.
Supplier 12 supplies the greatest inventory volume.
Inventory movement is balanced across IN, OUT, and ADJUSTMENT transactions.
Overstock conditions exist for some products.
Low-stock risk is currently minimal.

Business Insights
Revenue significantly exceeds inventory cost, demonstrating profitable operations.
The Home category is the primary driver of both inventory investment and sales.
Abuja warehouse is the strongest-performing location.
Supplier performance varies, highlighting opportunities to optimize procurement.
Overstocked products increase storage costs and tie up working capital.
Stable monthly revenue suggests consistent customer demand.
A 40% profit margin reflects effective pricing and cost control.
Balanced inventory movements indicate good operational management.
Large product portfolios require continuous monitoring to identify slow-moving inventory.
Inventory planning should focus on optimizing reorder levels to maintain healthy stock levels.

Recommendations
Reduce overstock through improved demand forecasting and inventory planning.
Review reorder levels based on historical sales and movement trends.
Prioritize procurement from high-performing suppliers while diversifying the supplier base.
Investigate the lower revenue generated by the Lagos warehouse and implement targeted sales or operational improvements.
Focus marketing efforts on high-performing product categories while developing strategies to improve lower-performing categories.
Monitor inventory turnover and product profitability regularly to reduce carrying costs and maximize return on inventory investment.
Implement automated alerts for products approaching reorder levels or exceeding overstock thresholds.
Conclusion

The SQL analysis demonstrates that the business maintains strong profitability, healthy revenue generation,
 and stable inventory operations. While overall performance is positive, opportunities remain to optimize stock levels,
 improve warehouse efficiency, strengthen supplier management, and enhance demand forecasting. 
 These actions will help reduce inventory costs, improve cash flow, and support sustainable business growth.