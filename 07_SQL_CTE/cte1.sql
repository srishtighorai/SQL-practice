use ecommerce_1;
# find out the top 3 products on the basis of price 
#without using limit and order by

select* from customers;
select* from orders; 

with cte1 as(
select price, product_id, 
rank() over(order by price desc) as r_nk
from order_items
) 
select * from cte1 where r_nk <= 3; 

with cte2 as(
select product_id, (quantity*price) as sales
from order_items
),
cte3 as(
select*, rank() over(order by sales desc) as d_r
from cte2 
)
select * from cte3 where d_r <=3; 

#CUSTOMER SPENDING ANALYSIS
#display every customer's cid, cname, no.of orders and total payment
with cte1 as(
select c.customer_id, c.first_name, c.last_name, o.total_amount, o.order_id
from customers as c
inner join orders as o
on c.customer_id = o.customer_id
) 
select customer_id, concat(first_name," ",last_name) as cname, count(order_id) as no_of_orders, 
sum(total_amount) as total_amount_spent
from cte1
group by customer_id, cname; 


select * from products;
select* from orders;
select* from order_items;

#PRODUCT PERRFORMANCE ANALYSIS 
#product name, category, total quantity sold, revenue generated
with cte1 as(
select p.product_name, p.category, p.product_id, oi.quantity, oi.price
from products as p
join order_items as oi
on p.product_id = oi.product_id
),
cte2 as(
select *, (quantity*price) as revenue
from cte1
) 
select sum(revenue) as total_revenue, product_name, category, sum(quantity) as quantity_sold
from cte2
group by product_name, category; 


#CUSTOMER SEGMENTATION
# if  total_amount:
#-- platinum (>10000)
-- gold (5000 - 10000)
-- silver (2000 - 4999)
-- bronze (<2000) 

with cte1 as(
select o.total_amount, c.customer_id
from orders as o
join customers as c
on c.customer_id = o.customer_id
),
cte2 as(
select customer_id, sum(total_amount) as ta 
from cte1 
group by customer_id
) 
select *, case
   when ta>=10000 then "platinum"
   when ta >=5000 then "gold"
   when ta >= 2000 then "silver"
   else "bronze"
   end as customer_category
   from cte2;
  
  
#the best selling (TOP 2) on the basis of revenue.
with cte1 as(
select p.product_id, p.category, oi.quantity, oi.price
from products as p
join order_items as oi
on p.product_id = oi.product_id
),
cte2 as (
select*, (quantity*price) as revenue
from cte1 
),
cte3 as (
select category, sum(revenue) as total_revenue
from cte2 
group by category 
), 
cte4 as (
select*, rank() over(order by total_revenue desc) as rnk_rev
from cte3 
) 
select* from cte4
where rnk_rev <=2; 

# find out customers who are spending above avg 
with cte1 as(
select c.customer_id, o.total_amount
from customers as c
join orders as o
on c.customer_id = o.customer_id 
),
cte2 as(
select customer_id, sum(total_amount) as ta
from cte1
group by customer_id)
select * from cte2 where ta > (select avg(total_amount) as avg_ta from orders);

