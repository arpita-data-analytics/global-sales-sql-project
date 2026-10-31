CREATE DATABASE sales_analytics;
USE sales_analytics;
# check for unique and null values 
SELECT 'Index', COUNT(*)
FROM Regions
GROUP BY `Index`
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS null_count
FROM Regions
WHERE 'Index' IS NULL;

SELECT `Index`, COUNT(*)
FROM Products
GROUP BY `Index`
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS null_count
FROM Products
WHERE `Index` IS NULL;

SELECT `Customer Index`, COUNT(*)
FROM Customers
GROUP BY `Customer Index`
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS null_count
FROM Customers
WHERE `Customer Index` IS NULL;

SELECT 
    `OrderNumber`,
    `Product Description Index`,
    COUNT(*)
FROM `Sales Order`
GROUP BY 
    `OrderNumber`,
    `Product Description Index`
HAVING COUNT(*) > 1;

SELECT 
    SUM(`OrderNumber` IS NULL) AS null_orders,
    SUM(`Product Description Index` IS NULL) AS null_products
FROM `Sales Order`;

SELECT 
    `Product Name`,
    COUNT(*)
FROM `2017 budgets`
GROUP BY `Product Name`
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS null_count
FROM `2017 budgets`
WHERE `Product Name` IS NULL;

# add primary keys (unique and non null columns)
ALTER TABLE Regions
ADD PRIMARY KEY (`Index`);

ALTER TABLE Products
ADD PRIMARY KEY (`Index`);

ALTER TABLE Customers
ADD PRIMARY KEY (`Customer Index`);

ALTER TABLE `Sales Order`
ADD PRIMARY KEY (
    `OrderNumber`,
    `Product Description Index`
);
ALTER TABLE `2017 Budgets`
ADD PRIMARY KEY (`Product Name`);

# create foreign keys
ALTER TABLE `Sales Order`
ADD CONSTRAINT fk_sales_customer
FOREIGN KEY (`Customer Name Index`)
REFERENCES Customers (`Customer Index`);

ALTER TABLE `Sales Order`
ADD CONSTRAINT fk_sales_product
FOREIGN KEY (`Product Description Index`)
REFERENCES Products (`Index`);

ALTER TABLE `Sales Order`
ADD CONSTRAINT fk_sales_region
FOREIGN KEY (`Delivery Region Index`)
REFERENCES Regions (`Index`);

# KPI'S 
SELECT
    COUNT(DISTINCT `OrderNumber`) AS total_orders,
    SUM(`Order Quantity`) AS total_units_sold,
    SUM(`Line Total`) AS total_sales
FROM `Sales Order`;

# TOTAL ORDERS, TOTAL UNITS SOLD  AND TOTAL SALES BY CHANNEL 
SELECT
    Channel,
    COUNT(DISTINCT `OrderNumber`) AS total_orders,
    SUM(`Order Quantity`) AS total_units_sold,
    SUM(`Line Total`) AS total_sales
FROM `Sales Order`
GROUP BY Channel
ORDER BY total_sales DESC;

# PERCENTAGE OF TOTAL SALES EACH CHANNEL CONTRIBUTES
SELECT
    Channel,
    SUM(`Line Total`) AS total_sales,
    ROUND(
        SUM(`Line Total`) /
        SUM(SUM(`Line Total`)) OVER () * 100,
        2
    ) AS sales_contribution_pct
FROM `Sales Order`
GROUP BY Channel
ORDER BY total_sales DESC;

# AVERAGE ORDER VALUE BY CHANNEL 
SELECT
    Channel,
    COUNT(DISTINCT `OrderNumber`) AS total_orders,
    SUM(`Line Total`) AS total_sales,
    ROUND(
        SUM(`Line Total`) / COUNT(DISTINCT `OrderNumber`),
        2
    ) AS average_order_value
FROM `Sales Order`
GROUP BY Channel
ORDER BY average_order_value DESC;

# TOTAL ORDERS, TOTAL UNITS SOLD ,TOTAL SALES BY COUNTRY  
SELECT
    r.Country,
    COUNT(DISTINCT s.`OrderNumber`) AS total_orders,
    SUM(s.`Order Quantity`) AS total_units_sold,
    SUM(s.`Line Total`) AS total_sales
