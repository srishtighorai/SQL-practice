use prac_db;

create table students_performance (
student_id int primary key,
name varchar(50),
course varchar(30),
score int,
attendance int,
mentor varchar(50),
join_date date,
city varchar(50)
); 

#insert data
insert into students_performance
(student_id, name, course, score, attendance, mentor,
join_date, city) values
(101, "Aarav Mehta", "Data Science", 88, 92, "Dr. Sharma",
"2023-06-12", "Mumbai"),
(102, "Riya Singh", "Data Science", 76, 85, "Dr. Sharma",
"2023-07-01", "Delhi"),
(103, "Kabir Khanna", "Python", 91, 96, "Ms. Nair",
"2023-06-20", "Mumbai"),
(104, "Tanvi Patel", "SQL", 84, 89, "Mr. Iyer", "2023-05-30", "Bengaluru"),
(105, "Ayesha Khan", "Python", 67, 81, "Ms. Nair",
"2023-07-10", "Hyderabad"),
(106, "Dev Sharma", "SQL", 73, 78, "Mr. Iyer", 
"2023-5-28", "Pune"),
(107, "Arjun Verma", "Tableau", 95, 98, "Ms. Kapoor",
"2023-06-15", "Delhi"),
(108, "Meera Pillai", "Tableau", 82, 87, "Ms. Kapoor",
"2023-06-18", "Kochi"),
(109, "Nikhil Rao", "Data Science", 79, 82, "Dr. Sharma",
"2023-07-02", "Mumbai"),
(110, "Priya Desai", "SQL", 92, 94, "Mr. Iyer", 
"2023-05-27", "Bengaluru"),
(111, "Siddharth Jain", "Python", 85, 90, "Ms. Nair", 
"2023-07-02", "Mumbai"),
(112, "Sneha Kulkarni", "Tableau", 74, 83, "Ms. Kapoor", 
"2023-06-10", "Pune"),
(113, "Rohan Gupta", "SQL", 89, 91, "Mr. Iyer", 
"2023-05-25", "Delhi"),
(114, "Ishita Joshi", "Data SCience", 93, 97, "Dr. Sharma", 
"2023-06-25", "Bengaluru"),
(115, "Yuvraj Rao", "Python", 71, 84, "Ms. Nair", 
"2023-07-12", "Hyderabad");

select * from students_performance; 

# create ranking of students based on score(highest first)
select*, rank() over(order by score desc) as r_NK 
from students_performance; 

# show each students score and previous syudents score (based on score order)
select score, lag(score) over(order by score desc) as previous_score
from students_performance; 

# convert all student name to uppercase and extract month name from join_date
select upper(name) as upper_name, monthname(join_date) as month_name 
from students_performance; 

#show student's name and next student's attendance(order by attendance)
select name, attendance, 
lead(attendance) over(order by attendance) as next_attendance
from students_performance; 

#assign students into 4 performance groups using ntile
select*, ntile(4) over(order by score desc) as students_performamce_group 
from students_performance;

#For each course, assign a row based on attendance (highest first)
select*, row_number() over(partition by course order by attendance desc) as row_NUM
FROM students_performance; 

#calculate the number of days each student has been enrolled for(join date to today)
#assuming current date -"2025-01-01"
select name, join_date, 
datediff("2025-01-01", join_date) as enrolled_days
from students_performance; 

#format join_date as "MONTH YEAR" format
select join_date, date_format(join_date, "%M %Y") as month_year
from students_performance; 

#replace city "Mumbai" with "MUM" for display purposes
select replace(city, "Mumbai", "MUM") as changed_city_format 
from students_performance; 

#for each course, find the highest score using first_value
select*, first_value(score) over(partition by course order by score desc) as highest_score
from students_performance;