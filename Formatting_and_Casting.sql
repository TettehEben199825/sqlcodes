SELECT 
OrderID,
CreationTime,
FORMAT(CreationTime, 'MM-dd-yyyy') USA_Format,
FORMAT(CreationTime, 'dd-MM-yyyy') EURO_Format,
FORMAT(CreationTime, 'dd') dd,
FORMAT(CreationTime, 'ddd') ddd,
FORMAT(CreationTime, 'dddd') dddd,
FORMAT(CreationTime, 'MM') MM,
FORMAT(CreationTime, 'MMM') MMM,
FORMAT(CreationTime, 'MMMM') MMMM
FROM Sales.Orders

-- Show CreationTime using the following 
-- Day Wed Jan Q1 2025 12:34:56 PM
SELECT
OrderID,
CreationTime,
'Day '+ FORMAT(CreationTime, 'ddd MMM') +
' Q' + DATENAME(QUARTER, CreationTime) + ' ' + FORMAT(CreationTime, 'yyyy hh:mm:ss tt') CustomFormat
FROM
Sales.Orders

SELECT
FORMAT(OrderDate, 'MMM yy') OrderDate,
COUNT(*) NumOfOrders
FROM Sales.Orders
GROUP BY FORMAT(OrderDate, 'MMM yy'), MONTH(OrderDate)

-- Convert
SELECT
CONVERT(INT, '123') [String To Integer],
CONVERT(DATE, '2025-08-20') [String To Date],
CreationTime,
CONVERT(DATE, CreationTime) [DateTime To Date],
CONVERT(VARCHAR, CreationTime, 32) [USA Standard Format],
CONVERT(VARCHAR, CreationTime, 34) [EURO Standard Format]
FROM Sales.Orders

-- Cast
SELECT
CAST('123' AS INT)[String to Int],
CAST(123 AS VARCHAR) [Int to String],
CAST('2025-08-20' AS DATE) [String to Date],
CAST('2025-08-20' AS DATETIME2) [String to DateTime],
CreationTime,
CAST(CreationTime AS DATE) [DateTime to Date]
FROM Sales.Orders

-- DATEADD
SELECT 
OrderDate,
DATEADD(YEAR, 2, OrderDate) [OrderDate Increased by Two Years],
DATEADD(YEAR, -2, OrderDate) [OrderDate Decreased by Two Years],
DATEADD(MONTH, 2, OrderDate) [OrderDate Increased by Two Months],
DATEADD(DAY, -10, OrderDate) [OrderDate Decreased by Ten Days]
FROM Sales.Orders

-- DATEDIFF
SELECT
OrderID,
OrderDate,
ShipDate,
DATEDIFF(YEAR, OrderDate, ShipDate) [Years Taken],
DATEDIFF(MONTH, OrderDate, ShipDate) [Months Taken],
DATEDIFF(DAY, OrderDate, ShipDate) [Days Taken]
FROM Sales.Orders

-- Calculate the age of employees
SELECT
EmployeeID,
BirthDate,
DATEDIFF(YEAR,BirthDate, GETDATE()) [Age of Employees]
FROM Sales.Employees

-- Find the average shipping duration in days for each month

SELECT
DATENAME(MONTH ,OrderDate) OrderDate,
AVG(DATEDIFF(DAY, OrderDate, ShipDate)) [Average Shipping Duration]
FROM SALES.Orders
GROUP BY DATENAME(MONTH ,OrderDate), MONTH(OrderDate)

-- Time Gap Analysis
-- Find the number of days between each order and the previous order

SELECT
OrderID,
OrderDate CurrentOrderDate,
LAG(OrderDate) OVER (ORDER BY OrderDate) PreviousOrderDate,
DATEDIFF(DAY, LAG(OrderDate) OVER (ORDER BY OrderDate),OrderDate) NumOfDays
FROM SALES.Orders


-- ISDATE
SELECT
ISDATE('123') DateCheck1,
ISDATE('2023-07-23') DateCheck2,
ISDATE('2025') DateCheck3

SELECT
-- CAST(OrderDate AS DATE) OrderDate,
OrderDate,
ISDATE(OrderDate),
CASE WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE)
ELSE '9999-01-01'
END NewOrderDate
FROM
(
	SELECT '2025-08-20' AS OrderDate UNION
	SELECT '2025-08-21' UNION
	SELECT '2025-08-23' UNION
	SELECT '2025-08' 
)t
-- WHERE ISDATE(OrderDate) = 0
