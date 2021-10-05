-- 1 How many distinct (different) actors' last names are there? 
select count(distinct(last_name))
from sakila.actor;

-- 2 In how many different languages where the films originally produced? (Use the column language_id from the film table)
select distinct(language_id)
from sakila.film;

-- 3 How many movies were released with "PG-13" rating? 

select * from sakila.film; 
select count(rating) as pg13_film_count
from sakila.film
where rating = 'PG-13';
-- 4 Get 10 the longest movies from 2006.
select *
from sakila.film
order by length desc
limit 10;
-- 5 How many days has been the company operating (check DATEDIFF() function)?
-- DONT UNDERSTAND WHAT COLUMN WE SHOULD BE REFERRING TO !
-- ************************************************************************************************
select * from sakila.rental;
-- USING DATEDIFF()
	-- SELECT DATEDIFF (column1 , column2); 
select datediff(rental_date,return_date)as difference 
from sakila.rental;


-- 6 Show rental info with additional columns month and weekday. Get 20. 
-- just try rental date for now  
-- %M is for the full month name 
-- %W is for the full weekday name 
select *,date_format(rental_date, '%M' ) as month_rd, date_format(rental_date, '%W' )as weekday_rd
from sakila.rental
limit 20 ;
-- 7 Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day 
-- of the week. Check the CASE function.  
-- -------------------------------------------
-- USING CASE (formatting)
-- CASE
	-- WHEN condition1 THEN result
    -- ELSE result 
-- END; 
-- ---------------------------------------------------
	-- HOW to combine saturday and sunday as 1 statment using and or or ?
select *, date_format(rental_date, '%W') as week_day,
CASE
	WHEN date_format(rental_date,'%W') = 'saturday' THEN 'weekend' 
    WHEN date_format(rental_date,'%W') = 'sunday' THEN 'weekend'
	ELSE 'workday' 
END as day_type
from sakila.rental
;

-- 8 How many rentals were in the last month of activity?   
-- not sure how to do this question  
-- was able to see what months 
	-- august is the last month of activity but not sure how many 
select distinct(date_format(rental_date, '%M')) as month, count(date_format(rental_date,'%M')) as mm
from sakila.rental   
group by month 
order by month 
;






