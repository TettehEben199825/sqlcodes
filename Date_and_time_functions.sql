SELECT
OrderID,
OrderDate,
ShipDate,
CreationTime,
'1998-07-25' AS HardCoded,
GETDATE() AS Today,
YEAR(CreationTime) AS Year,
MONTH(CreationTime) AS Month,
DAY(CreationTime) AS Day
FROM Sales.Orders

-- DATEPART
SELECT
OrderID,
CreationTime,
DATEPART(YEAR, CreationTime) AS Year_dp,
DATEPART(MONTH, CreationTime) AS Month_dp,
DATEPART(DAY, CreationTime) AS Day_dp,
DATEPART(HOUR, CreationTime) AS Hour_dp,
DATEPART(QUARTER, CreationTime) AS Quarter_dp,
DATEPART(WEEK, CreationTime) AS Week_dp
FROM Sales.Orders

--DATENAME
SELECT
OrderID,
CreationTime,
DATENAME(MONTH, CreationTime) AS Months,
DATENAME(WEEKDAY, CreationTime) AS DAY,
DATENAME(WEEK, CreationTime) AS DAY_dn,
DATENAME(YEAR, CreationTime) AS Year_dn
FROM
Sales.Orders

-- DATETRUNC
SELECT
OrderID,
CreationTime,
DATETRUNC(MINUTE, CreationTime) AS MIN_TRUNC,
DATETRUNC(DAY, CreationTime) AS DAY_TRUNC,
DATETRUNC(YEAR, CreationTime) AS YEAR_TRUNC
FROM Sales.Orders

SELECT
DATETRUNC(MONTH, CreationTime) Creation,
COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH, CreationTime)


-- End of the month
SELECT 
OrderDate,
CreationTime,
EOMONTH(CreationTime) EndOfMonth,
CAST(DATETRUNC(month, CreationTime) AS DATE) AS StartOfMonth
FROM Sales.Orders

-- How many orders were placed each year?
SELECT 
YEAR(OrderDate) AS OrdersDate,
COUNT(*) AS NumberOfOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate)

-- How many orders were placed each month?
SELECT 
DATENAME(MONTH, OrderDate) AS OrderMonth,
COUNT(*) AS NumOfOrders
FROM Sales.Orders
GROUP BY DATENAME(MONTH, OrderDate), MONTH(OrderDate)

-- Show all orders that were placed during the month of February

SELECT 
DATENAME(MONTH, OrderDate) AS Feb_Order,
COUNT(*) AS NumOfOrders
FROM 
Sales.Orders
WHERE DATEPART(MONTH, OrderDate) = 2
GROUP BY DATENAME(MONTH, OrderDate)