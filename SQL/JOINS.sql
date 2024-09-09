#JOINS
#JOINS ARE USED TO MERGE TWO OR MORE TABLES TOGETHER USING A MATCHING COLUMN

#INNER JOIN
-- Take for instance, you have to offer both Python or Web Level 1 
-- while some can offer both at the same time
-- Let's create table for Python and another table for Web

USE sqlpractice;
CREATE TABLE Python(id int primary key auto_increment, student_name char (20));
INSERT INTO Python(student_name) VALUES ('Ire'),('Seun'),('Gbenga'),('Kolade'),('Victoria'),('Ezekiel'),('Ay'),('Fouad'),('Faith'),('Carter');
SELECT * FROM Python;
CREATE TABLE Web(id int primary key auto_increment, student_name char (20));
INSERT INTO Web(student_name) VALUES ('Funmi'),('Seun'),('Gbenga'),('Abike'),('Sola'),('Ezekiel'),('Ay'),('Tola'),('Ife'),('Carter');

-- PERFORMING INNER JOIN ON THESE TABLES
SELECT p.id, p.student_name FROM python as p
JOIN web as w ON p.student_name = w.student_name;

SELECT * FROM Python as p INNER JOIN Web as w ON p.student_name = w.student_name;

SELECT p.student_name FROM Python as p INNER JOIN Web as w ON p.student_name =w.student_name;
SELECT  p.id, w.student_name FROM Python as p INNER JOIN Web as w on p.student_name = w.student_name;
show databases;
#ANOTHER WAY OF INNER JOIN
SELECT  student_name FROM Python inner join Web using (student_name);

-- SELECT c.name, i.number, c.client_id FROM invoices as i
-- JOIN clients as c using(client_id)
-- SELECT o.ordernumber, o.status, p.product_name, sum(quantity * price) as revenue 
-- from orders as o inner join orders_details as od on o.ordernumber=od.ordernumber inner join
-- products as p on p.product_id =od.product_id group by ordernumber;

#LEFT JOIN RETURNS ALL THE ROWS FROM THE LEFT TABLE AND THE MATCHING ROWS FROM THE RIGHT TABLE
# SYNTAX
-- SELECT <FIELD LIST> FROM TABLE A
--  LEFT JOIN TABLE B ON A.KEY =B.KEY

-- select p.student_name, w.student_name from Python as p
-- left join Web as w on p.student_name=w.student_name;

#This data will join my right table to my left table, showing null for where they don't match, to see the ones that are null

select p.student_name, w.student_name from Python as p
left join Web as w on p.student_name=w.student_name where w.student_name is null;

#RIGHT JOINS RETURNS ALL THE ROWS FROM THE RIGHT TABLE AND ONLY RETURNS THE MATCHING ROWS ON THE LEFT
SELECT w.student_name, p.student_name name from Web as w right join Python as p on w.student_name =p.student_name;

SELECT w.student_name, p.student_name name from Web as w 
right join Python as p on w.student_name =p.student_name where w.student_name is null;

SELECT w.student_name, p.student_name name from Web as w 
right join Python as p on w.student_name =p.student_name where w.student_name is not null;

#RIGHT JOIN RETURNS ALL THE ROWS FROM THE LEFT TABLE AND THE MATCHING ROWS FROM THE RIGHT TABLE
# SYNTAX
-- SELECT <FIELD LIST> FROM TABLE A
--  RIGHT JOIN TABLE B ON A.KEY =B.KEY

#FULL OUTER JOIN
-- THIS RETURNS ALL THE ROWS WHERE THERE IS A MATCH, EITHER LEFT OR RIGHT TABLE
SELECT p.id, p.student_name from Python as p left join Web as w on
p.student_name = w.student_name 
union
SELECT w.id, w.student_name from Web as w left join Python as p on
w.student_name = p.student_name;

USE pizza;
SELECT * FROM customer_orders as co left join pizza_names as pn 
on co.pizza_id =pn.pizza_id;
SELECT c.order_id, c.customer_id, c.pizza_id, pn.pizza_name from
customer_orders as c left join pizza_names as pn on
c.pizza_id=pn.pizza_id;
SELECT c.order_id, c.customer_id, pn.pizza_name from
customer_orders as c right join pizza_names as pn on
c.pizza_id=pn.pizza_id;

SELECT pn.pizza_id, pn.pizza_name, pr.toppings from pizza_names as pn
left join pizza_recipe as pr on pn.pizza_id = pr.pizza_id;

