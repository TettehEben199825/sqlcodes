-- SQL String funtions

-- Show a list of customer's first name together with their last name in one column

SELECT first_name,
Country,
CONCAT(first_name,' ', Country) AS Name_and_country
FROM Customers

-- Convert the first name to lowercase
SELECT first_name,
LOWER(first_name) AS Name_lower
FROM customers

-- Find customers whose first name contains leading or trailing spaces
SELECT first_name
FROM customers
WHERE first_name != TRIM(first_name)

-- Remove dashes (-) from a phone number
SELECT 
'123-456-7890' AS Phone,
REPLACE('123-456-7890', '-', '') AS Cleaned_Phone

-- Replace file extension from txt to csv

SELECT
'Report.txt' AS Report,
REPLACE('Report.txt','.txt', '.csv') AS Cleaned_Report

--Calculate the length of each Cutomer's firstName

SELECT first_name,
LEN(first_name) Name_length
FROM customers

-- Retrieve the first two characters of each firstName

SELECT first_name,
LEFT(TRIM(first_name), 2) AS firstTwo
FROM customers

-- Retrieve the last two characters of each firstName

SELECT first_name,
RIGHT(TRIM(first_name), 2) AS lastTwo
FROM customers

-- Retrieve a list of Customer's first name after removing the first character

SELECT first_name,
SUBSTRING(TRIM(first_name), 2, LEN(first_name)) AS Sub_name
FROM customers