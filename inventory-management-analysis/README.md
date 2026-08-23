# 📦 Inventory Management Analysis

## 📑 Table of Contents
1. [Introduction](#-introduction)
2. [Background](#-background)
3. [Dashboard Screenshots](#-dashboard-screenshots)
4. [Tools Used](#-tools-used)
5. [The Analysis](#-the-analysis)
6. [What I Learned](#-what-i-learned)
7. [Conclusion](#-conclusion)
8. [Closing Thought](#-closing-thought)

## 📌 Introduction

Diving into the data analyst job, inventory is one of the areas where a business can be losing money quietly, tied up in overstock, or missing sales from understock, without anyone noticing until the numbers are pulled together. This project explores an inventory management database and answers the questions a retail operations team actually asks: what is our inventory worth, where is it making money, and where is it at risk.

## 🧩 Background

The dataset covers two linked tables: a product master table (product ID, category, supplier, warehouse, unit cost, selling price, stock on hand, reorder level) and a movement log (IN, OUT, and ADJUSTMENT transactions per product). The analysis was built entirely in SQL, then visualized in an 8-page Power BI report covering executive summary, revenue trend, inventory movement, product-level inventory, time intelligence, and KPIs. Full script: [`INVENTORY.sql`](./INVENTORY.sql)

## 📊 Dashboard Screenshots

*Screenshots to be added: open `INVENTORY - Copy.pbix` in Power BI Desktop and export each page (Executive Analysis, Revenue Trend, Inventory Movement, Product Inventory, KPIs) as PNG to an `/assets` folder here, then reference them below.*

`![Executive Dashboard](./assets/executive-analysis.png)`

## 🛠️ Tools Used

- **MySQL** — data cleaning, table joins, calculated columns, aggregation
- **Power BI** — 8-page interactive dashboard (Executive Analysis, Revenue Trend, Inventory Movement Trend, Product Inventory, Time Intelligence, KPIs, Documentation, Findings & Recommendations)

## 🔍 The Analysis

The SQL work started with cleaning: fixing a mislabeled column header, checking for duplicates, and validating movement types before joining the product and movement tables.

```sql
-- Join product master data with movement log
SELECT *
FROM inventory_product p
JOIN inventory_movt m
ON p.product_id = m.product_id;
```

From there, calculated columns did the heavy lifting — Inventory Cost, Gross Profit, and Profit Margin:

```sql
-- Inventory Cost = Unit Cost × Stock on Hand
UPDATE inventory_product
SET Inventory_Cost = ROUND(unit_cost * stock_on_hand, 2);

-- Gross Profit = Revenue − Inventory Cost
SELECT
  SUM(qty * (selling_price - unit_cost)) AS gross_profit
FROM inventory_product p
JOIN inventory_movt m ON p.product_id = m.product_id
WHERE movement_type = 'OUT';

-- Profit Margin = Gross Profit / Revenue
SELECT
  ROUND(SUM(qty * (selling_price - unit_cost)) / SUM(qty * selling_price) * 100, 2) AS profit_margin
FROM inventory_product p
JOIN inventory_movt m ON p.product_id = m.product_id
WHERE movement_type = 'OUT';
```

Warehouse and overstock risk analysis:

```sql
-- Warehouse performance by revenue
SELECT p.warehouse, SUM(ROUND(m.qty * p.selling_price, 2)) AS revenue
FROM inventory_product p
JOIN inventory_movt m ON p.product_id = m.product_id
WHERE m.movement_type = 'OUT'
GROUP BY p.warehouse
ORDER BY revenue DESC;

-- Overstock: products holding more than double their reorder level
SELECT product_id, stock_on_hand, reorder_level
FROM inventory_product
WHERE stock_on_hand > reorder_level * 2;
```

The full script also breaks performance down by supplier and product category, tracks monthly revenue trend, and flags low-stock risk. See [`INVENTORY.sql`](./INVENTORY.sql) for the complete set of queries.

**Key findings:**
- Total inventory investment: 150.78M
- Total sales revenue: 251.27M
- Gross profit: 100.49M, a 40% profit margin
- Home products generate the highest revenue and hold the largest share of inventory
- Abuja warehouse contributes the highest sales revenue; Lagos underperforms by comparison
- One supplier (Supplier 12) supplies the greatest inventory volume
- Some products are overstocked; low-stock risk is currently minimal

## 💡 What I Learned

Joining product and movement data revealed that "inventory health" isn't one number, it's the interaction of cost, turnover, and location. A product can look fine on paper and still be tying up cash if it's sitting in the wrong warehouse. Building the reorder-level and overstock flags directly into SQL, rather than eyeballing the Power BI charts, made the risk analysis repeatable instead of one-off.

## ✅ Conclusion

The business is profitable and operationally stable, a 40% margin and balanced IN/OUT/ADJUSTMENT movement both point to healthy fundamentals. The clearest opportunities are reducing overstock through better demand forecasting, reviewing reorder levels against actual sales trends, and investigating why the Lagos warehouse underperforms Abuja.

## 🎯 Closing Thought

Inventory data tells you where a business's money is actually sitting, not where the business thinks it's sitting. Turning that into a warehouse-by-warehouse, supplier-by-supplier view is what makes the difference between a report and a decision tool.
