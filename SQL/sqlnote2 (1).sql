USE ANOTHER;
CREATE DATABASE IMPORTING;
#GROUPBY AND HAVING
-- The Group by helps in grouping of our data in a summary rows and return one record for each group
#After grouping, it performs aggregrate function on each group
-- THE SYNTAX IS
-- SELECT COLUMN NAME(S) 
-- FROM TABLE_NAME 
-- WHERE CONDITION
-- GROUP BY COLUMN NAME
-- ORDER BY COLUMN NAME;
#select Town, sum(Sale_Amount) as Total_Sales from Real_Estate group by Town;

CREATE TABLE Sales(product_id int, name char (20), selling_price float, quantity int, state char (20));
INSERT INTO Sales(product_id, name, selling_price, quantity, state)
values(150, 'Coke', 5.8, 10, 'Colorado'),(150, 'Coke', 5.8, 40, 'Texas'),
(151, 'Fanta', 15.6, 40, 'Texas'), (151, 'Fanta', 15.6, 60, 'Colorado'),
(150, 'Coke', 5.8, 70, 'Austin'), (151, 'Fanta', 15.6, 10, 'Austin'),
(150, 'Coke', 5.8, 80, 'New York'), (151, 'Fanta', 15.6, 200, 'New York'),
(150, 'Coke', 5.8, 300, 'Ohio'), (151, 'Fanta', 15.6, 100, 'Ohio');
DROP TABLE SALES;

SELECT * FROM Sales;

SELECT product_id, sum(selling_price * quantity) as Total_Sales from Sales
group by product_id;

#ROUND FUNCTION

SELECT state, ROUND(SUM(selling_price*quantity), 2) as Total_Sales from Sales
group by state;

# LETS LOOK AT PERFORMING OPERATION ON TWO TABLE
CREATE TABLE cost(product_id int, cost_price float);
INSERT INTO cost(product_id, cost_price) values(150, 3.2), (151, 12.3);
SELECT * FROM cost;

SELECT s.product_id, SUM((s.selling_price - c.cost_price) * s.quantity) as profit
from Sales as s inner join cost as c where s.product_id =c.product_id  group by s.product_id;

SELECT c.product_id, ROUND(SUM((s.selling_price - c.cost_price) * s.quantity), 5) as profit
from Sales as s inner join cost as c where s.product_id =c.product_id  group by c.product_id;

# HAVING CLAUSE IN SQL
#The having clause operates on group records and returns rows 
#where aggregate function result matches with given condition only
-- SYNTAX
-- SELECT COLUMN NAME(S) FROM TABLE 
-- WHERE CONDITION 
-- GROUP BY COLUMN NAME 
-- HAVING CONDITION 
-- ORDER BY COLUMN NAME

#HAVING AND WHERE CLAUSE ARE KIND OF  SIMILAR, ONLY THAT HAVING WORKS WITH AGGREGATE FUNCTION
DROP TABLE emp_details;
CREATE TABLE emp_details (Name VARCHAR(25), Age int,
sex CHAR(1), DOJ DATE, City varchar(15),Department char (30), salary float);
select * from emp_details;
insert into emp_details
values("Jimmy", 35, "M", "2005-05-30", "Chicago", 'Marketing', 70000),
("Shane", 30, "M", "1999-06-25", "Seattle",'Sales', 55000),
("Marry", 28, "F", "2009-03-10", "Boston",'HR', 62000),
("Dwayne", 37, "M", "2011-07-12", "Austin",'IT', 57000),
("Sara", 32, "F", "2017-10-27", "New York",'Sales', 72000),
("Ammy", 35, "F", "2014-12-20", "Seattle",'Production', 80000),
("Harry", 35, "M", "2005-05-30", "Chicago", 'IT', 70000),
("Williams", 30, "M", "1999-06-25", "Seattle",'Production', 55000),
("Ruth", 28, "F", "2009-03-10", "Boston",'HR', 62000),
("Kirk", 37, "M", "2011-07-12", "Austin",'IT', 57000),
("Shanda", 32, "F", "2017-10-27", "New York",'IT', 72000),
("Tammy", 35, "F", "2014-12-20", "Seattle",'HR', 80000);

insert into emp_details
values("Clara", 38, "F", "2004-05-30", "Illinois", 'PR', 60000),
("Thomas", 30, "M", "1999-06-25", "Seattle",'PR', 55000),
("Jude", 28, "M", "2009-03-10", "Boston",'IT', 80000),
("Kyle", 37, "M", "2010-07-12", "Austin",'IT', 90000),
("Matthew", 32, "M", "2017-10-27", "New York",'Sales', 72000),
("TOmmy", 35, "M", "2014-12-20", "Seattle",'Production', 80000),
("Hilary", 35, "F", "2005-05-30", "Chicago", 'IT', 70000),
("Cosmos", 30, "M", "1999-06-25", "Seattle",'Production', 55000),
("Faith", 28, "F", "2009-03-10", "Boston",'HR', 62000),
("Linus", 37, "M", "2011-07-12", "Austin",'IT', 57000),
("Philips", 32, "F", "2017-10-27", "New York",'IT', 72000),
("Glory", 35, "F", "2014-12-20", "Seattle",'HR', 80000);

select * from emp_details;
#FIND THE Department which average salary is greater than 69000 using HAVING CLAUSE
SELECT Department, Round(avg(salary)) as average_salary
from emp_details 
group by Department
HAVING avg(salary) > 60000;

#FIND THE CITY which TOTAL salary is greater than 300000 using HAVING CLAUSE

SELECT City, SUM(salary) as Total_Salary
from emp_details
group by City
HAVING sum(salary)<300000;

#FIND DEPARTMENT WHOSE EMPLOYEES ARE GREATER THAN 3
SELECT Department, COUNT(*) AS Emp_count
FROM emp_details
GROUP BY Department
HAVING COUNT(*) > 3;

#USING WHERE CLAUSE WITH HAVING CLAUSE
#COUNT ALL EMPLOYEES IN THE CITIES EXCEPT SEATTLE

SELECT City, COUNT(*) AS Emp_count
FROM emp_details
WHERE City != 'Seattle'
GROUP BY City
HAVING COUNT(*) >3;

#COUNT the employees in Department that the average salary is greater than 68000

SELECT Department, COUNT(*) AS Emp_count
FROM emp_details
GROUP BY Department
HAVING AVG(salary) > 69500;


