-- =========================================
-- SALES PERFORMANCE ANALYSIS
-- =========================================

-- =========================================
-- 1. DATA VALIDATION
-- =========================================

-- Total records
SELECT COUNT(*) AS total_records
FROM orders;

-- Date range
SELECT 
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order
FROM orders;

-- Missing values
SELECT
    COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
    COUNT(*) FILTER (WHERE profit IS NULL) AS missing_profit,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customers
FROM orders;


-- =========================================
-- 2. EXECUTIVE KPI SUMMARY
-- =========================================

SELECT
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(AVG(sales),2) AS average_order_value,
    ROUND((SUM(profit) / SUM(sales)) * 100,2) AS overall_profit_margin_pct
FROM orders;


-- =========================================
-- 3. SALES TREND OVER TIME
-- =========================================

SELECT
    year,
    EXTRACT(MONTH FROM order_date) AS month_number,
    month,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY year, month_number, month
ORDER BY year, month_number;


-- =========================================
-- 4. CATEGORY PERFORMANCE
-- =========================================

SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(AVG(profit_margin),2) AS avg_profit_margin_pct
FROM orders
GROUP BY category
ORDER BY total_sales DESC;


-- =========================================
-- 5. SUB-CATEGORY PERFORMANCE
-- =========================================

SELECT
    sub_category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY sub_category
ORDER BY total_sales DESC;


-- =========================================
-- 6. REGIONAL PERFORMANCE
-- =========================================

SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_sales DESC;


-- =========================================
-- 7. TOP 10 PRODUCTS
-- =========================================

SELECT
    product_name,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;


-- =========================================
-- 8. CUSTOMER SEGMENT PERFORMANCE
-- =========================================

SELECT
    segment,
    COUNT(DISTINCT customer_id) AS customers,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY segment
ORDER BY total_sales DESC;


-- =========================================
-- 9. SHIPPING PERFORMANCE
-- =========================================

SELECT
    ship_mode,
    ROUND(AVG(shipping_days),2) AS avg_shipping_days,
    COUNT(*) AS total_orders
FROM orders
GROUP BY ship_mode
ORDER BY avg_shipping_days;


-- =========================================
-- 10. LOSS-MAKING PRODUCTS
-- =========================================

SELECT
    product_name,
    ROUND(SUM(profit),2) AS total_profit
FROM orders
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;