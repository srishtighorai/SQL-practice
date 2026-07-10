# create a database
create database company_db;

# enter the database
use company_db;

# create a table 
create table employees(
employee_id int primary key,
first_name varchar(50),
last_name varchar(50),
department varchar(50),
salary int,
hire_date date
);  

# insert data into employees table

insert into employees (employee_id, first_name, last_name, department, salary, hire_date) values
(101, "Amit", "Sharma", "hr", 50000, "2020-01-15"),
(102, "riya", "Kapoor", "sales", 75000, "2019-03-22"),
(103, "raj", "mehta", "it", 90000, "2018-07-11"),
(104, "neha", "verma", "it", 85000, "2021-09-01"),
(105, "arjun", "singh", "finance", 60000, "2022-02-10"); 

# retrieve  the entire employees table
select * from employees;  

# display all employee records sorted by salary (lowest to highest)

select * from employees order by salary asc;

# employees sorted by department (A-Z) and salary (high-low)

select * from employees order by department asc, salary desc;

#display list of all employees from IT department, order by hire data (newest first)

select * from employees where department = "it"
order by hire_date desc;