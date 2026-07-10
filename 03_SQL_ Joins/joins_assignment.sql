create database joins; 

use joins;
create table customers(
customerID int primary key,
customername char(50),
city char(50)
); 

insert into customers(customerID, customername, city) values
(1, "John Smith", "New York"),
(2, "Mary Johnson", "Chicago"),
(3, "Peter Adams", "Los Angeles"),
(4, "Nancy Miller", "Houston"),
(5, "Robert White", "Miami");

select * from customers; 

create table orders(
orderID int primary key,
customerID int,
orderdate date,
amount int
); 

insert into orders( orderID, customerID, orderdate ,amount) values
(101, 1, "2024-10-01", 250),
(102, 2, "2024-10-05", 300),
(103, 1, "2024-10-07", 150),
(104, 3, "2024-10-10", 450),
(105 , 6, "2024-10-12", 400); 
select* from orders; 

-- joins
-- inner join 
-- retreive all customers who placed at least one order
select o.orderID, o.orderdate, o.amount, c.customerID, c.customername, c.city
from customers as c
inner join orders as o
on c.customerID = o.customerID;  

#retreive all customers and their orders, inclusing customers who have not placed any orders
select o.orderID, o.orderdate, o.amount, c.customerID, c.customername, c.city
from customers as c
left join orders as o
on c.customerID = o.customerID;  

# Retrieve all orders and their corresponding customers, including orders placed by unknown 
select o.orderID, o.orderdate, o.amount, o.customerID, c.customername, c.city
from customers as c
right join orders as o
on c.customerID = o.customerID;  

# full outer join (display all customers and orders , whether matched or not)
select o.orderID, o.orderdate, o.amount, c.customerID, c.customername, c.city
from customers as c
left join orders as o
on c.customerID = o.customerID
union
select o.orderID, o.orderdate, o.amount, o.customerID, c.customername, c.city
from customers as c
right join orders as o
on c.customerID = o.customerID;  

#find all customers who have not placed any order (left join+ is null)
select o.orderID, o.orderdate, o.amount, c.customerID, c.customername, c.city
from customers as c
left join orders as o
on c.customerID = o.customerID
where orderID is null; 


# create payments table
create table payments(
PaymentID CHAR(10) primary key,
customerID int,
Paymentdate date,
amount int
);

insert into payments( paymentID, customerID, paymentdate, amount) values
("P001", 1, "2024-10-02", 250),
("P002", 2, "2024-10-06", 300),
("P003", 3, "2024-10-11", 450),
("P004", 4, "2024-10-15", 200); 

select* from payments; 


# retreive cutomers who have made payments but did not place any orders (inner join +left join+is null)
select o.orderID, o.orderdate, o.amount, c.customerID, c.customername, c.city, p.paymentID, p.paymentdate
from customers as c
inner join payments as p
on c.customerID = p.customerID
left join orders as o
on c.customerID = o.customerID
where orderID is null;  


# cross join Q7
select* from customers cross join orders;

# show all cutomers along with order and payment amounts in one table
select o.orderID, o.orderdate, o.amount, c.customerID, c.customername, c.city, p.paymentID, p.paymentdate, o.amount as orderamount, p.amount as paymentamount
from customers as c
left join orders as o
on c.customerID = o.customerID
left join payments as p
on c.customerID = p.customerID;  


#reterive all customers who have both placed orders and made payments
select o.orderID, o.orderdate, o.amount, c.customerID, c.customername, c.city, p.paymentID, p.paymentdate, o.amount as orderamount, p.amount as paymentamount
from customers as c
inner join orders as o
on c.customerID = o.customerID
inner join payments as p
on c.customerID = p.customerID;  


