-- ===========================================
-- Customer Churn Analysis (Telco Dataset)
-- SQL Queries
-- ===========================================

-- 1. Overall Churn Rate
SELECT 
    ROUND(100.0 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM customers;

-- ------------------------------------------------

-- 2. Churn by Contract Type
SELECT Contract,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(100.0 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM customers
GROUP BY Contract
ORDER BY churn_rate_percent DESC;

-- ------------------------------------------------

-- 3. Churn by Payment Method
SELECT PaymentMethod,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(100.0 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM customers
GROUP BY PaymentMethod
ORDER BY churn_rate_percent DESC;

-- ------------------------------------------------

-- 4. Churn by Internet Service
SELECT InternetService,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(100.0 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM customers
GROUP BY InternetService
ORDER BY churn_rate_percent DESC;

-- ------------------------------------------------

-- 5. Average Monthly Charges and Tenure (Churn vs Non-Churn)
SELECT Churn,
       ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
       ROUND(AVG(TotalCharges), 2) AS avg_total_charges,
       ROUND(AVG(tenure), 1) AS avg_tenure
FROM customers
GROUP BY Churn;

-- ------------------------------------------------

-- 6. High-Risk Segments (Contract + InternetService + PaymentMethod)
SELECT Contract, InternetService, PaymentMethod,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(100.0 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percent
FROM customers
GROUP BY Contract, InternetService, PaymentMethod
HAVING COUNT(*) > 50
ORDER BY churn_rate_percent DESC
LIMIT 10;

-- ===========================================
-- END OF ANALYSIS
-- ===========================================
