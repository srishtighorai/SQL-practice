use operaters_prac;
create table customers(
    cid VARCHAR(10) PRIMARY KEY,
    cname VARCHAR(50),
    cage INT,
    csex VARCHAR(10)
); 

CREATE TABLE transactions (
    tid INT PRIMARY KEY,
    tdate DATE,
    qty INT,
    ppu DECIMAL(10,2),
    amount DECIMAL(10,2),
    cid VARCHAR(10),
    pid VARCHAR(10),
    pname VARCHAR(50)
); 

-- Insert Data into Customers
INSERT INTO customers (cid, cname, cage, csex) VALUES
('c101', 'a', 27, 'male'),
('c102', 'b', 28, 'male'),
('c103', 'c', 22, 'female'),
('c104', 'd', 27, 'female'),
('c106', 'e', 25, 'female');

-- Insert Data into Transactions
INSERT INTO transactions (tid, tdate, qty, ppu, amount, cid, pid, pname) VALUES
(1, '2026-10-23', 4, 2000, 8000, 'c101', 'p1', 'soap'),
(2, '2026-11-21', 2, 1000, 2000, 'c101', 'p2', 'shampoo'),
(3, '2026-08-30', 5, 1500, 7500, 'c102', 'p3', 'shoes'),
(4, '2026-01-13', 1, 3000, 3000, 'c105', 'p4', 'jeans'),
(5, '2026-03-13', 3, 2500, 7500, 'c104', 'p5', 'shirts');
 
 
-- joins


-- inner join
SELECT t.tid, t.tdate, t.pname, t.amount, c.cid, c.cname,
c.cage, c.csex
FROM transactions as t
INNER JOIN customers as c
ON t.cid = c.cid;

-- left join
select t.tid, t.tdate, t.pname, t.amount, t.pid, t.cid, c.cname,
c.cage, c.csex
from transactions as t
left join customers as c
on t.cid = c.cid;

select* from transactions;
select * from customers;

-- right join

select t.tid, t.tdate, t.pname, t.amount, t.pid, c.cid, c.cname,
c.cage, c.csex
from transactions as t
right join customers as c
on t.cid = c.cid; 
 
 
 -- full outer join (combine left and right using union)
 select t.tid, t.tdate, t.pname, t.amount, t.pid, t.cid, c.cname,
c.cage, c.csex
from transactions as t
left join customers as c
on t.cid = c.cid
union
select t.tid, t.tdate, t.pname, t.amount, t.pid, c.cid, c.cname,
c.cage, c.csex
from transactions as t
right join customers as c
on t.cid = c.cid;  

-- cross join
CREATE TABLE T1 (
    pid VARCHAR(10),
    pname VARCHAR(50)
);

CREATE TABLE T2 (
    cid VARCHAR(10),
    cname VARCHAR(50)
);

INSERT INTO T1 VALUES
('p1', 'soap'),
('p2', 'shampoo');

INSERT INTO T2 VALUES
('c1', 'jon'),
('c2', 'conor');

select * from t1 cross join t2; 

-- self join

CREATE TABLE employee (
    eid INT PRIMARY KEY,
    ename VARCHAR(50),
    mid INT
);

INSERT INTO employee VALUES
(1, 'akshay', 4),
(2, 'sarah', 1),
(3, 'madhav', 1),
(4, 'anna', NULL); 

Select
e.ename as employee_name,
m.ename as employee_name
from employee as e
left join employee as m
on e.mid = m.mid;

