use operaters_prac;
select* from vo_sql; 

#WILD CARDS
# LIKE operators- pattern matching
#extract records from table where contact first name starts with J
select* from vo_sql where contactfirstname like "J%"; 

#extract records where contactfirstname starts with J and has exactly 5 characters including J
Select * from vo_sql where contactfirstname like "J____"; 

#extract records where contactfirstname starts with J and ends with e and has a total 5 characters
select * from vo_sql where contactfirstname like "J___E";

# extract records where contactfirstname contains a string called "uli"
select* from vo_sql where contactfirstname like "%uli%"; 

#extract records where contactfirstname' 2nd character is "u"
select * from vo_sql where contactfirstname like "_u%"; 

# extract reocrds where contact firstname contains exactly 5 characters
select* from vo_sql where contactfirstname like "_____"; 

#extract records contactfirstname DOES NOT start using J
Select * from vo_sql where contactfirstname  not like "J%";  

select * from vo_sql; 

