create database cte_prac;
use cte_prac;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(30),
    Salary INT,
    ManagerID INT
); 

INSERT INTO Employees (EmployeeID, EmployeeName, Department, Salary, ManagerID)
VALUES
(101, 'Alice',    'HR',        45000, 109),
(102, 'Bob',      'HR',        55000, 109),
(103, 'Charlie',  'HR',        55000, 109),
(104, 'David',    'IT',        80000, 110),
(105, 'Emma',     'IT',        75000, 110),
(106, 'Frank',    'IT',        70000, 110),
(107, 'Grace',    'Sales',     60000, 111),
(108, 'Henry',    'Sales',     65000, 111),
(109, 'Isabella', 'HR',        90000, NULL),
(110, 'Jack',     'IT',       100000, NULL),
(111, 'Kevin',    'Sales',     85000, NULL),
(112, 'Liam',     'Finance',   72000, 113),
(113, 'Mia',      'Finance',   95000, NULL),
(114, 'Noah',     'Finance',   72000, 113),
(115, 'Olivia',   'Marketing', 68000, 116),
(116, 'Peter',    'Marketing', 88000, NULL),
(117, 'Quinn',    'Marketing', 68000, 116),
(118, 'Ryan',     'IT',        80000, 110),
(119, 'Sophia',   'Sales',     60000, 111),
(120, 'Thomas',   'HR',        50000, 109); 
select* from employees; 

#display all employees earning more than the acg salary
with cte1 as (
select EmployeeID, EmployeeName, salary
from employees),
cte2 as(
select avg(salary) as avg_sal 
from cte1)
select* from cte1
where salary> (select avg_sal from cte2); 

#find employees whose salary is above the department average.
with cte1 as(
select department, avg(salary) as avg_sal
from employees
group by department
)
select e.*
from employees as e
join cte1 as c
on e.department = c.department
where e.salary > c.avg_sal; 

#departments with avg salary greater than comany's avg salary
with cte1 as(
select department, avg(salary) as dept_avg
from employees
group by department)
select* from cte1 where dept_avg > (select avg(salary) as company_avgsal from employees);

# departments having more than 5 employees
with cte1 as(
select count(employeeID) as employee_count, department
from employees
group by department)
select * from cte1 where employee_count > 5;  

# employees working in departments having more than 5 employees
with cte1 as(
select count(employeeID) as employee_count, department
from employees
group by department)
select e.* 
from employees as e
join cte1 as c
on e.department = c.department
where employee_count > 5; 
# or(subquery)
select employeename from employees where department in
(select department
from employees
group by department
having count(employeeid) >5);



# find employees whose salary is equal to the company salary
with cte1 as (
select EmployeeName, salary
from employees),
cte2 as (
select max(salary) as comp_max_salary
from cte1)
select * from cte1 where salary > 
( select comp_max_salary from cte2); 

#find highest paid employee in each department (like correlated subquery)
#cte+ join
with cte1 as(
select max(salary) as max_salary, department
from employees
group by department)
select e.*
from employees as e
join cte1 as c
on e.department = c.department
where e.salary = c.max_salary;
#using correlated subquery
select e1.*
from employees as e1
where salary =
(select max(e2.salary) as max_salary
from employees as e2
where e1.department = e2. department);
#using cte + window function
with cte1 as(
select *, dense_rank() over(partition by department order by salary desc) as d_rnk
from employees
) 
select * from cte1 where d_rnk = 1;


# find employees of departments with the highest average salary.
# CTE 
with cte1 as(
select department, avg(salary) as dept_avg_sal
from employees
group by department),
cte2 as (
select max(dept_avg_sal) as max_of_dept_avg_sal
from cte1)
select *
from employees where department in
( select department from cte1 where dept_avg_sal= (select max_of_dept_avg_sal from cte2));
#other way is subquery
select * from employees where department =
(select department 
from employees
group by department
order by avg(salary) desc
limit 1); 

#employees of department whose average salary is greater than the comapny avgerage salary
with cte1 as
(select department, avg(salary) as dep_avg_sal
from employees
group by department),
cte2 as
(select avg(salary) as company_avg_sal
from employees)
select e.*
from employees as e
join cte1 as c
on e.department = c.department
where dep_avg_sal > (select company_avg_sal from cte2); 

# find employees earning more than both the company average and the department average
with cte1 as
(select department, avg(salary) as dept_avg_sal
from employees
group by department),
cte2 as 
(select avg(salary) as company_avg_sal
from employees)
select e.*
from employees as e
join cte1 as c
on c.department = e.department
where e.salary > c.dept_avg_sal
and e.salary > (select company_avg_sal from cte2); 

# top 3 highesr salaries
with cte1 as
( select *, 
dense_rank() over(order by salary desc) as rnk
from employees)
select * from cte1 where rnk <=3; 

# display second highest salary
with cte1 as
( select *, 
dense_rank() over(order by salary desc) as rnk
from employees)
select * from cte1 where rnk =2;  

# dsisplay all duplicate salaries
with cte1 as
(select salary, count(*) as salary_count
from employees
group by salary
having count(*) >1)
select * from cte1; 

# display employees having duplicate salaries

with cte1 as
(select salary, count(*) as salary_count
from employees
group by salary
having count(*) >1)
select e.*
from employees as e
join cte1 as c
on e.salary = c.salary; 

#find employees whose salry is above the department average but below the company average
with cte1 as(
select department, avg(salary) as dep_avg_sal
from employees
group by department),
cte2 as(
select avg(salary) as company_avg
from employees)
select e.*
from employees as e
join cte1 as c
on e.department = c.department
where e.salary > c.dep_avg_sal 
and e.salary < (select company_avg from cte2); 


# find departments having no employees earning more than 1 lakh
with cte1 as(
select max(salary) as max_sal, department
from employees
group by department)
select* from cte1 where max_sal <100000;

#find employee(s) having maximum salary in each department using row_number
with cte1 as(
select*, 
row_number() over(partition by department order by salary desc) as dep_sal_rn
from employees)
select * from cte1 where dep_sal_rn =1; 

# find top 2 earn from every department
with cte1 as(
select*, 
dense_rank() over(partition by department order by salary desc) as dep_sal_rn
from employees)
select * from cte1 where dep_sal_rn <=2;  

#find the percentage contribution of each department's salary to the total company salary
with cte1 as(
select department , sum(salary) as dep_total_sal
from employees
group by department),
cte2 as 
(select sum(salary) as comp_total_sal
from employees)
select c.department, c.dep_total_sal,
round((c.dep_total_sal * 100.0)/ ct.comp_total_sal) as percentage
from cte1 as c
cross join cte2 as ct;