# global-sales-sql-project
Relational database analysis of global sales, channels, and customer segmentation using MySQL.
# 📊 Global Sales Analytics & Customer Insights (SQL Capstone Project)

## 🚀 Project Overview
This project delivers a comprehensive end-to-end data analysis and database management system for a global sales enterprise. Using MySQL, the project implements rigorous data cleaning, relational schema design, core business KPIs, and advanced analytical queries (including window functions and conditional segmentation) to uncover critical revenue drivers.

## 🗄️ Database Architecture & Schema Constraints
The relational database consists of core business entities linked with explicit primary and foreign key constraints to ensure data integrity:
- **`Sales Order`**: Transaction-level line items and fact data.
- **`Customers`**: Customer master records and names.
- **`Products`**: Product catalog details and pricing.
- **`Regions`**: Geographic hierarchy tracking by country and city.
- **`2017 Budgets`**: Target financial benchmarks.

## 🔍 Key Business Questions & Analysis Explored
The project script is structured to answer key stakeholder questions across multiple dimensions:
1. **Data Validation:** Initial checks for null values, uniqueness, and primary/foreign key relationships across tables.
2. **Channel Performance:** Evaluation of total orders, units sold, total sales, sales contribution percentages, and average order values (AOV) by sales channel.
3. **Geographic & Product Insights:** Country and top-city revenue distributions, product-level sales contributions, and average selling prices.
4. **Customer Behavior:** Tracking repeat vs. one-time customers, identifying high-value customers, and analyzing purchasing frequency.
5. **Time-Series Analysis:** Monthly and yearly sales trends alongside Year-over-Year (YoY) percentage growth calculations.

## 💡 Advanced SQL Techniques Demonstrated
- **Relational Integrity:** Explicit use of `PRIMARY KEY`, `FOREIGN KEY`, and `CONSTRAINT` definitions.
- **Window Functions:** Leveraging `SUM() OVER ()` for percentage contributions, `RANK()` for customer leaderboard ranking, and `LAG()` for YoY growth calculations.
- **Conditional Logic:** Utilizing `CASE` statements to classify customers into *High Value*, *Medium Value*, and *Low Value* tiers.
- **Data Transformation:** Converting string-based dates into native SQL dates using `STR_TO_DATE()` for temporal aggregation.


