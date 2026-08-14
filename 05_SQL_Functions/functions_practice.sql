#FUNCTIONS
select * from vo_sql; 

# TEXT FUNCTIONS
#UPPER
select upper(status) as status_upper from vo_sql; 
# lower
select lower(status) from vo_sql; 

#length
select length(contactfirstname), contactfirstname from vo_sql; 

#concat
select concat(contactfirstname," ", contactlastname)as full_name from vo_sql; 

desc vo_sql; 
 # extract part of a substring
select orderdatetime from vo_sql;
#extract day from orderdatetime
select substring(orderdatetime,1,2) as day from vo_sql; 
#extract month
select substring(orderdatetime,4,2) as month from vo_sql; 
#extract year
select substring(orderdatetime,7,4) as year from vo_sql; 
#extract complete date
select substring(orderdatetime,1,10) as date from vo_sql; 
#left-extract string from left
#right- extract string from the right
#extract day
select left(orderdatetime,2) as day from vo_sql; 
#extract seconds
select right(deliverydatetime,2) as sec_deliverydatetime from vo_sql; 
#trim-remove extra spaces
select length(trim('          shubham        ')) as trimmed_name, length('          shubham        ') as length_name from vo_sql;


select * from vo_sql;
# I want to replace the bikes with motorcycles in the productline column
select replace(productline, 'Motorcycles', 'Bikes') from vo_sql; 
#reverse
select productline, reverse(productline) from vo_sql;

#find the position of a character in a string
select instr(contactfirstname, 'a') from vo_sql; 

# substring_index
#syntax- substring_index(string,delimitor,count_of_delimitor)
#Aditya Roy Kapoor
#return aditya
select substring_index("Aditya Roy Kapoor"," ",1) as first_name; 
# return Kapoor
select substring_index("Aditya Roy Kapoor"," ",-1) as last_name; 
#return roy
select substring_index("Aditya Roy Kapoor"," ",2);
#this gives Aditya Roy and not Roy
#So, put substring_index("Aditya Roy Kapoor"," ",2) as string input to retrive Roy.
select substring_index(substring_index("Aditya Roy Kapoor"," ",2)," ",-1) as middle_name;

# 13, Baker Street, London, 400056
#retreive 13
select substring_index("13, Baker Street, London, 400056",", ",1) as house_number;
# retreive 13, Baker Street
select substring_index("13, Baker Street, London, 400056",", ",2) as housenumber_street; 
# Baker Street 
select substring_index(substring_index("13, Baker Street, London, 400056",", ",2),", ",-1) as street; 
# retreive 13, Baker Street, London
select substring_index("13, Baker Street, London, 400056",", ",3) as housenumber_street_area; 
#retrive London 
select substring_index(substring_index("13, Baker Street, London, 400056",", ",3),", ",-1) as area; 
# retreive baker
select substring_index(substring_index(substring_index("13, Baker Street, London, 400056",", ",2),", ",-1)," ",1);

#date time functions
select now();
select date(now()); 
#extract year out of the above date
select year(date(now()));
#extract month
select month(date(now())); 
#extract day
select day(date(now())); 

#DATE_FORMAT function
select curdate(); 
select date_format(curdate(),"%y %d %W");
select date_format(curdate(), "%Y %M %d %W"); 
select date_format(now(),"%Y /%M/ %d-%h/%i/%i/%s/%p"); 

#str_to_date-converts string to date
select orderdatetime, str_to_date(orderdatetime,"%d-%%m-%Y %H:%i:%s") as date_actual from vo_sql;

#date_add, date_sub, dateiff, timeiff
#add days to curdate
select date_add(curdate(), INTERVAL 7 day); 
select date_add(curdate(), INTERVAL 4 month); 
#date_sub
select date_sub(curdate(), INTERVAL 7 day);
select date_sub(curdate(), interval 4 month);
select date_sub(curdate(), interval 2 year); 

#dateiff
select datediff("2026-07-12", "2026-07-01"); 
select datediff(curdate(), "2026-07-01");
select datediff(now(), "2026-07-01");

#timediff
select timediff(now(), "10:00:00"); #timediff does not work with now()
select timediff("14:30:00", "11:45:00");
select timediff(curtime(), "08:56:09"); 

#WINDOW FUNCTIONS
#used with over() clause
#rank

 use srishtidb;
 create table sample(
 sname char(50),
 marks int
 ); 
 insert into sample values
 ("Rahul", 95),
 ("priya",90),
("amit",90),
("neha",85),
("ravi",80);

select* from sample; 
select*,
 rank() over(order by marks desc) as rnk,
 dense_rank() over(order by marks desc) as dense_rnk,
 row_number() over(order by marks desc) as row_no
 from sample; 
 
 create table sample2 (
empname char(50),
dept char(50),
salary int
);

insert into sample2 values
("a","hr",80000),
("b","hr",70000),
("c","hr",70000),
("d","it",90000),
("e","it",80000),
("f","it",80000);
 
 select*  from sample2; 
 
 select*,
 rank() over(partition by dept order by salary desc) as rnk,
 dense_rank() over(partition by dept order by salary desc) as d_rnk,
 row_number() over(partition by dept order by salary desc) as row_no
 from sample2;
 
