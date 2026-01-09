-- Find the total sales across all orders
SELECT
SUM(Sales) TotalSales
FROM Sales.Orders

-- Find the total sales for each product
SELECT
ProductID,
SUM(Sales) TotatProduct
FROM Sales.Orders
GROUP BY ProductID

/*
Find the total sales for each product,
additionally provide details such as order id & order date
*/
SELECT
OrderID,
OrderDate,
ProductID,
SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProduct
FROM Sales.Orders

-- Find the total sales across all orders. Additionally provide details such as 
-- order Id and order date
SELECT
OrderID,
OrderDate,
SUM(Sales) OVER() [Total Sales]
FROM
Sales.Orders

-- Find the total sales for each product. Additionally provide details such as 
-- order Id and order date
SELECT
OrderID,
OrderDate,
ProductID,
SUM(Sales) OVER(PARTITION BY ProductID) [Total Sales]
FROM
Sales.Orders

-- Find the total sales for each combination of product and order status
SELECT
OrderID,
OrderDate,
OrderStatus,
ProductID,
Sales,
SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) SalesByOrderandStatus
FROM
Sales.Orders

-- ORDER BY
/*
Rank each order based on their sales from highest to lowest.
Additionally provide details such as order Id and order date
*/
SELECT
OrderID,
OrderDate,Sales,
RANK() OVER(ORDER BY Sales DESC) SalesByRank
FROM
SALES.Orders

-- Frame Clause
SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
FROM
Sales.Orders

-- Find the total sales for each status,
-- only for two products 101 and 102
SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus) TotalSales
FROM
Sales.Orders
WHERE ProductID IN (101, 102)

-- Rank customers based on their total sales
SELECT
CustomerID,
SUM(Sales) TotalSales,
RANK() OVER(ORDER BY SUM(Sales) DESC) SalesRank
FROM
Sales.Orders
GROUP BY CustomerID

/*
Find the percentage contribution of each product's sales to the total sales
*/
SELECT
OrderID,
OrderDate,
ProductID,
Sales,
SUM(Sales) OVER() TotalSales,
ROUND(CAST(Sales AS Float)/SUM(Sales) OVER() * 100, 2) PercentageContribution
FROM
Sales.Orders

/*
Find the average sales across all orders and find the average sales for each product.
Additionally provide details such as order Id, order date
*/
SELECT
OrderID,
OrderDate,
Sales,
ProductID,
AVG(CAST(Sales AS Float)) OVER() AvgSales,
AVG(CAST(Sales AS Float)) OVER(PARTITION BY ProductID) AvgSalesByProduct
FROM Sales.Orders

/*
Find the average scores of customers. Additionally
provide details such as CustomerID and LastName
*/
SELECT
CustomerID,
LastName,
Score,
AVG(COALESCE(Score, 0)) OVER() AvgScore
FROM
Sales.Customers

/*
Find all others where sales are higher than the average sales across all orders
*/
SELECT
*
FROM
(
	SELECT
	OrderID,
	ProductID,
	Sales,
	AVG(Sales) OVER() AvgSales
	FROM
	Sales.Orders
)t WHERE Sales > AvgSales


/*
Find the highest & lowest sales across all orders and highest & lowest
sales for each product. Additionally provide details such as order Id and order date.
*/
SELECT
OrderID,
OrderDate,
Sales,
 ProductID,
MAX(Sales) OVER() HighestSales,
MIN(Sales) OVER() LowestSales,
MAX(Sales) OVER(PARTITION BY ProductID) HighestSalesByProduct,
MIN(Sales) OVER(PARTITION BY ProductID) LowestSalesByProduct
FROM
Sales.Orders

/*
Show the employees who have the highest salary
*/
SELECT
*
FROM(
	SELECT
	EmployeeID,
	FirstName,
	Salary,
	MAX(Salary) OVER() HighestSalary
	FROM Sales.Employees
)t WHERE Salary = HighestSalary

/*
Calculate the deviation of each sale from both
the minimum and maximum sales amounts
*/
SELECT
OrderID,
OrderDate,
Sales,
MIN(Sales) OVER() MinSales,
MAX(Sales) OVER() MaxSales,
Sales - MIN(Sales) OVER() MinDev,
MAX(Sales) OVER() - Sales MinDev
FROM Sales.Orders

-- Calculate the moving average of sales for each product over time, including only the next order
SELECT
OrderID,
OrderDate,
ProductID,
Sales,
AVG(Sales) OVER(PARTITION BY ProductID) AvgByProduct,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovingAvg,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) RollingAvg
FROM Sales.Orders


-- ROW_NUMBER()
-- Rank the orders based on their sales from the highest to lowest
SELECT
OrderID,
ProductID,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row
FROM Sales.Orders

