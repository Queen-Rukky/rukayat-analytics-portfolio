# 🔄 Customer Churn Analysis

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

Diving into the data analyst job, churn is the question every subscription or repeat-purchase business eventually has to face: why are customers leaving, and could support have caught it earlier. This project explores order behavior, customer trends, and support performance together, because churn is rarely just one of those things in isolation.

## 🧩 Background

The dataset connects three angles of the customer relationship: ordering behavior over time, customer-level trends (geography, segment, engagement), and support ticket performance. Rather than building three disconnected reports, the analysis was structured as one Power BI file with six linked pages, so a stakeholder can move from "orders are dropping" to "here's the customer segment" to "here's what support looks like for that segment" without leaving the dashboard.

## 📊 Dashboard Screenshots

Upload `executive-dashboard.png` (the Executive Dashboard page) to an `/assets` folder here — this embed will pick it up automatically:

![Customer Churn Executive Dashboard](./assets/executive-dashboard.png)

## 🛠️ Tools Used

- **Power BI** — 6-page interactive dashboard (Order Trend, Customer Trend, Support Trend, Executive Dashboard, KPIs, Documentation)
- Visuals used: line and combo charts for trend tracking, a funnel and waterfall for order drop-off, a map and pie/donut for customer geography and segment mix, a gauge for support performance, and an advanced slicer for filtering by support category

## 🔍 The Analysis

The **Order Trend** page tracks order volume over time and uses a funnel and waterfall chart to show exactly where in the order journey customers drop off. The **Customer Trend** page maps customer distribution geographically and by segment, paired with a gauge showing engagement against target. The **Support Trend** page isolates support ticket volume and resolution performance, so it's possible to see whether churn clusters around customers who had a bad support experience. All three roll up into an **Executive Dashboard** page with the headline KPIs a manager would check first:

- **Retention Rate**: 1.00
- **Churn Rate**: 0.50 | **Churn Count**: 2K
- **Total amount**: 9.06M | **Revenue per customer**: 1.81K
- Amount by quarter dips through Qtr 2 and Qtr 3 before recovering in Qtr 4
- Churned customers split evenly across the Returning, New, and VIP segments, so churn risk isn't concentrated in one tier
- Gender split among churned customers is close to even

**Report structure (pages → key visuals):**

```
Order Trend        → line chart, funnel, waterfall, KPI cards
Customer Trend      → combo chart, pie chart, map, bar chart, gauge
Support Trend       → gauge, column chart, bar chart, line chart, slicer
Executive Dashboard → combo chart, bar chart, line chart, donut chart
KPIs                → headline KPI cards
Documentation       → methodology notes
```

## 💡 What I Learned

Churn dashboards are easy to build shallow, a single "churn rate" number, and hard to build useful. The useful version needs order behavior, customer segmentation, and support quality sitting next to each other, because the real driver of churn is usually the intersection of two of those, not any one alone. Structuring the report as linked pages rather than one crowded page made that intersection visible instead of buried in a filter panel.

## ✅ Conclusion

With churn spread evenly across Returning, New, and VIP tiers, this isn't a single-segment problem, a retention play aimed at just one group would miss half the risk. Segmenting order trends against support performance surfaces which customer groups are both ordering less and experiencing worse support outcomes, exactly the group most at risk of churning next.

## 🎯 Closing Thought

Retention isn't won or lost in a single report page. It's won in the handoff between what a customer is doing and what support is doing about it, and that handoff is where this dashboard is designed to live.
