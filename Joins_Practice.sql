-- TASK TO COMPLETE

/*
Using SalesDB, retrieve a list of all orders, along with the related customer,product, and 
employee details. For each order, display:
Order ID, Customer's name, Product name, Sales, Price, Sales Person's name */

SELECT o.OrderID,
o.Sales,
c.FirstName AS CustomerFirstName,
c.LastName CustomerLastName,
p.PRODUCT AS ProductName,
p.Price,
e.FirstName AS EmployeeFirstName,
e.LastName AS EmployeeLastNAme
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e
ON O.SalesPersonID = e.EmployeeID