use world; 
select* from city; 
select* from country; 
select* from countrylanguage; 

#count how many cities are there in each country
select count(ci.ID) as total_cities, c.name
from country as c
left join city as ci
on c.code = ci.countrycode
group by c.name; 

#same Q, if dont done by countrycode
select count(ID) as total_cities, countrycode
from city 
group by countrycode; 

#display all continents having more than 30 countries
select continent, count(code) as total_countries
from country
group by continent
having total_countries>30; 

# list regions whose total population exceeds 200 million
select sum(population) as total_population, region
from country
group by region
having total_population>200000000; 

#Top 5 continents by average GNP per country
select avg(GNP) as avg_GNP, continent
from country
group by continent
order by avg_GNP desc
limit 5;

# find total number of official languages spoken in each continent
select c.continent, count(cl.language) as total_number_of_languages
from country as c
left join countrylanguage as cl
on c.code = cl.countrycode
where isofficial="T"
group by c.continent; 

# Find the maximum and minimum GNP for each continent.
select continent, min(GNP) as min_GNP, max(GNP) as max_GNP
from country
group by continent;

#country with the highest avg city population
select c.name, avg(ci.population) as avg_population
from country as c
inner join city as ci
on c.code =ci.countrycode
group by c.name
order by avg_population desc
limit 1;

# continents where the avg city population > 200000
select c.continent, avg(ci.population) as avg_city_population
from country as c
inner join city as ci
on c.code = ci.countrycode
group by c.continent
having avg_city_population >200000;

# total population and avg life expentancy for each continent, orderd by avg life expentancy
select continent, sum(population) as total_population, avg(LifeExpectancy) as avg_LifeExpectancy
from country
group by continent
order by avg_LifeExpectancy desc;  

# top 3 continents with highest avg life expectancy, but only those where total population is over 200 million

select continent, sum(population) as total_population, avg(LifeExpectancy) as avg_LifeExpectancy
from country
group by continent
having total_population >200000000
limit 3;