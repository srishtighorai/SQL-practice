use company_db;

create table sales(
sale_id int primary key,
customer_name varchar(50),
amount int,
sale_date date
);

insert into sales (sale_id, customer_name, amount, sale_date) values
(1, "Aditi", 1500, "2024-08-01"),
(2, "rohan", 2200, "2024-08-03"),
(3, "aditi", 3500, "2024-09-05"),
(4, "meena", 2700, "2024-09-15"),
(5, "rohan", 4500, "2024-09-25");

select * from sales; 

# display all sales records sorted by amount (highes-lowest)
select * from sales order by amount desc;  

select * from sales where customer_name = "aditi";