FROM `Sales Order` s
JOIN Regions r
    ON s.`Delivery Region Index` = r.`Index`
GROUP BY r.Country
ORDER BY total_sales DESC;

# COUNTRY WISE TOTAL SALES AND SALES CONTRIBUTION  
SELECT
    r.Country,
    SUM(s.`Line Total`) AS total_sales,
    ROUND(
        SUM(s.`Line Total`) /
        SUM(SUM(s.`Line Total`)) OVER () * 100,
        2
    ) AS sales_contribution_pct
FROM `Sales Order` s
JOIN Regions r
    ON s.`Delivery Region Index` = r.`Index`
GROUP BY r.Country
ORDER BY total_sales DESC;

# CITY WISE DISTRIBUTION 
SELECT
    r.Country,
    r.City,
    COUNT(DISTINCT s.`OrderNumber`) AS total_orders,
    SUM(s.`Order Quantity`) AS total_units_sold,
    SUM(s.`Line Total`) AS total_sales
FROM `Sales Order` s
JOIN Regions r
    ON s.`Delivery Region Index` = r.`Index`
GROUP BY
    r.Country,
    r.City
ORDER BY
    total_sales DESC
    limit 10;
    
# THESE 10 CITIES CONTRIBUTION TO ENTIRE SALES
SELECT
    SUM(total_sales) AS top_10_city_sales,
    ROUND(
        SUM(total_sales) /
        (SELECT SUM(`Line Total`)
         FROM `Sales Order`) * 100,
        2
    ) AS top_10_city_contribution_pct
FROM (
    SELECT
        r.City,
        SUM(s.`Line Total`) AS total_sales
    FROM `Sales Order` s
    JOIN Regions r
        ON s.`Delivery Region Index` = r.`Index`
    GROUP BY r.City
    ORDER BY total_sales DESC
    LIMIT 10
) AS top_cities;

# PRODUCT WISE SALES 
SELECT
    p.`Product Name`,
    SUM(s.`Order Quantity`) AS total_units_sold,
    SUM(s.`Line Total`) AS total_sales
FROM `Sales Order` s
JOIN Products p
    ON s.`Product Description Index` = p.`Index`
GROUP BY p.`Product Name`
ORDER BY total_sales DESC;

# PRODUCT WISE SALES CONTRIBUTION PERCENATGE
SELECT
    p.`Product Name`,
    SUM(s.`Line Total`) AS total_sales,
    ROUND(
        SUM(s.`Line Total`) /
        SUM(SUM(s.`Line Total`)) OVER () * 100,
        2
    ) AS sales_contribution_pct
FROM `Sales Order` s
JOIN Products p
    ON s.`Product Description Index` = p.`Index`
GROUP BY p.`Product Name`
ORDER BY total_sales DESC;

# AVERAGE SELLING PRICE FOR EACH PRODUCT 
SELECT
    p.`Product Name`,
    SUM(s.`Order Quantity`) AS total_units_sold,
    SUM(s.`Line Total`) AS total_sales,
    ROUND(
        SUM(s.`Line Total`) / SUM(s.`Order Quantity`),
        2
    ) AS average_selling_price
FROM `Sales Order` s
JOIN Products p
    ON s.`Product Description Index` = p.`Index`
GROUP BY p.`Product Name`
ORDER BY average_selling_price DESC;

# CUSTOMER WISE TOTAL ORDERS, UNITS SOLD AND TOTAL SALES 
SELECT
    c.`Customer Names`,
    COUNT(DISTINCT s.`OrderNumber`) AS total_orders,
    SUM(s.`Order Quantity`) AS total_units_sold,
    SUM(s.`Line Total`) AS total_sales
FROM `Sales Order` s
JOIN Customers c
    ON s.`Customer Name Index` = c.`Customer Index`
GROUP BY c.`Customer Names`
ORDER BY total_sales DESC
limit 10 ;

# AVERAGE ORDER VALUE OF EACH CUSTOMER 
SELECT
    c.`Customer Names`,
    COUNT(DISTINCT s.`OrderNumber`) AS total_orders,
    SUM(s.`Line Total`) AS total_sales,
    ROUND(
        SUM(s.`Line Total`) /
        COUNT(DISTINCT s.`OrderNumber`),
        2
    ) AS average_order_value