-- Rank()
-- Rank the orders based on their sales from the highest to lowest
SELECT
OrderID,
ProductID,
Sales,
RANK() OVER(ORDER BY Sales DESC) SalesRank
FROM Sales.Orders

-- DENSE_RANK()
-- Rank the orders based on their sales from the highest to lowest
SELECT
OrderID,
ProductID,
Sales,
DENSE_RANK() OVER(ORDER BY Sales DESC) SalesRank_Dense
FROM Sales.Orders


-- Find the top highest sales for each product
SELECT *
FROM(
	SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) SalesByProduct 
	FROM Sales.Orders
)t WHERE SalesByProduct = 1


-- Find the lowest 2 customers based on their total sales
SELECT *
FROM(
	SELECT
		CustomerID,
		SUM(Sales) TotalSales,
		ROW_NUMBER() OVER(ORDER BY SUM(Sales)) RankSales
	FROM Sales.Orders
	GROUP BY CustomerID
)t WHERE RankSales <=2

-- Assign a unique IDs to the rows of the Archive table
SELECT
ROW_NUMBER() OVER(ORDER BY OrderID, OrderDate) UniqueID,
*
FROM Sales.OrdersArchive


/*
Identify duplicate rows in the table 'Orders Archive'
and return a clean result without any duplicates
*/
SELECT *
FROM(
	SELECT
	ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) rn,
	*
	FROM Sales.OrdersArchive
)t WHERE rn = 1

-- NTILE() and PERCENT_RANK()
SELECT
OrderID,
Sales,
NTILE(1) OVER(ORDER BY Sales DESC) OneBucket,
NTILE(2) OVER(ORDER BY Sales DESC) TwoBucket,
NTILE(3) OVER(ORDER BY Sales DESC) ThreeBucket,
NTILE(4) OVER(ORDER BY Sales DESC) FourBucket,
NTILE(5) OVER(ORDER BY Sales DESC) FiveBucket
FROM SALES.Orders


/*
Segment all orders into 3 categories:
high, medium and low sales
*/
SELECT
*,
CASE
WHEN Buckets = 1 THEN 'High'
WHEN Buckets = 2 THEN 'Medium'
WHEN Buckets = 3 THEN 'Low'
END SalesSegmentation
FROM(
	SELECT
	OrderID,
	Sales,
	NTILE(3) OVER(ORDER BY Sales DESC) Buckets
	FROM Sales.Orders
)t


-- In order to export the data, divide the orders into 2 groups
SELECT
NTILE(2) OVER(ORDER BY OrderID) Buckets,
*
FROM Sales.Orders

-- CUME_DIST()
-- Find the products that fall within the highest 40% of prices
SELECT
*,
CONCAT(SalesRank * 100, '%') Percentage
FROM(
	SELECT
	Product,
	Price,
	ROUND(PERCENT_RANK() OVER(ORDER BY Price DESC),2) SalesRank
	FROM Sales.Products
)t WHERE SalesRank <= 0.4


SELECT
*,
CONCAT(SalesRank * 100, '%') Percentage
FROM(
	SELECT
	Product,
	Price,
	ROUND(CUME_DIST() OVER(ORDER BY Price DESC),2) SalesRank
	FROM Sales.Products
)t WHERE SalesRank <= 0.4


-- LEAD & LAG
/*
Analyze the month-over-month performance by finding the percentage change
in sales between the current and previous months
*/
SELECT
*,
CurrentMonthSales - PreviousMonthSales Month_over_month_sales,
ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT)/PreviousMonthSales * 100,2) Percent_change
FROM(
	SELECT
	MONTH(OrderDate) OrderMonths,
	SUM(Sales) CurrentMonthSales,
	LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PreviousMonthSales
	FROM Sales.Orders
	GROUP BY MONTH(OrderDate)
)t

/*
In order to analyze customer loyalty, rank customers
based on the average days between their orders
*/
SELECT
CustomerID,
AVG(DaysUntilNextOrder) AvgDays,
RANK() OVER(ORDER BY COALESCE(AVG(DaysUntilNextOrder), 9999999)) daysRank
FROM(
	SELECT 
	OrderID,
	CustomerID,
	OrderDate CurrentOrderDate,
	LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) NextOrderDate,
	DATEDIFF(DAY, OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) DaysUntilNextOrder
	FROM Sales.Orders
)t
GROUP BY CustomerID


-- FIRST_VALUE() & LAST_VALUE()
/*
Find the lowest and highest sales for each product
*/
SELECT
OrderID,
ProductID,
OrderDate,
Sales,
FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) LowestSale,
LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales 
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSale,
FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC) HighestSale2,
MIN(Sales) OVER(PARTITION BY ProductID ) LowestSale2
FROM Sales.Orders



