-- Check total records
SELECT COUNT(*) AS total_records
FROM orders;


-- Check date range
SELECT 
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order
FROM orders;


-- Check missing values
SELECT
    COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
    COUNT(*) FILTER (WHERE profit IS NULL) AS missing_profit,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customers
FROM orders;

-- Dashboard kpis
SELECT
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(AVG(sales),2) AS average_order_value
FROM orders;

-- Sales trend over time
SELECT
    year,
    month,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
GROUP BY year, month
ORDER BY year, 
         MIN(order_date);


-- Sales by category, region, and product
SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY category
ORDER BY total_sales DESC;

-- Regional performance
SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

-- Top 10 products 
SELECT
    product_name,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;