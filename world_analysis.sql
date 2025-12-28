use world;
desc city;
desc country;
desc countrylanguage;
select * from city;
select *from country;
select * from countrylanguage;
select city.name,country.name,CountryCode from city join country on country.code=city.countrycode where countrycode='ind'
select city.name as city ci.population  from city join country c on city.countrycode = country.code where country.name='india'
select country.name,sum(country.population)from country group by country.name
select country.name, countrylanguage.language from country join countrylanguage on country.code=countrylanguage.countrycode where countrylanguage.ISOFFICIAL = 'T';
select country.name,city.name,countrylanguage.language from country join city on city.countrycode=country.code join countrylanguage on CountryCode =countrylanguage.CountryCode;
select country.name,country.Continent from country where Continent='Asia';
select country.name,country.Population from country where Population>50000000;
select distinct continent from country
select * from country where lifeexpectancy is null;
select city.name from city where population>1000000
select country.name from country where country.name like 'A%';
select country.name ,gnp from country where gnp between 10000 and 50000
select city.name ,countrycode from city where countrycode ='ind'
select country.name,population from country order by population desc limit 10;
select country.continent ,count(country.name) as countrycount from country group by continent 
with city_pop as(select countrycode.sum(population) as totatl_city_pop from city group by counr
select country.continent ,avg(lifeexpectancy) from country group by continent
select country.name,max(population),min(population) from country group by country.name 
select country.name ,count(city.name) from country join city on country.code= city.countrycode group by country.name
select country.name,sum(city.population) from country join city on country.code=city.countrycode group by country.name
select country.name,city.name from country join city on country.code=city.countrycode order by city.name desc limit 5;
select country.name,count(city.name) as cityname_count from country join city on country.code=city.countrycode group by country.name order by cityname_count desc limit 5;
select country.name ,country.population ,rank()over(order by population desc ) as population_rank from country order by population_rank;
select country.continent,country.name,rank()over(partition by continent order by country.population desc)as countrypopulation_rank from country  
select city.name ,country.name ,rank() over (partition by country order by city.population desc)as populate_city from country 
select country.name,city.name ,city.population,city.rn from (select countrycode,name,population,row_number()over(partition by countrycode order by population desc)as rn from city)city join country on city.countrycode=country.code where city.rn=1
select city.name ,country.name from(select countrycode,name,population,row_number()over(partition by country order by city.population desc)as rn from city join country on city.countrycode=country.code where city.rn=1;
select name,population,sum(population) over(order by population desc)as running_application from country order by populatiion desc;
select continent,name,LifeExpectancy from (select Continent,name,LifeExpectancy,Dense_rank() over (partition by continent order by lifeexpectancy desc) as rnk from country where lifeexpectancy is not null)t where rnk<=3 order by continent,rnk;
with avg_population as(select avg(population)as avg_pop from country) select name,population from country where population>(select avg_pop from avg_population);
with city_pop as(select countrycode,sum(population) as total_city_population from city group by CountryCode)select country.name,cp.total_city_population from  city_pop cp join country on cp.countrycode=city.countrycode where cp.total_city_population >10000000
with ranked_countries as(select continent ,name ,population ,rank() over (partition by continent order by population desc )as continent_rank from country)select * from ranked_countries order by continent,continent_rank; 
 with city_count as (SELECT CountryCode,COUNT(*) AS total_cities FROM city GROUP BY CountryCode),avg_city as(select avg(total_cities)as avg_cities from city_count)select country.name,city_count.total_cities from city_count join country on city_count.countryCode=country.code where city_count.total_cities>(select avg_cities from avg_city);
 with lang_count as(SELECT Language,COUNT(DISTINCT CountryCode) AS country_count FROM countrylanguage GROUP BY Language),ranked_lang as( select language ,country_count,Dense_rank()over(order by country_count desc )as rnk from lang_count( select language,country_count from ranked_lang where rnk<=3
 select continent ,count(*) as countrycount from country group by continent having count(*)>40;
 select city.countrycode ,avg(city.population) from city group by city.countrycode having avg(city.population)>500000
 select language,count(distinct countrycode)as country_count from countrylanguage group by language having count(distinct countrycode)>5
 select countrycode,count(*)as total_cities from city group by countrycode having count(*)>(select avg(city_count)from(select count(*)as city_count from city group by countrycode)temp );