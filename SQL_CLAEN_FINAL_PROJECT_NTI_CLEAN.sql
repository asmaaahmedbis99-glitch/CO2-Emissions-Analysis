create database project_nti;
use project_nti;

select * from final_clean_data;

describe final_clean_data ;


select count(*) as Total_Rows from final_clean_data;


USE project_nti;

DROP TABLE IF EXISTS final_clean_data;

CREATE TABLE final_clean_data (
    Name VARCHAR(100),
    year INT,
    iso_code VARCHAR(10),
    co2_growth_abs DOUBLE,
    co2_growth_prct DOUBLE,
    co2_per_capita DOUBLE,
    co2_per_gdp DOUBLE,
    cumulative_co2 DOUBLE,
    ghg_per_capita DOUBLE,
    land_use_change_co2 DOUBLE,
    temperature_change_from_ch4 DOUBLE,
    temperature_change_from_co2 DOUBLE,
    temperature_change_from_ghg DOUBLE,
    temperature_change_from_n2o DOUBLE,
    total_ghg DOUBLE,
    total_ghg_excluding_lucf DOUBLE,
    population BIGINT,
    gdp DOUBLE,
    co2 DOUBLE,
    cement_co2 DOUBLE,
    coal_co2 DOUBLE,
    oil_co2 DOUBLE
);




USE project_nti;

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/saued/Downloads/Telegram Desktop/Final_Clean_Data.csv'
INTO TABLE final_clean_data
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS Total_Rows FROM final_clean_data;




select database();
show tables;
select * from final_clean_data limit 10;




-- 1- Name and Total CO2 by country

select Name,sum(CO2) as Total_CO2 
from final_clean_data
group by Name
order by Total_CO2 desc;





-- 2 Total CO2 by year

select year,sum(CO2) as Total_CO2
 from final_clean_data
group by year
order by Total_CO2 desc;





-- 3- Top 10 countries by CO2

select Name,sum(CO2) as Total_CO2 
from final_clean_data
group by Name
order by Total_CO2 desc
limit 10;




-- 4- Average CO2 per capita

select Name,avg(co2_per_capita) as AVG_CO2_Per_Capita
from final_clean_data
group by Name
order by AVG_CO2_Per_Capita desc;





-- 5- Cumulative CO2 by country and year

select Name,year,Cumulative_CO2
from final_clean_data
order by Name,year;





-- 6- GDP and CO2 by year

select year,sum(gdp) as Total_GDP,sum(co2) as Total_CO2
from final_clean_data
group by year
order by year;






-- 7- GDP and CO2 by country

select Name,sum(gdp) as Total_GDP,sum(co2) as Total_CO2
from final_clean_data
group by Name
order by Total_CO2;





-- 8- Population and CO2 by year

select year,sum(population) as Total_Population,sum(co2) as Total_CO2
from final_clean_data
group by year
order by year;




-- 9- Population and CO2 by country
select Name,
       avg(population) as Average_Population,
       sum(co2) as Total_CO2
from final_clean_data
group by Name
order by Total_CO2 desc;




-- 10- Coal CO2 and total CO2 by year

select year,sum(coal_co2) as Total_Coal_CO2,sum(co2) as Total_CO2
from final_clean_data
group by year
order by year;




-- 11- Coal CO2 and total CO2 by name

select Name,sum(coal_co2) as Total_Coal_CO2,sum(co2) as Total_CO2
from final_clean_data
group by Name
order by Total_CO2 desc;




-- 12- Oil CO2 and total CO2 by year

select year,sum(oil_co2) as Total_Oli_CO2,sum(co2) as Total_CO2
from final_clean_data
group by year
order by year;




-- 13- Oil CO2 and total CO2 by country

select Name,sum(oil_co2) as Total_Oli_CO2,sum(co2) as Total_CO2
from final_clean_data
group by Name
order by Total_CO2 desc;




-- 14- Countries above average CO2

select Name,sum(co2) as Total_CO2
from final_clean_data
group by Name
having Total_CO2 > (
select avg(Total_CO2)
from (select sum(co2) as Total_CO2
from final_clean_data
group by Name)
as T

)
order by Total_CO2 desc;





-- 15- Years Above Average CO2

select year,sum(co2) as Total_CO2
from final_clean_data
group by year
having Total_CO2 >(
select avg(Total_CO2)
from (select sum(co2) as Total_CO2
from final_clean_data
group by year)
as T
)
order by year;





-- 16- Countries Above Average CO2 Per Capita

select Name,avg(co2_per_capita) as AVG_CO2_Per_Capita
from final_clean_data
group by Name
having avg(co2_per_capita) > (
select avg(AVG_CO2_Per_Capita)
from (select Name,avg(co2_per_capita) as AVG_CO2_Per_Capita
from final_clean_data
group by Name
)
as T

)
order by AVG_CO2_Per_Capita desc;




-- 17- Countries Above Average GDP

select Name,avg(gdp) as AVG_GDP
from final_clean_data
group by Name
having avg(gdp) >(
select avg(gdp)
 from final_clean_data)
order by  AVG_GDP desc;




-- 18- Countries Above Average CO2 in Latest Year

select Name,year,co2
from final_clean_data
where year =
(
select max(year)
from final_clean_data
)

and co2 >
(
select avg(co2)
from final_clean_data
where year =
(
select max(year)
from final_clean_data
)
)
order by co2 desc;



-- 19- Top 10 countries by CO2 per capita in latest year

select Name, year, co2_per_capita
from final_clean_data
where year = (
    select max(year)
from final_clean_data
)
order by co2_per_capita desc
limit 10;





-- 20- Coal CO2, Oil CO2 and total CO2 by country


select Name,
       sum(coal_co2) as Total_Coal_CO2,
       sum(oil_co2) as Total_Oil_CO2,
       sum(co2) as Total_CO2
from final_clean_data
group by Name
order by Total_CO2 DESC; 






-- 21- Total CO2 and CO2 growth by year


select year,
       sum(co2) as Total_CO2,
       sum(co2_growth_abs) as CO2_Growth
from final_clean_data
group by year
order by year;




-- 22- Cement CO2 and total CO2 by country

select Name,
       sum(cement_co2) as Total_Cement_CO2,
       sum(co2) as Total_CO2
from final_clean_data
group by Name
order by Total_CO2 desc;




