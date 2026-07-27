SELECT 
    SUM("Sales") AS total_sales,
    SUM("Profit") AS total_profit,
    COUNT(DISTINCT "Order ID") AS total_orders,
    COUNT(DISTINCT "Customer ID") AS total_customers
FROM orders;