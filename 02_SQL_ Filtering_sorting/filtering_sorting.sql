use srishtidb; 

# create table 'Employees'
create table employees(
EmpID int primary key,
EmpName char(50),
Department char(50),
City char(50),
Salaty int,
HireDate date
);

drop table employees;
 
 create table employees(
EmpID int primary key,
EmpName char(50),
Department char(50),
City char(50),
Salaty int,
HireDate date
);
drop table employees;

# create table 'Employees'
create table employees(
EmpID int primary key,
EmpName char(50),
Department char(50),
City char(50),
Salary int,
HireDate date
);
  insert into Employees( EmpID, EmpName, Department, City, Salary, HireDate) values
  (101, "Rahul Mehta", "Sales", "Delhi", 55000, "2024-04-12"),
  (102, "Priya Sharma", "HR", "Mumbai", 62000, "2019-09-25"),
  (103, "Aman Singh", "IT", "Bengaluru", 72000, "2021-03-10"),
  (104, "Neha Patel", "Sales", "Delhi", 48000, "2022-03-14"),
  (105, "Karan Joshi", "Marketing", "Pune", 45000, "2018-07-22"),
  (106, "Divya Nair", "IT", "Chennai", 81000, "2029-12-11"),
  (107, "Raj Kumar", "HR", "Delhi", 60000, "2020-05-28"),
  (108, "Simran Kaur", "Finance", "Mumbai", 58000, "2021-08-03"),
  (109, "Arjun Reddy", "IT", "Hyderabad", 70000, "2022-02-18"),
  (110, "Anjali Das", "Sales", "Kolkata", 51000, "2023-01-15"); 
  
  Select * from employees;  
  
  # show employees working either in 'IT' or 'HR' department
  select * from employees
  where department = "it" or department = "HR";
  
# employees whose department is in sales, IT or Finance
select * from employees
where department in ("Sales", "IT", "Finance"); 

# employees whose salary is between 50000 and 70000
select * from employees
where salary between 50000 and 70000; 

#list employees whose name starts with letter 'A'
select * from employees
where EmpName like "A%"; 

# find employees whose name contains the substring "an"
select * from employees
where EmpName like "%an%";  

# show employees who are from Delhi, Mumbai and earn more than 55000
select * from employees
where City in ("Delhi", "Mumbai")
and salary > 55000; 


# select from employees who are not from hr department
select* from employees
where Department != "HR"; 

# all employees hired between 2019 and 2022, order by hire date (oldest first)
select* from employees
where HireDate between "2019-01-01" and "2022-01-31"
order by HireDate asc;