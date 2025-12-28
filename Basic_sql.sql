SELECT *
FROM orders

SELECT 
first_name,
country,
score
FROM customers
WHERE score != 0

SELECT * 
FROM customers
WHERE country = 'Germany'
ORDER BY score DESC

SELECT * 
FROM customers
ORDER BY country ASC,score DESC

SELECT 
country, 
SUM(score) AS Total_score,
COUNT(id) AS Total_Customers
FROM customers
GROUP BY country
HAVING SUM(score) >= 850

SELECT country, AVG(score) As Average_Score
FROM
customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430


SELECT DISTINCT country
FROM customers

SELECT TOP 3 *
FROM customers 
ORDER BY score DESC

SELECT * 
FROM orders
ORDER BY 
order_date DESC

