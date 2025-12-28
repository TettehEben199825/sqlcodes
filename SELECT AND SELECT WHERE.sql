USE united_nations;
SELECT *
FROM access_to_basic_services
LIMIT 10;

SELECT DISTINCT
Country_name
FROM
access_to_basic_services;


CREATE TABLE 
Country_list(
Country_name VARCHAR(100)
);

INSERT INTO Country_list
SELECT DISTINCT
Country_name
FROM
access_to_basic_services;

SELECT *
FROM Country_list
LIMIT 10;

SELECT Country_name,
Time_period,
Pct_managed_drinking_water_services AS pct_access_water
 FROM
 access_to_basic_services
 WHERE 
 Time_period = 2020
 ORDER BY Pct_managed_drinking_water_services ASC;