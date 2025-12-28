SELECT * 
FROM customers

SELECT * 
FROM orders

SELECT
c.id,
c.first_name,
o.order_id,
o.sales
FROM customers AS c
INNER JOIN
orders AS o ON c.id = o.customer_id

SELECT * 
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id



SELECT
c.id,
c.first_name,
o.order_id,
o.sales
FROM customers AS c
RIGHT JOIN
orders AS o ON c.id = o.customer_id

SELECT
c.id,
c.first_name,
o.order_id,
o.sales
FROM orders AS O
LEFT JOIN
customers AS c ON o.customer_id = c.id

SELECT
c.id,
c.first_name,
o.order_id,
o.sales
FROM customers AS c
FULL JOIN
orders AS o ON c.id = o.customer_id

-- Left Antijoin
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL

-- RIGHT ANTIJOIN
SELECT *
FROM orders AS o
LEFT JOIN customers AS c
ON c.id = o.customer_id
WHERE c.id IS NULL

-- FULL ANTIJOIN
SELECT *
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL OR
o.customer_id IS NULL

SELECT *
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NOT NULL AND
o.customer_id IS NOT NULL

-- CROSS JOIN
SELECT *
FROM customers
CROSS JOIN orders