-- SUBQUERRIES IN SQL
-- WHAT ARE SUBQUERRIES?
-- Subquerries jus as the name implies, having querry(ies) inside another querry.
-- This literally means that you are having another command inside your commmand, that is before this operation is done, do another operation 
-- inside it.
select * from customer_data;
-- WHEN DO YOU NEED SUBQUERRIES?
-- You need subquerry when you want to perform an operation that will lead to another operation.
-- Does this makes sense? Yes, it does. Consider a situation when you want to find all students in a school
-- whose score is less than a certain value and you want to put them in another table as failed student
-- You can write a subquerry for this case.

-- THERE ARE FOUR COMMANDS USE IN SUBQUERRY
-- INSERT 
-- UPDATE
-- DELETE
-- SELECT

-- THE SYNTAX
-- SELECT avg(Salary) FROM staff;
  SELECT * FROM staff 
WHERE Salary < (SELECT avg(Salary) FROM staff);
create table avgsalary as SELECT avg(Salary) FROM staff;
-- There are two querries in SQL, we have the outer querry and the inner querry.  
-- In writing an SQL statement, the inner querry get executed before the outer querry
USE ANOTHER;
SELECT AVG(Salary) as Avg_Sal FROM staff;
SELECT name, Department FROM staff WHERE
Salary < (SELECT AVG(Salary) FROM staff);
SELECT * FROM staff where Salary < (SELECT AVG(Salary) from staff);

SELECT * FROM staff WHERE Salary = (SELECT MAX(Salary) from staff);

SELECT COUNT(Name) as total_count  FROM staff WHERE Salary = (SELECT MAX(Salary) from staff);

#INSERT STATEMENT


-- The INSERT STATEMENT uses the data returned from syntax to insert into another table

-- SYNTAX
-- INSERT INTO TableB
-- SELECT * FROM TableA WHERE VALUE OPERATOR(INNER QUERRY)

-- Let's assume that we have an exam records, we want to pick all students' whose score are less than certain value, and put their info in failed table
-- You must first create the table
-- CREATE TABLE Failed (id int primary key auto_increment, name varchar (100), adm_no varchar (20), total int);

INSERT INTO Failed (SELECT id, name,adm_no, total FROM Exams
WHERE total <(SELECT AVG(total) from Exams));

-- create table failed2 AS
-- SELECT name, total FROM Exams
-- WHERE total <(SELECT AVG(total) from Exams);

SELECT AVG(total) from Exams;
CREATE TABLE Passed(id int primary key auto_increment, name varchar (60), adm_no varchar (20), first_ca int, second_ca int, third_ca int,
exams int, total int);
SELECT * FROM Passed;
INSERT INTO Passed (SELECT * FROM Exams WHERE total >=
(SELECT AVG(total) FROM Exams));


USE ANOTHER;

#UPDATE STATEMENT
#The update statement can be used in conjuction with subquerry to update either single or multiple column 
#SYNTAX
# UPDATE TABLE SET COLUMN_NAME =NEW_VALUE WHERE OPERATOR VALUE
#(SELECT COLUMN_NAME FROM TABLE NAME) WHERE

#LET'S HAVE A SCENARIO HERE, WE HAVE A COMPANY AND WE WANT TO GIVE STAFFS WHO HAVE STAYED MORE THAN 5 YEARS IN OUR COMPANY INCREASE IN SALARY
SELECT *, MONTH(Registration_Date) as Registration_Month, DAY(Registration_Date) as Registration_Day,
YEAR(Registration_Date) as Registration_Year
from working;
UPDATE cleaned SET Balance = Balance *1.3 where id =1;
SELECT *, YEAR(Registration_Date) as Registration_Year from working;
select * from cleaned;
SET SQL_SAFE_UPDATES = 0;
UPDATE cleaned SET Balance = Balance * 1.3 where Registration_Year <
(SELECT YEAR(Registration_Date) FROM customer_data where YEAR(Registration_Date)=YEAR(CURDATE()-5));
SET SQL_SAFE_UPDATES = 1;
UPDATE cleaned SET Balance = Balance * 1.3  where Registration_Year < YEAR(CURDATE())-5;
select * from cleaned;
SELECT YEAR(CURDATE())-5;
#DELETE STATEMENT
#The delete statement can also be used with Subquerry

#SYNTAX
#DELETE FROM TABLE_NAME WHERE OPERATOR VALUE (INNER_QUERRY)

DELETE FROM customer_data WHERE Year_col in (SELECT Year_Col FROM customer_data where Year_Col < 2013);