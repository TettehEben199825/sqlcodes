-- Find the total number of orders
SELECT
COUNT(*) NumOfOrders
FROM orders

-- Find the total sales of all orders
SELECT
SUM(sales) TotalSales
FROM
orders

-- Find the average sales of all orders
SELECT
AVG(sales) AverageSales
FROM
orders

-- Find the highest sales of all order
SELECT
MAX(sales) MaxSales
FROM
orders

-- Find the lowest sales of all order
SELECT
MIN(sales) MaxSales
FROM
orders


-- Analyzing the scores in the customer table
SELECT
Country,
COUNT(*) CountOfScores,
SUM(score) TotalSumOfScores,
AVG(score) AvgScore,
MAX(score) MaxScore,
MIN(score) MinScore
FROM Sales.Customers
GROUP BY Country

SELECT * FROM Sales.Customers