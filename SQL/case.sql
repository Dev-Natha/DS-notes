#CASE STATEMENT IN SQL
#Case statement is a statement that performs an operation when specified condition is met
use another;
show tables;
select * from staff;
SELECT * FROM staff order by Age;
-- SELECT *, 
-- CASE
-- WHEN Age BETWEEN 20 AND 22 THEN 'Young'
-- ELSE 'Old'
-- END AS Age_group
-- FROM staff ORDER BY Age DESC;

Select *, 
CASE 
WHEN Department = "Graphics" THEN Salary + (Salary * 0.1)
ELSE Salary + (Salary * 0.01)
END AS Salary_Increase
FROM staff
ORDER BY Age;

Select *, 
CASE 
WHEN Department = "Graphics" THEN ROUND(Salary + (Salary * 0.1), 2)
WHEN Department ="Data Science" THEN ROUND(Salary +(Salary * 0.3), 2)
ELSE ROUND(Salary + (Salary * 0.01), 2)
END AS Salary_Increase
FROM staff
ORDER BY Age DESC;

Select *, 
CASE 
WHEN Department = "Graphics" THEN ROUND(Salary + (Salary * 0.1), 2)
ELSE ROUND(Salary + (Salary * 0.01), 2)
END AS Salary_Increase
FROM staff
ORDER BY Age;

USE ANOTHER;
SELECT *,
CASE
WHEN YEAR(Registration_Date) < 2012 THEN 'Veteran'
WHEN YEAR(Registration_Date) BETWEEN 2012 AND 2017 THEN 'Old'
ELSE 'Newbiees'
END AS Customer_Tpe
FROM working;

#LIKE, REGEX AND WILDCARD
-- A wildcard character is used to substitute one or more characters in a string.
-- Wildcard characters are used with the LIKE operator. The LIKE operator is used in a WHERE 
-- clause to search for a specified pattern in a column.

-- %	Represents zero or more characters
-- _	Represents a single character
-- []	Represents any single character within the brackets *
-- ^	Represents any character not in the brackets *
-- -	Represents any single character within the specified range *
-- {}	Represents any escaped character **

# SYNTAX
-- SELECT COLUMN(S), FROM TABLE_NAME WHERE COLUMN LIKE 'PATTERN'
-- SELECT * FROM staff
-- WHERE Name LIKE '%e'; #This syntax will return anywhere the name ends with 'e'

SELECT * FROM staff
WHERE Name LIKE 'A%'; #Returns anywhere 'A' begins the name

SELECT * FROM staff

WHERE Name LIKE '%a%'; #Returns anywhere 'c' is in the name, irrespective of the position

SELECT * FROM customer_data WHERE
Customer_Name Like 'D__ald%'; #Returns anywhere 'Donald' begin the first name

SELECT * FROM staff
WHERE Name not LIKE 'e%' or Name not LIKE 'c%';#Returns where the name does not begin with ec

SELECT * FROM staff
WHERE Name LIKE '__ch%'; #This will return where the name must only have two characters before ch and have any character after ch

SELECT * FROM customer_data
WHERE Customer_Name LIKE '__c%l'; #Returns anywhere there are 2 characters before, and c and any character in between and ends with l

SELECT * FROM customer_data
WHERE Customer_Name LIKE 'a%' OR Customer_Name LIKE 'c%' OR Customer_Name LIKE 'd%';


SELECT * FROM customer_data
WHERE Customer_Name REGEXP 'a|c|d'; #This returns any string that contains the specified character

SELECT * FROM customer_data
WHERE Customer_Name REGEXP '^(a|c|d)'; #This returns any string that starts with the specified character

SELECT * FROM customer_data WHERE Customer_Name RLIKE '^Ang'; #Select names starting with 'A'

SELECT * FROM customer_data WHERE Customer_Name RLIKE 'son$';#Ends with

SELECT * FROM customer_data WHERE Customer_Name RLIKE 'ma'; #ccontaining 'an'
SELECT * FROM customer_data WHERE Customer_Name RLIKE '^[JK]';#Starting with J or K
SELECT * FROM customer_data WHERE Customer_Name RLIKE '-'; #Returns name with hyphen
SELECT * FROM customer_data WHERE Customer_Name RLIKE '^[a-z]';#Returns all the names
SELECT * FROM customer_data; #This is the same with the previous code
SELECT * FROM customer_data WHERE Customer_Name RLIKE '[^aeiou]{10,}'; #Returns names with at least 10 consonant
SELECT * FROM customer_data WHERE Customer_Name RLIKE '[vz]..'; #Returns names that start with v or z and followed by 2 characters
SELECT * FROM customer_data WHERE Customer_Name RLIKE '^A.*y$'; #Names that starts with A and endswith y






#Let's Extract some column from our data set

SELECT *, substring_index(Customer_Name, ' ', 1) AS First_Name,
substring_index(Customer_Name, ' ', -1) AS Last_Name FROM Customer_data;

create table wahala(name varchar (40));

INSERT INTO wahala(name) Values('Ireola Gbenga Seun');
select * from wahala;
SELECT *, Substring_index(name, ' ', 1) AS First_Name,
 Substring_index(substring_index(name, ' ',-2), ' ',1) AS Middle,
Substring_index(name, ' ', -1) AS last_name from wahala;


SELECT *, SUBSTRING_INDEX(Customer_Name, ' ', 1) AS First_Name, 
SUBSTRING_INDEX(Street, ' ', 1) AS House_number 
FROM customer_data;
