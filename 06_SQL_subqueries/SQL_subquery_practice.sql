#subqueries
use srishtidb;
create table empjuly(
emp_id int primary key,
name char(50),
dept char(50),
salary int,
age int,
manager_id int
);

insert into empjuly values
(101,"a","it",70000,28,201),
(102,"b","hr",65000,30,202),
(103,"c","it",80000,32,201),
(104,"d","finance",90000,35,203),
(105,"e","hr",60000,26,202),
(106,"f","finance",85000,40,203),
(107,"g","sales",55000,27,204),
(108,"h","sales",75000,33,204),
(109,"i","it",95000,36,201),
(110,"j","hr",72000,29,202);

create table magjuly(
manager_id int primary key,
mname char(50)
);

insert into magjuly values
(201,"raj"),
(202,"meera"),
(203,"anil"),
(204,"vikram"); 

select* from empjuly;
select* from magjuly; 

#find the employee who earns the highest salary
select* from empjuly where salary =
(select max(salary) from empjuly); 


# find employees earning less than the highest salary
select name from empjuly where salary< (select max(salary) from empjuly); 

# find employees whose salary is equal to the second highest salary
select* from empjuly where salary =
(select max(salary) from empjuly where salary !=
(select max(salary) from empjuly)); 


select*from empjuly;
select* from magjuly;
#find the manager name of 'A'
select mname from magjuly where manager_id =
 (select manager_id from empjuly where name ="A");  
 
 #find the maanger of the highest paid employees
 select mname from magjuly where manager_id =
 (select manager_id from empjuly where salary=
 (select max(salary) from empjuly));  
 
 # employees managed by raj
 select name from empjuly where manager_id =
 (select manager_id from magjuly where mname ="RAJ"); 
 
 # find employees earning same salary as any HR employee
select* from empjuly where dept != "HR" and salary in
(select salary from empjuly where dept = "HR"); 

#find employees earning less than the min salary in sales department
select* from empjuly where salary <
(select min(salary) from empjuly where dept = "sales"); 

select* from empjuly; 

#CORRELATED SUBQUERY-
#find employees earning more than ther own department average
select e1.name, e1.salary, e1.dept from empjuly as e1
where salary>
(select avg(e2.salary) from empjuly as e2 where e1.dept = e2.dept);

#find employees whose salary is greater than the company's avg salary
select * from empjuly where salary >
(select avg(salary) from empjuly); 


#HAVING ( grouping required)
#find departments whose avg salary is greater than the company's avg salary
select dept, avg(salary) as avgsal 
from empjuly
group by dept
having avgsal >
(select avg(salary) from empjuly); 

# find the avg salary of all employees earning more than 70K
select avg(salary) 
from
(select salary from empjuly where salary > 70000) as avgsal; 

# find the department with highest average salary 
select dept, avg_salary
from
(select dept, avg(salary) as avg_salary
from empjuly
group by dept) as dept_avg
order by avg_salary desc
limit 1;
