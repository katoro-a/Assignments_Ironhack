select * from sakila.actor; 
-- Question 1 which are the actors whose last names are not repeated? 
select count(last_name) as name_count, last_name
from sakila.actor 
group by last_name 
having name_count=1; 
-- 2  Which last names appear more than once? 
select count(last_name) as name_count, last_name
from sakila.actor 
group by last_name  
having name_count>1; 
-- 3 Using the rental table, find out how many rentals were processed by each employee. 
select * from sakila.rental; 
select count(staff_id)as count, staff_id 
from sakila.rental 
group by staff_id;  
-- 4 Using the film table, find out how many films were released each year.
select * from sakila.film;
select release_year , count(release_year) as count
from sakila.film 
group by release_year; 
-- 5 Using the film table, find out for each rating how many films were there.
select count(film_id) as count, rating 
from sakila.film 
group by rating;
-- 6 What is the mean length of the film for each rating type.	
	-- Round off the average lengths to two decimal places 
select * from sakila.film;
select round(avg(length),2) as average_len, rating 
from sakila.film 
group by rating; 
-- 7 Which kind of movies (rating) have a mean duration of more than two hours?
select round(avg(length),2) as average_len, rating 
from sakila.film 
group by rating
having average_len >120;


