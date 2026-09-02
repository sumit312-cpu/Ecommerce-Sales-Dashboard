SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES; 


--Revenue Analysis:
--Question 1: What is total revenue?

SELECT 
    SUM(payment_value) AS total_revenue
FROM payments;

--Question 2: Orders Count?

SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM orders;

--Question 3: Revenue by City?

SELECT 
    c.customer_city,
    SUM(p.payment_value) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_city
ORDER BY revenue DESC;

--Question 4: Top 10 Products?

SELECT TOP 10
    oi.product_id,
    COUNT(*) AS total_quantity,
    SUM(oi.price + oi.freight_value) AS total_revenue
FROM order_items oi
GROUP BY oi.product_id
ORDER BY total_revenue DESC;

--Question 5: Monthly Sales Trend?

SELECT 
    DATEFROMPARTS(YEAR(o.order_purchase_timestamp), MONTH(o.order_purchase_timestamp), 1) AS month,
    SUM(p.payment_value) AS revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY DATEFROMPARTS(YEAR(o.order_purchase_timestamp), MONTH(o.order_purchase_timestamp), 1)
ORDER BY month;

--6. Average Order Value (AOV):

SELECT 
    AVG(order_total) AS avg_order_value
FROM (
    SELECT 
        order_id,
        SUM(payment_value) AS order_total
    FROM payments
    GROUP BY order_id
) t;

--7. Top 10 Customers (by spending):

SELECT TOP 10
    c.customer_unique_id,
    SUM(p.payment_value) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC;

-- 8. Orders per Customer:

SELECT 
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_orders DESC;

-- 9. Most Used Payment Method:

SELECT 
    payment_type,
    COUNT(*) AS usage_count
FROM payments
GROUP BY payment_type
ORDER BY usage_count DESC;

-- 10. Delivery Time Analysis:

SELECT 
    AVG(DATEDIFF(DAY, order_purchase_timestamp, order_delivered_customer_date)) AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- 11. Revenue by Product Category:

SELECT 
    pr.product_category_name,
    SUM(oi.price + oi.freight_value) AS revenue
FROM order_items oi
JOIN products pr ON oi.product_id = pr.product_id
GROUP BY pr.product_category_name
ORDER BY revenue DESC;

-- 12. Top Selling Cities:

SELECT TOP 10
    c.customer_city,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC;

-- 13. Repeat vs One-time Customers:

WITH customer_orders AS (
    SELECT 
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)
SELECT 
    CASE 
        WHEN order_count = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS total_customers
FROM customer_orders
GROUP BY 
    CASE 
        WHEN order_count = 1 THEN 'One-time'
        ELSE 'Repeat'
    END;

-- 14. Monthly Growth %:

WITH monthly_sales AS (
    SELECT 
        DATEFROMPARTS(YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp), 1) AS month,
        SUM(p.payment_value) AS revenue
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY DATEFROMPARTS(YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp), 1)
)
SELECT 
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS prev_month,
    CASE 
        WHEN LAG(revenue) OVER (ORDER BY month) IS NULL THEN NULL
        ELSE (revenue - LAG(revenue) OVER (ORDER BY month)) * 100.0 /
             LAG(revenue) OVER (ORDER BY month)
    END AS growth_percentage
FROM monthly_sales;

-- 15. High Value Orders:

SELECT 
    o.order_id,
    SUM(p.payment_value) AS total_value
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY o.order_id
HAVING SUM(p.payment_value) >= 1000
ORDER BY total_value DESC;

-- 16. Customer Retention Rate:

 WITH customer_orders AS (
    SELECT 
        c.customer_unique_id,
        COUNT(o.order_id) AS total_orders
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)
SELECT 
    COUNT(CASE WHEN total_orders > 1 THEN 1 END) * 100.0 / COUNT(*) AS retention_rate
FROM customer_orders;

-- 17. Cohort Analysis (Monthly):

SELECT 
    DATEFROMPARTS(YEAR(MIN(o.order_purchase_timestamp)), MONTH(MIN(o.order_purchase_timestamp)), 1) AS cohort_month,
    COUNT(*) AS customers
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
ORDER BY cohort_month;


-- 18. Top Categories by Avg Order Value:

SELECT 
    pr.product_category_name,
    SUM(oi.price + oi.freight_value) / COUNT(DISTINCT oi.order_id) AS avg_order_value
FROM order_items oi
JOIN products pr ON oi.product_id = pr.product_id
GROUP BY pr.product_category_name
ORDER BY avg_order_value DESC;

-- 19. Revenue Share by Payment Type:

SELECT 
    payment_type,
    SUM(payment_value) * 100.0 / 
    (SELECT SUM(payment_value) FROM payments) AS revenue_percentage
FROM payments
GROUP BY payment_type
ORDER BY revenue_percentage DESC;

-- 20. Late Delivery Percentage:

SELECT 
    COUNT(*) * 100.0 / 
    (SELECT COUNT(*) 
     FROM orders 
     WHERE order_delivered_customer_date IS NOT NULL) 
    AS late_delivery_percentage
FROM orders
WHERE 
    order_delivered_customer_date IS NOT NULL
    AND order_delivered_customer_date > order_estimated_delivery_date;


    

