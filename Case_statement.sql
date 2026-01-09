/*
Create a report showing total sales for each of the following categories:
High(sales over 50), Medium(sales 21-50), and low(sales 20 or less)
Sort the categories from highest sales to lowest
*/
SELECT
Category,
SUM(Sales) AS TotalSales
	FROM(
	SELECT
	OrderID,
	Sales,
	CASE
		WHEN Sales > 50 THEN 'High'
		WHEN Sales > 20 THEN 'Medium'
		ELSE 'Low'
	END Category
	FROM Sales.Orders
)t
GROUP BY Category
ORDER BY TotalSales DESC

-- Retrieve employee details with gender displayed as full text
SELECT
EmployeeID,
Gender,
CASE
	WHEN Gender = 'M' THEN 'Male'
	ELSE 'Female'
END [Full Gender]
FROM Sales.Employees

-- Retrieve custoomers details with abbreviated country code
SELECT
CustomerID,
Country,
CASE
	WHEN Country = 'Germany' THEN 'Ger'
	WHEN Country = 'USA' THEN 'US'
	ELSE 'N/A'
END [Abbreviated Country Names]
FROM
Sales.Customers

/*
Find the average scores of customers and treat Nulls as 0.
Additionally provide details such as CustomerID and LastName
*/
SELECT
CustomerID,
LastName,
Score,
CASE
	WHEN Score IS NULL THEN 0
	ELSE Score
END Adjusted_score,
AVG(Score) OVER() AvgCustomer,
AVG(CASE
	WHEN Score IS NULL THEN 0
	ELSE Score
END) OVER() AvgCustomer2
FROM
Sales.Customers

-- Count how many times each customer has made an order with sales greater than 30
SELECT
CustomerID,
COUNT(*) NormalSalesCount,
SUM(CASE
WHEN Sales > 30 THEN 1
ELSE 0
END) HigherSalesCount
FROM Sales.Orders
GROUP BY CustomerID

