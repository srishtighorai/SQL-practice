use prac_db;
create table employee(
emp_id int primary key,
name char(50),
department_id varchar(20),
salary int
);

insert into employee values
(101, "Abhishek", "D01", 62000),
(102, "Shubham", "D01", 58000),
(103, " Priya", "D02", 67000),
(104, " Rohit", "D02", 64000),
(105, "Neha", "D03", 72000),
(106, "Aman", "D03", 55000),
(107, "Ravi", "D04", 60000),
(108, "Sneha", "D04", 75000),
(109, "Kiran", "D05", 70000),
(110, "Tanuja", "D05", 65000); 

create table Department(
department_id varchar(20) primary key,
department_name char(50),
location char(50)
);  

insert into Department values
("D01", "Sales", "Mumbai"),
("D02", "Marketing", "Delhi"),
("D03", "Finance", "Pune"),
("D04", "HR", "Bengaluru"),
("D05", "IT", "Hyderabad"); 

create table sales(
sale_id int primary key,
emp_id int,
sale_amount int,
sale_date date
); 

insert into sales values
(201, 101, 4500, "2025-01-05"),
(202, 102, 7800, "2025-01-10"),
(203, 103, 6700, "2025-01-14"),
(204, 104, 12000, "2025-01-20"),
(205, 105, 9800, "2025-02-02"),
(206, 106, 10500, "2025-02-05"),
(207, 107, 3200, "2025-02-09"),
(208, 108, 5100, "2025-02-15"),
(209, 109, 3900, "2025-02-20"),
(210, 110, 7200, "2025-03-01");

select* from employee;
select* from department;
select* from sales; 

# retrieve the names of employees who earn more than avg salary of all employees
select name from employee where salary > 
(select avg(salary) as avg_salary from employee); 

#find employees who belong to the department with highest avg salary
select name from employee where department_id =
(select department_id
from employee
group by department_id
order by avg(salary) desc
limit 1); 


#list all employees who have made at least one sale
select name from employee where emp_id in 
(select emp_id from sales); 

#employee with the highest sale amount
select name from employee where emp_id =
(select emp_id from sales where sale_amount=
(select max(sale_amount) as highest_sale_amount from sales)); 
#OR
select e.name, s.sale_amount
from employee as e
join sales as s
on e.emp_id = s.emp_id
order by s.sale_amount desc
limit 1; 

# retrive names of employees whose salaries are higher than shubham's salary
select name from employee where salary >
(select salary from employee where name = "Shubham"); 

# find employees who work in the same departmnet as abhishek
select name from employee where department_id in
(select department_id from employee where name = "Abhishek"); 

# list departments that have at least one employee earning more than 60000
select department_name from department where department_id in
(select department_id from employee where salary > 60000); 

#find department name of employee who made highest sale
select department_name from department where department_id in
(select department_id from employee where emp_id =
(select emp_id from sales where sale_amount =
(select max(sale_amount) as highest_sale from sales))); 
#OR
select d.department_name
from department as d
join employee as e
on d.department_id = e.department_id 
join sales as s
on e.emp_id = s.emp_id
where sale_amount =
(select max(sale_amount) as highest_sale from sales); 

# retrive employees who have made sales greater than the average sale amount
select name from employee where emp_id in
(select emp_id from sales where sale_amount > 
(select avg(sale_amount) as avg_sales from sales)); 

#find the total sales made by employees who earn more than the average salary
select sum(sale_amount) as total_sales from sales where emp_id in
(select emp_id from employee where salary >
(select avg(salary) as avg_salary from employee));
 #OR
 select sum(sale_amount) as total_sales
 from sales as s
 join employee as e
 on s.emp_id = e.emp_id
 where e.salary > 
 (select avg(salary) as avg_salary from employee);

#find employees who have not made any sales
select name from employee where emp_id not in 
(select emp_id from sales); 
#OR 
select e.name 
from employee as e
left join sales as s
on e.emp_id = s.emp_id
where s.sale_id is null;


 #list departments where the average salary is above 55000
select department_name from department where department_id in
(select department_id
from employee
group by department_id
having avg(salary) > 55000);

#retrieve department name where total sales exceed 10000
select d.department_name
from department as d
join employee as e
on d.department_id = e.department_id
join sales as s
on e.emp_id = s.emp_id
group by d.department_name
having sum(s.sale_amount) >10000; 

select department_name from department where department_id in
(select department_id
from
(select e.department_id, sum(s.sale_amount) as total_sales
from employee as e
join sales as s
on e.emp_id = s.emp_id
group by e.department_id) as department_ts
where total_sales >10000);

#find employees who has second highest sale
select name from employee where emp_id in
(select emp_id from sales where sale_amount =
(select max(sale_amount) as secondghighest_sale from sales where sale_amount != 
(select max(sale_amount) as max_sales from sales))); 

# retrieve name of employees whose salary is greater than the highest sale recorded
select name from employee where salary >
(select max(sale_amount) from sales); 

select e.name 
from employee as e
join sales as s
on e.emp_id = s. emp_id
where e.salary >
(select max(sale_amount) as max_sales from sales);