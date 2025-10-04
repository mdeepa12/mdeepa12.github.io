-- ===========================================
-- Superstore Sales Analysis (SQL + Python Project)
-- ===========================================

-- 1. Total Sales and Profit by Year
SELECT EXTRACT(YEAR FROM order_date) AS year,
       ROUND(SUM(sales), 2) AS total_sales,
       ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY year
ORDER BY year;

-- 2. Top 10 Customers by Revenue
SELECT customer_name,
       ROUND(SUM(sales), 2) AS revenue
FROM orders
GROUP BY customer_name
ORDER BY revenue DESC
LIMIT 10;

-- 3. Profitability by Category
SELECT category,
       ROUND(SUM(sales), 2) AS total_sales,
       ROUND(SUM(profit), 2) AS total_profit,
       ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin_percent
FROM orders
GROUP BY category
ORDER BY profit_margin_percent DESC;

-- 4. Regional Performance
SELECT region,
       ROUND(SUM(sales), 2) AS total_sales,
       ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

-- 5. Shipping Mode and Profitability
SELECT ship_mode,
       ROUND(AVG(sales), 2) AS avg_sales,
       ROUND(AVG(profit), 2) AS avg_profit
FROM orders
GROUP BY ship_mode
ORDER BY avg_profit DESC;

-- ===========================================
-- END OF QUERIES
-- ===========================================
