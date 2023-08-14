--Creating the tables--
Create Table employees (
emp_no INTEGER Primary Key  NOT NULL,
emp_title VARCHAR(255) NOT NULL,
birth_day Date NOT NULL,
first_name VARCHAR (255) NOT NULL,
last_name VARCHAR (255) NOT NULL,
sex VARCHAR (255) NOT NULL,
hire_date Date  NOT NULL);
--
Create Table departments(
dept_no VARCHAR  (255)  Primary Key NOT NULL,
dept_name VARCHAR (255) NOT NULL);
--
Create Table department_emp (
emp_no INTEGER NOT NULL,
dept_no	VARCHAR (255) NOT NULL);
--
Create Table department_mana(
dept_no VARCHAR (255) NOT NULL,
emp_no INTEGER Primary Key   NOT NULL);
--
Create Table Salaries (
emp_no Integer Primary Key  Not Null,
salary Integer Not Null,
FOREIGN KEY (emp_no) REFERENCES employees(emp_no));
--
Create Table Titles (
title_id  VARCHAR (255) Primary Key  NOT NULL,
title	VARCHAR (255) NOT NULL);
--
-- Inserting the data --- Viewing the data 
select * from employees
select * from departments
select * from department_emp
select * from department_mana
select * from Salaries
select * from Titles
--- Data Analysis 1 --
CREATE VIEW salary_emp As
Select S.salary,
e.last_name,
e.first_name,
e.sex
From Salaries as S
inner join employees as e On
e.emp_no = S.emp_no
Select * from salary_emp
-- Data Analysis 2-- 
--https://stackoverflow.com/questions/9891025/sql-select-from-column-where-year-2010 helped me 
Select employees.last_name, 
employees.first_name,
employees.hire_date
From employees
where hire_date >= '1/1/1986'  And hire_date < '1/1/1987'
-- Data Analysis 3 -- Doing two inner joins 
CREATE VIEW managers_name As
Select departments.dept_no,
departments.dept_name,
department_mana.emp_no
From department_mana
inner join departments on 
department_mana.dept_no = departments.dept_no
--select * from managers_name-- As a test
--- Doing another join 
Select managers_name.dept_no,
managers_name.dept_name,
managers_name.emp_no,
employees.first_name,
employees.last_name
From managers_name
inner join employees on 
employees.emp_no = managers_name.emp_no
--Data Analysis 4-- Same idea has 3 but with employees 
CREATE VIEW employee_name As
Select departments.dept_no,
departments.dept_name,
department_emp.emp_no
From department_emp
inner join departments on 
department_emp.dept_no = departments.dept_no
--select * from employee_name-- As a test
--
Select employee_name.dept_no,
employee_name.dept_name,
employee_name.emp_no,
employees.first_name,
employees.last_name
From employee_name
inner join employees on 
employees.emp_no = employee_name.emp_no
--Data Analysis 5-- 
select * 
from employees
where first_name = 'Hercules' and last_name like 'B%';
--Data Analysis 6-- 
CREATE VIEW employee_sales As
select*
from department_emp 
where dept_no = 'd007'-- from the titles csv
select * from  employee_sales
-- join with the employees names 
select employees.last_name, 
employees.first_name,
employee_sales.dept_no,
From employee_sales
inner join employees on 
employees.emp_no = employee_sales.emp_no
--Data Analysis 7--
create view sales_dev As
select *
from department_emp 
where dept_no ='d005' or  
dept_no ='d007'
--select * from sales_dev -- As a test
-- getting joining the departments 
create view title_dept As
select departments.dept_name,
sales_dev.emp_no
from sales_dev
inner join departments on
sales_dev.dept_no=departments.dept_no
--select * from title_dept-- As a test
-- joining the dept_name and employee id with the names 
select employees.last_name, 
employees.first_name,
title_dept.dept_name,
title_dept.emp_no
from title_dept
inner join employees on
title_dept.emp_no=employees.emp_no
--Data Analysis 8 --
-- https://www.w3resource.com/sql/aggregate-functions/count-with-distinct.php got the idea from here --
Select last_name ,count  (last_name)  as "Last_names"
from employees
group by last_name
ORDER BY "Last_names";
