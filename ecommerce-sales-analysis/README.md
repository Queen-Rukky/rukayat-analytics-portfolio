# 🛍️ Ecommerce Sales Analysis

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

Diving into the data analyst job, one of the first things a business asks is: can we trust our own sales numbers? This project takes a raw, messy export from a beauty and skincare ecommerce brand, cleans it, and turns it into a revenue dashboard the business can actually use to make decisions about products, channels, and markets. The problem it solves is simple but common: the data existed, but nobody could read it.

## 🧩 Background

The raw dataset covered 250+ orders across ten skincare, makeup, haircare, body care, and fragrance products, sold through five channels (Email, Instagram, Mobile App, Website, WhatsApp) to customers in eight countries. Before any analysis could happen, the data needed serious cleanup: inconsistent capitalization ("Uk" vs "UK" vs "United Kingdom"), category typos ("Fragranse", "skincre", "Bodycare"), duplicate country spellings ("Kenia" vs "Kenya", "U.A.E" vs "Uae"), a handful of negative revenue and negative unit price entries, discount rates outside the valid 0 to 1 range, and missing order dates.

## 📊 Dashboard Screenshots

*Screenshots to be added: export the pivot dashboard views from Excel (Revenue by Month, Revenue by Country, Revenue by Product, Sales Channel breakdown) as PNG and drop them in an `/assets` folder here, then reference them below.*

`![Revenue Dashboard](./assets/revenue-dashboard.png)`

## 🛠️ Tools Used

- **Excel** — data cleaning, PivotTables, PivotCharts
- **Quality flagging** — built-in Valid / Outlier / Invalid classification to separate trustworthy rows from noise before aggregating

## 🔍 The Analysis

After standardizing country names, product categories, and channel labels, and flagging invalid rows (negative prices, out-of-range discounts), the cleaned dataset fed a set of pivot tables answering the business's core questions:

- **Revenue by month**: April was the strongest month at $11,816.94, followed by January ($9,075.09) and June ($8,812.47)
- **Revenue by country**: Nigeria led at $8,825.51, followed by UAE ($7,909.59) and Canada ($7,527.02)
- **Top products by revenue**: Eyeshadow Palette ($4,190.38), Shea Butter Lotion ($3,028.77), and Oud Perfume ($2,915.66) were the top three
- **Data quality**: of 256 orders, 249 were valid, 4 were statistical outliers, and 3 were invalid (zero or negative prices)

**The quality flag in the source data — used to separate trustworthy rows before aggregating:**

```
quality_flag: "Valid" | "Outlier" | "Invalid"
Price_flag:   "Valid" | "Invalid"
```

## 💡 What I Learned

Messy real-world data rarely announces itself. The same country showed up spelled five different ways, and a channel like "WhatsApp" appeared in at least four casings. Catching that before aggregating, instead of after, is what separates a dashboard people trust from one they quietly stop using. I also learned to flag rather than silently delete questionable rows, so the business could see exactly what was excluded and why.

## ✅ Conclusion

The cleaned dataset shows a business with strong repeat categories (skincare and makeup driving the bulk of revenue) and a clear seasonal pattern peaking in April. Website and WhatsApp are the strongest sales channels by volume, giving the business a clear signal on where to invest in customer experience.

## 🎯 Closing Thought

Good data storytelling starts before the first chart gets built, it starts with deciding what to trust. This project was as much about earning that trust as it was about the numbers themselves.
