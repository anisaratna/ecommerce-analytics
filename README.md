# E-Commerce Business & Marketing Analytics (Olist Dataset)

## Project Overview
This project provides a comprehensive business analysis of the **Brazilian E-Commerce (Olist)** dataset. The goal is to transform raw transactional data into actionable executive insights, focusing on revenue trends, category performance, and marketing effectiveness through statistical testing.

## Business Problems Solved
1. **Trend Identification:** Which months show significant growth or anomalies?
2. **Category Deep-Dive:** Which high-revenue categories suffer from low customer satisfaction?
3. **Strategy Validation:** Does a 10% Discount perform better than Free Shipping in increasing Average Order Value (AOV)?

## Tech Stack
* **Data Warehouse:** Google BigQuery (SQL)
* **Statistical Analysis:** Python (Pandas, Scipy.stats)
* **Visualization:** Looker Studio

## Key Insights & Methodology
### 1. SQL Data Mart Construction
I engineered a unified **Data Mart** using Advanced SQL (CTEs, Joins, and Coalesce functions) to consolidate orders, products, reviews, and customer data into a single analytical layer.

### 2. A/B Testing Simulation (Python)
I conducted a T-Test to compare two marketing strategies:
* **Control:** Free Shipping
* **Variant:** 10% Discount
* **Result:** The 10% Discount group showed a significantly higher AOV ($128.77) vs Free Shipping ($119.07) with a **P-value of 7.53e-20**, proving the result is statistically significant.

### 3. Executive Dashboard
<img width="967" height="699" alt="Screenshot 2026-04-16 202910" src="https://github.com/user-attachments/assets/acfc412e-ad78-4027-9952-fea96f43b597" />

## Recommendations
* **Logistics Audit:** Categories like `bed_bath_table` show high revenue but low ratings (3.9). Investigation into delivery damage or shipping costs for heavy items is recommended.
* **Marketing Focus:** Prioritize price discounts over shipping waivers, as customers show higher sensitivity to product pricing.
