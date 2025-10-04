-- ===========================================
-- HR Attrition Analysis (IBM HR Dataset)
-- ===========================================

-- 1. Attrition Rate by Department
SELECT Department,
       COUNT(*) FILTER (WHERE Attrition = 'Yes')::decimal / COUNT(*) * 100 AS attrition_rate_pct
FROM hr_data
GROUP BY Department
ORDER BY attrition_rate_pct DESC;

-- 2. Attrition by Job Role
SELECT JobRole,
       COUNT(*) FILTER (WHERE Attrition = 'Yes') AS attrition_count,
       ROUND(COUNT(*) FILTER (WHERE Attrition = 'Yes')::decimal / COUNT(*) * 100, 2) AS attrition_rate_pct
FROM hr_data
GROUP BY JobRole
ORDER BY attrition_rate_pct DESC;

-- 3. Attrition by Age Band
SELECT CASE
         WHEN Age < 30 THEN '<30'
         WHEN Age BETWEEN 30 AND 40 THEN '30-40'
         WHEN Age BETWEEN 40 AND 50 THEN '40-50'
         ELSE '50+'
       END AS age_band,
       COUNT(*) FILTER (WHERE Attrition = 'Yes') AS attrition_count,
       ROUND(COUNT(*) FILTER (WHERE Attrition = 'Yes')::decimal / COUNT(*) * 100, 2) AS attrition_rate_pct
FROM hr_data
GROUP BY age_band
ORDER BY age_band;

-- 4. Attrition vs Salary Bands
SELECT CASE
         WHEN MonthlyIncome < 3000 THEN '<3000'
         WHEN MonthlyIncome BETWEEN 3000 AND 5000 THEN '3000-5000'
         WHEN MonthlyIncome BETWEEN 5001 AND 8000 THEN '5001-8000'
         ELSE '8000+'
       END AS salary_band,
       COUNT(*) FILTER (WHERE Attrition = 'Yes') AS attrition_count,
       ROUND(COUNT(*) FILTER (WHERE Attrition = 'Yes')::decimal / COUNT(*) * 100, 2) AS attrition_rate_pct
FROM hr_data
GROUP BY salary_band
ORDER BY salary_band;

-- 5. Average Tenure of Attrited vs Active Employees
SELECT Attrition,
       ROUND(AVG(YearsAtCompany), 2) AS avg_tenure
FROM hr_data
GROUP BY Attrition;

-- ===========================================
-- END OF QUERIES
-- ===========================================
