-- ===========================================
-- Music Store (Chinook Database) Analysis
-- Advanced SQL Project
-- ===========================================

-- 1. Top 10 Artists by Revenue
SELECT ar.Name AS artist_name,
       ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS total_revenue
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
JOIN Album al ON t.AlbumId = al.AlbumId
JOIN Artist ar ON al.ArtistId = ar.ArtistId
GROUP BY ar.Name
ORDER BY total_revenue DESC
LIMIT 10;

-- 2. Revenue by Genre
SELECT g.Name AS genre,
       ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS total_revenue
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name
ORDER BY total_revenue DESC;

-- 3. Average Customer Spend
SELECT c.CustomerId, c.FirstName || ' ' || c.LastName AS customer_name,
       ROUND(AVG(i.Total), 2) AS avg_invoice_amount,
       ROUND(SUM(i.Total), 2) AS lifetime_value
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, customer_name
ORDER BY lifetime_value DESC
LIMIT 10;

-- 4. Top Countries by Revenue
SELECT c.Country,
       ROUND(SUM(i.Total), 2) AS total_revenue,
       COUNT(DISTINCT i.InvoiceId) AS num_invoices
FROM Invoice i
JOIN Customer c ON i.CustomerId = c.CustomerId
GROUP BY c.Country
ORDER BY total_revenue DESC;

-- 5. Most Popular Tracks (by Purchase Count)
SELECT t.Name AS track_name, ar.Name AS artist_name,
       COUNT(il.InvoiceLineId) AS times_purchased
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
JOIN Album al ON t.AlbumId = al.AlbumId
JOIN Artist ar ON al.ArtistId = ar.ArtistId
GROUP BY t.Name, ar.Name
ORDER BY times_purchased DESC
LIMIT 10;

-- 6. Monthly Revenue Trend (using Window Functions)
SELECT strftime('%Y-%m', i.InvoiceDate) AS month,
       ROUND(SUM(i.Total), 2) AS monthly_revenue,
       ROUND(SUM(SUM(i.Total)) OVER (ORDER BY strftime('%Y-%m', i.InvoiceDate)), 2) AS cumulative_revenue
FROM Invoice i
GROUP BY month
ORDER BY month;

-- ===========================================
-- END OF QUERIES
-- ===========================================
