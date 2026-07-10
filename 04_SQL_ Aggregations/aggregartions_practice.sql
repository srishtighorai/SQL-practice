use ecommerce; 
select* from purchases; 

#AGGREGATION
# count the number of users who have purchased
select count(user_id) from purchases; 

# count all the distinct users who have purchased
select count(distinct user_id) from purchases; 

# Find the sales
select*, quantity*price  as sales
from purchases; 

select*, round(quantity*price,2) as sales
from purchases; 

# what is the lowest and highest quantity
select max(quantity), min(quantity) 
from purchases;

# what is the average sales and total sales
select round(avg(quantity* price),2) as avg_sales,
 round(sum(quantity*price),2) as total_sales
from purchases; 

# group by
select* from purchases; 

# total quantity purchased by each and every user
select user_id, sum(quantity) as total_qty
from purchases
group by user_id; 
# in desc order
select user_id, sum(quantity) as total_qty
from purchases
group by user_id
order by total_qty desc; 

# users with total quantity >10
select user_id, sum(quantity) as total_quantity
from purchases
group by user_id
having total_quantity>10;

# users with total quantity >10 and arrange them in descending order
select user_id, sum(quantity) as total_quantity
from purchases
group by user_id
having total_quantity>10
order by total_quantity desc; 

#how many times each and every product_id has been purchased?
select count(product_id) as no_of_pid, product_id
from purchases
group by product_id; 

##how many times each and every product_id has been purchased which are greater than 10 times
select count(product_id) as no_of_pid, product_id
from purchases
group by product_id
having no_of_pid >10; 

# Find total top 5 users by total spending?
select user_id, round(sum(quantity*price),2) as total_spending
from purchases
group by user_id
order by total_spending
limit 5; 


select* from purchases;
#Find the avg purchase value (avg sales) for users who made more than 2 purchases?
select user_id, count(purchase_id) as no_of_purchases, round(avg(quantity*price),2) as avg_sales
from purchases
group by user_id
having no_of_purchases >2;

#Find percentage contribution of each product to total revenue
#1. Total reevenue
select round(sum(quantity*price),2) as total_revenue 
from purchases;
#2. finding percentage of each product :-(total revenue of each product/total revenue)*100 as percentage of total revenue
select product_id, (round(sum(quantity*price),2)/(select round(sum(quantity*price),2) as total_revenue 
from purchases))*100 as perc_contribution_of_totalrevenue
from purchases
group by product_id; 

#Query to show users whose total spending exceeds 500

select user_id, sum(quantity*price) as total_spending
from purchases
group by user_id
having total_spending>500; 

# max and min price for each product
select product_id, min(price) as min_price, max(price) as max_price
from purchases
group by product_id; 

Select* from vo_final;
 
 # find the revenue for each country where status = shipped, show only those contries whose total revenue >10000, sort by revenue in desc order
 select sum(quantityordered*priceeach) as total_revenue, country
 from vo_final
 where status ="shipped"
 group by country
 having total_revenue>10000
 order by total_revenue desc; 
 
 #find avg price for each city where country is USA, show only those cities whose avg price >80, sort by avg price in desc order
 select city, avg(priceeach) as avg_price
 from vo_final
 where country = "USA"
 group by city
 having avg_price >80
 order by avg_price desc;
  
  # find the number of orders for each territory whose status is shipped, sort by count desc
  select territory, count(ï»¿ORDERNUMBER) as no_of_orders
  from vo_final
  where status= "shipped"
  group by territory
  order by no_of_orders desc; 
  
  
  #find the total revenue for each city where territory =emea
  select city, sum(quantityordered*priceeach) as total_revenue
  from vo_final
  where territory ="emea"
  group by city; 
  
  #find the total quantity order by each customer where product line = motor cycle
  select * from vo_final;
  select sum(QUANTITYORDERED) as total_qty, CONTACTFIRSTNAME
  from vo_final
  where productline="motorcycles"
  group by CONTACTFIRSTNAME;
  
  
  