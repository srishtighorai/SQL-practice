#create database 
create database operaters_prac;
use operaters_prac;

select* from heart_pw; 

#extract records where heartdisease = 1
select* from heart_pw where heartdisease = 1; 

# extract records where heartdisease = 0
select * from heart_pw where heartdisease = 0; 

# extract rows where cholesterol is greater than 200
select * from heart_pw where cholesterol > 200; 

# extract rows where restingbp <=130
select * from heart_pw where restingbp <= 130; 

# extract records where heartdisease is NOT EQUAL to 1
select * from heart_pw where heartdisease != 1; 

# MULTIPLE CONDITIONS- AND , OR
# extract rows where heartdisease is equal to 1 and cholestrol = 200
select* from heart_pw
where heartdisease = 1
and cholesterol = 200; 

# extract records where EITHER heartdisease = 1 or cholesterol > 200
select* from heart_pw where
heartdisease = 1
or cholesterol > 200; 

# extract rows where restingbp >150 and exerciseangina is not N
select* from heart_pw where
restingbp > 150
and exerciseangina != "N";
 
 # BETWEEN 
 # extract rows where value of cholesterol is between 150 and 250 (both inclusive)
 select* from heart_pw where cholesterol between 150 and 250; 
 
 # if exclusive
 select* from heart_pw where cholesterol >150 and  cholesterol <250;
 
 #using between and exclusive 150 and 250 
 select * from heart_pw where cholesterol between 151 and 249;
 
 select * from heart_pw; 
 
 # NOT BETWEEN
 select * from heart_pw where cholesterol not between 150 and 250; 
 
  
 # extract records where restingecg column is EITHER lvh, normal or st
 select * from heart_pw where restingecg  = "lvh"
 or restingec = "normal"
 or restingecg = "st";
 
 #in
 # extract records where restingecg is either lvh, normal or st
 select* from heart_pw
 where restingecg in ("lvh", "normal", "st");
 
 #not in
 select* from heart_pw 
 where restingecg not in ("lvh", "normal"); 
 
 select * from heart_pw where age in (75,76);
 
 # IS
 # IS always used with NULL and NOT NULL
 
 select * from heart_pw where age is null;
 
  select * from heart_pw where age is not null;
  
  
select* from heart_pw order by cholesterol desc, 
restingbp asc;