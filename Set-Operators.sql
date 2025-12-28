-- SQL SET OPERATORS

/*
RULES OF SET OPERATORS
1. ORDER BY can be used only once
2. Same Number of Columns
3. Matching Data Types
4. Same Order of Columns
5. First Query Control Aliases
6. Mapping Correct Columns
*/


-- Combine the data from employees and customers into one table (UNION)
SELECT FirstName,
LastName
FROM Sales.Customers

UNION

SELECT FirstName,
LastName
FROM Sales.Employees


-- Combine the data from employees and customers into one table (UNION ALL)

SELECT FirstName,
LastName
FROM Sales.Customers

UNION ALL

SELECT FirstName,
LastName
FROM Sales.Employees

-- SQL EXCEPT

-- Find the employees who are not Customers at the same time

SELECT FirstName,
LastName
FROM Sales.Employees

EXCEPT

SELECT FirstName,
LastName
FROM Sales.Customers

-- SQL INTERSECT
-- Find the Employees who are also Customers

SELECT FirstName,
LastName
FROM Sales.Employees

INTERSECT

SELECT FirstName,
LastName
FROM Sales.Customers

-- UNION USE CASES
/*
Orders data are stored in separate tables( Orders and Orders archive).
Combine all orders into one report without duplicates
*/

SELECT 
'Order' AS SourceTable,
       [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders

UNION

SELECT 
'OrderArchive' AS SourceTable,
       [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID