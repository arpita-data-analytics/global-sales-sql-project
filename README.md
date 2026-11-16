# Sales Analytics Dashboard | SQL & Power BI

## 📌 Project Overview

This project focuses on analysing sales performance using **MySQL and Microsoft Power BI**. The objective is to transform raw sales data into meaningful business insights by using SQL queries for data analysis and Power BI for interactive dashboard development.

The project explores sales trends, customer behaviour, product performance and regional sales to support data-driven business decisions.

## 🛠️ Tools & Technologies

- **MySQL:** Database creation, data management, SQL queries and analysis.
- **Microsoft Power BI:** Data modelling, DAX measures, interactive dashboards and visualisation.
- **DAX:** KPI calculations and business metrics.

## 🗄️ Database Structure

The project uses a MySQL database named `sales_analytics`, containing five tables:

| Table | Description |
|---|---|
| Sales Order | Transaction-level sales information |
| Customers | Customer details |
| Products | Product information |
| Regions | Geographical and delivery region details |
| 2017 Budgets | Budget information for 2017 |

## 📊 Key Performance Indicators (KPIs)

The Power BI dashboard includes the following KPIs:

- **Total Sales:** Overall revenue generated.
- **Total Orders:** Number of unique orders.
- **Total Units Sold:** Total quantity of products sold.
- **Average Order Value (AOV):** Average revenue generated per order.

### DAX Measures

```DAX
Total Sales =
SUM('sales_analytics Sales Order'[Line Total])

Total Orders =
DISTINCTCOUNT('sales_analytics Sales Order'[OrderNumber])

Total Units Sold =
SUM('sales_analytics Sales Order'[Order Quantity])

Average Order Value =
DIVIDE([Total Sales], [Total Orders], 0)
```

## 📈 Dashboard Features

The Sales Performance Overview dashboard includes:

1. **Monthly Sales Trend:** Analyses how sales change over time.
2. **Sales by Channel:** Compares sales performance across different sales channels.
3. **Top 5 Products by Sales:** Identifies the products generating the highest revenue.

### Interactive Filters

- Country
- Sales Channel
- Order Date

These filters allow users to explore sales performance across different dimensions.

## 🔍 SQL Analysis

SQL was used to perform business-oriented analysis, including:

- Sales performance by channel.
- Country and city-wise sales analysis.
- Product and customer performance.
- Monthly and yearly sales trends.
- Year-over-year sales growth.
- Repeat and one-time customer analysis.
- Customer value segmentation.

## 💡 Business Objectives

The analysis aims to help businesses:

- Identify high-performing sales channels.
- Understand monthly sales trends.
- Recognise top-performing products.
- Analyse customer purchasing behaviour.
- Evaluate regional sales performance.
- Make informed business decisions using data.

## 📁 Project Files

- `SQL CAPSTONE PROJECT.sql` – SQL database creation, table definitions and analytical queries.
- `Sales Analytics Dashboard.pbix` – Interactive Power BI dashboard.

## 🎯 Key Learnings

Through this project, I gained practical experience in:

- Writing SQL queries for business analysis.
- Working with relational databases and table relationships.
- Connecting MySQL databases to Power BI.
- Creating DAX measures for business KPIs.
- Building interactive dashboards and visualisations.
- Converting raw data into meaningful business insights.

---

**Project Category:** Data Analytics | SQL | Power BI  
**Created by:** Arpita Singh# global-sales-sql-project



