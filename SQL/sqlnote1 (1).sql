SELECT * FROM ANOTHER.`real_estate_sales_2001-2020_gl`;

USE ANOTHER;
create table staff(id int primary key auto_increment, Name char (50), Age int(2), Department char (20), Gender Char (6), Date_Joined DATE, Salary int);
describe staff;
INSERT INTO staff(Name, Age, Department, Gender, Date_Joined, Salary) values('Olayele Gbenga', 22, 'Data Science', 'Male', 20220701, 1000000);
INSERT INTO staff(Name, Age, Department, Gender, Date_Joined, Salary) values('Ireola Seyi', 23, 'Data Analysis', 'Female', 20230810, 7000000),
('IAdigun Bunmi', 33, 'Data Analysis', 'Female', 20210810, 900000),
('INath Ayilara', 20, 'Data Science', 'Male', 20240130, 800000),
('Kukoyi Adio', 36, 'Web Design', 'Male', 20240501, 90000),
('Fadeyi Bunmi', 24, 'Graphics', 'Female', 20230810, 7000000), ('Olayele Gbenga', 22, 'Data Science', 'Male', 20220701, 1000000), ('Olayele Gbenga', 22, 'Data Science', 'Male', 20220701, 1000000);

INSERT INTO staff(Name, Age, Department, Gender, Date_Joined, Salary) values('Adio Kolade', 22, 'Graphics', 'Male', 20230810, 7000000),
('Bolodeoku Ibrahim', 38, 'Data Analysis', 'Female', 20210810, 1000000),
('Nath Kokumo', 20, 'UI/UX', 'Male', 20240130, 800000),
('Bolade Ibrahim', 22, 'Cyber Security', 'Male', 20240505, 90000),
('FLere Paimo', 37, 'Data Science', 'Male', 20240810, 7000000), ('OKolade Bunmi', 22, 'Data Science', 'Male', 20220701, 1000000), ('Ay Victoria', 22, 'Data Science', 'Male', 20220701, 1000000);
Select * from staff;
describe Real_Estate;

Select * from Real_Estate order by Sale_Amount;
SELECT * FROM Real_Estate order by Sale_Amount desc;
-- operations that we can perform in SQL
SELECT (10+20) as addition;
SELECT (10+20);
-- String functions in SQL
SELECT length('Ola') AS Name_length;
SELECT CHAR_LENGTH('  OLA  ');

SELECT repeat('Hello ', 10) as repeated;
SELECT UPPER('ire');
SELECT * FROM staff;
SELECT LOWER('IRE');
SELECT LCASE('IRE');
SELECT UCASE('ire');
#Applying this to our dataset
Select *, CHAR_LENGTH(Department) as Department_Length from staff;
SELECT Town, CHARACTER_LENGTH(Town)  as Lengths FROM Real_Estate;
SELECT Town, CHAR_LENGTH(Town)  as Lengths FROM Real_Estate;
SELECT Town, CHARACTER_LENGTH(Town)  as Lengths FROM Real_Estate GROUP BY Town;

#CONCAT FUNCTION FOR CONCATINATING OF STRINGS
SELECT CONCAT('MY ', 'NAME IS ' 'IREOLA');
#APPLYING THIS TO OUR DATASET
SELECT * , CONCAT(Name, ' ', Department) as Full_address FROM staff;

#REVERSE FUNCTION IN SQL
SELECT REVERSE('IREOLA');
#APPLYING THIS TO OUR DATASET

SELECT *, REVERSE(Department) as Reversed FROM staff;
SELECT *, REPLACE(Department, "Web Design", "Website Development") from staff;
#REPLACE FUNCTION
SELECT REPLACE('My name is OlaOluwa', 'OlaOluwa', 'Ireola') as replaced; #Here, we are trying to replace the word OlaOluwa with Ireola

#LTRIM AND RTRIM FUNCTION IN SQL
SELECT char_length('     Ireola     ');
SELECT char_length(LTRIM('     Ireola     '));
SELECT char_length(RTRIM('     Ireola     '));
SELECT char_length(TRIM('     Ireola     '));

#POSITION FUNCTION
SELECT POSITION("NAME" in "My name is Ireola"); #This will return null if the word that you are looking for is not in the string
#Further, this is not case sensitive

#ASCII FUNCTION
SELECT ASCII(-20);
SELECT ASCII(650);
SELECT ASCII('apple');
SELECT ASCII('APPLE');
SELECT ASCII('B');
SELECT ASCII('b');


-- WORKING WITH DATE IN SQL
SELECT CURDATE(); -- this code is to find the current date
-- conversion of date
SELECT DAY(CURDATE());
SELECT MONTH(CURDATE());
SELECT YEAR(CURDATE());
SELECT WEEK(CURDATE());
-- GETTING CURRENT DATE AND TIME
SELECT NOW();
-- RETURNING DISTINCT INFORMATION
SELECT DISTINCT Department FROM Staff;
-- COUNT FUNCTION IN SQL;
SELECT Department, COUNT(Department) as Male_Department FROM staff where Department ='Data Analysis' and Gender = 'Female';
-- PERFORMING AGGREGATION IN SQL
SELECT AVG(Salary) as Average_Salary from staff;
SELECT Town. AVG(Sale_Amount) as Average_Sales from Real_Estate group by Town;
-- OPERATORS IN SQL
SELECT * FROM Real_Estate where Town = 'Trumbull'and Property_Type='Vacant Land' or Town ='Bethany' and Property_Type= 'Vacant Land';
SELECT * FROM Real_Estate where Town = 'Trumbull' or Town ='Bethany';
SELECT * FROM Real_Estate where Town in ('Trumbull', 'Bethany');
SELECT * FROM Real_Estate where Sale_Amount BETWEEN 420000 and 905000;

#GROUPBY AND HAVING
-- The Group by helps in grouping of our data in a summary rows and return one record for each group
#After grouping, it performs aggregrate function on each group
-- THE SYNTAX IS
-- SELECT COLUMN NAME(S) 
-- FROM TABLE_NAME 
-- WHERE CONDITION
-- GROUP BY COLUMN NAME
-- ORDER BY COLUMN NAME;
select Town, sum(Sale_Amount) as Total_Sales from Real_Estate group by Town;
