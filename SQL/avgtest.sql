CREATE table thecheated as 
SELECT * FROM staff 
WHERE Salary < (SELECT avg(Salary) FROM staff);
create table avgsalary as SELECT avg(Salary) FROM staff;

create table newmerge as
SELECT * FROM thecheated as tc
LEFT JOIN avgsalary as av using(id);


create table finalone as
SELECT *, IFNULL(`avg(Salary)`, 2445333.3333) as AvgS FROM newmerge;

SELECT * FROM staff WHERE Age = 22
UNION
SELECT * FROM staff WHERE Age = 23;