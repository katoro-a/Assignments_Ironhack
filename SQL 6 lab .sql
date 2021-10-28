select * from sakila.actor; 
select last_name from sakila.actor
group by last_name 
having count(*)=1
;
select first_name, count(*)as b
from sakila.actor 
group by first_name
;
-- this counts how many times each name repeates 
select first_name, count(first_name) as B
from sakila.actor
group by first_name
having B>1;

select last_name, count(*) as count_last
from sakila.actor
group by last_name
having count_last = 1; 

select last_name, count(*) as count_last
from sakila.actor
group by last_name
having count_last>1; 




-- Q2 last names that appear more than once 
select last_name, count(*) as b
from sakila.actor 
group by last_name 
having b>1; 

-- Q3 find out how many rentals were processed by each employee 
select * from sakila.rental; 
select staff_id,count(*) as BB
from sakila.rental 
group by staff_id; 

-- Q4 Using the film table, find out how many films were released each year.
select * from sakila.film;
select release_year , count(*) as AA
from sakila.film
group by release_year;
 
-- Q5 Using the film table, find out for each rating how many films were there.
select * from sakila.film;  
select rating, count(*) as HH
from sakila.film
group by rating; 

-- Q6 What is the mean length of the film for each rating type.
--  Round off the average lengths to two decimal places 

select  length as N,rating
from sakila.rental
group by N,rating
;

-- Q7 Which kind of movies (rating) have a mean duration of more than two hours?
	-- group by rating caluculate the mean 120 min 
select * from sakila.film;  
select rating, avg(length) as average 
from sakila.film
group by rating
having average > 120;