FROM `Sales Order` s
JOIN Customers c
    ON s.`Customer Name Index` = c.`Customer Index`
GROUP BY c.`Customer Names`
ORDER BY average_order_value DESC;

# CUSTOMER PLACING MORE THAN ONE ORDER
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE
        WHEN total_orders > 1 THEN 1
        ELSE 0
    END) AS repeat_customers,
    SUM(CASE
        WHEN total_orders = 1 THEN 1
        ELSE 0
    END) AS one_time_customers
FROM (
    SELECT
        `Customer Name Index`,
        COUNT(DISTINCT `OrderNumber`) AS total_orders
    FROM `Sales Order`
    GROUP BY `Customer Name Index`
) AS customer_orders;

# CUSTOMERS WHO GENERATE HIGH SALES WITH REALTIVELY FEW ORDERS 
SELECT
    c.`Customer Names`,
    COUNT(DISTINCT s.`OrderNumber`) AS total_orders,
    SUM(s.`Line Total`) AS total_sales,
    ROUND(
        SUM(s.`Line Total`) / COUNT(DISTINCT s.`OrderNumber`),
        2
    ) AS average_order_value
FROM `Sales Order` s
JOIN Customers c
    ON s.`Customer Name Index` = c.`Customer Index`
GROUP BY c.`Customer Names`
HAVING COUNT(DISTINCT s.`OrderNumber`) >= 50
ORDER BY average_order_value DESC;

# RANK CUSTOMERS BASED ON THEIR TOTAL SALES
SELECT
    c.`Customer Names`,
    SUM(s.`Line Total`) AS total_sales,
    RANK() OVER (
        ORDER BY SUM(s.`Line Total`) DESC
    ) AS customer_rank
FROM `Sales Order` s
JOIN Customers c
    ON s.`Customer Name Index` = c.`Customer Index`
GROUP BY c.`Customer Names`
ORDER BY customer_rank;

# CHANGING THE DATE FORMAT  
SELECT
    `OrderDate`,
    STR_TO_DATE(`OrderDate`, '%d-%m-%Y') AS converted_date
FROM `Sales Order`
LIMIT 10;

# MONTHLY SALES
SELECT
    YEAR(STR_TO_DATE(`OrderDate`, '%d-%m-%Y')) AS order_year,
    MONTH(STR_TO_DATE(`OrderDate`, '%d-%m-%Y')) AS order_month,
    SUM(`Line Total`) AS total_sales
FROM `Sales Order`
GROUP BY
    YEAR(STR_TO_DATE(`OrderDate`, '%d-%m-%Y')),
    MONTH(STR_TO_DATE(`OrderDate`, '%d-%m-%Y'))
ORDER BY
    order_year,
    order_month;
    
# YEARLY SALES
SELECT
    YEAR(STR_TO_DATE(`OrderDate`, '%d-%m-%Y')) AS order_year,
    SUM(`Line Total`) AS total_sales
FROM `Sales Order`
GROUP BY YEAR(STR_TO_DATE(`OrderDate`, '%d-%m-%Y'))
ORDER BY order_year;

# PERCENT CHANGE IN SALES COMPARED WITH PREVIOUS YEAR 
SELECT
    order_year,
    total_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY order_year))
        / LAG(total_sales) OVER (ORDER BY order_year) * 100,
        2
    ) AS yoy_growth_pct
FROM (
    SELECT
        YEAR(STR_TO_DATE(`OrderDate`, '%d-%m-%Y')) AS order_year,
        SUM(`Line Total`) AS total_sales
    FROM `Sales Order`
    GROUP BY YEAR(STR_TO_DATE(`OrderDate`, '%d-%m-%Y'))
) AS yearly_sales
ORDER BY order_year;

# HIGH , MEDIUM AND LOW VALUE CUSTOMERS
SELECT
    c.`Customer Names`,
    SUM(s.`Line Total`) AS total_sales,
    CASE
        WHEN SUM(s.`Line Total`) >= 3000 THEN 'High Value'
        WHEN SUM(s.`Line Total`) >= 1500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM `Sales Order` s
JOIN Customers c
    ON s.`Customer Name Index` = c.`Customer Index`
GROUP BY c.`Customer Names`
ORDER BY total_sales DESC;



    










