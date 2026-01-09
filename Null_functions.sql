-- Find the average scores of the customers
SELECT 
CustomerID,
Score,
COALESCE(Score,0) Score2,
AVG(Score) OVER() AvgScore,
AVG(COALESCE(Score,0)) OVER() AvgScore2
FROM Sales.Customers

/*
Display the full name of customers in a single field by merging
their first and last names, and add 10 bonus to each customer's score
*/
SELECT 
CONCAT(FirstName,' ',LastName) fullName,
FirstName + ' ' + LastName AS fullName2,
Score,
COALESCE(Score, 0) + 10 AS [New Score Bonus]
FROM Sales.Customers

-- Sort the customers from lowest to highest scores,
-- with nulls appearing last

SELECT
CustomerID,
Score
FROM
Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score

-- Find the sales price for each order by dividing sales by quantity
SELECT
OrderID,
Sales,
Quantity,
Sales / NULLIF(Quantity,0) AS Price
FROM
Sales.Orders

-- Identify the customers who have no scores
SELECT
*
FROM Sales.Customers
WHERE Score IS NULL

-- List all customers who have scores
SELECT
*
FROM Sales.Customers
WHERE Score IS NOT NULL

-- List all details of customers who have not placed any orders
SELECT
*
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL


WITH Orders AS(
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' '
)
SELECT *,
DATALENGTH(Category) CatergoryLength,
DATALENGTH(TRIM(Category)) Policy1,
NULLIF(TRIM(Category), '') Policy2,
COALESCE(NULLIF(TRIM(Category), ''), 'Unknown') Policy3
FROM Orders


