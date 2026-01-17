-- Total Revenue
SELECT SUM(p.price * oi.quantity) AS total_revenue
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id;


-- Average Order Value (AOV)
SELECT 
    SUM(p.price * oi.quantity) / COUNT(DISTINCT o.order_id) AS AOV
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id;


-- Repeat vs New 
SELECT 
    customer_id,
    COUNT(order_id) AS total_orders,
    CASE 
        WHEN COUNT(order_id) > 1 THEN 'Repeat'
        ELSE 'New'
    END AS customer_type
FROM Orders
GROUP BY customer_id;


-- Customer Lifetime Value (CLV)
SELECT 
    c.customer_name,
    SUM(p.price * oi.quantity) AS lifetime_value
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.customer_name;


-- Monthly Revenue (for charts)
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(p.price * oi.quantity) AS revenue
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY month
ORDER BY month;
