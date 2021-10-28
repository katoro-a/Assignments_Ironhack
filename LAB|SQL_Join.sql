
-- ********************************************************************
-- LAB joins 
	-- https://github.com/ironhack-labs/lab-sql-join 
-- 1 List number of films per category.  dont think you need a join since you have film category 
-- FAILED TO DO THIS QUESTION ASK FOR HELP 
select count(f.film_id) as num_film, fcat.category_id
from sakila.film_category fcat
join sakila.film f 
group by category_id;  
-- make a join between category and film category 
select name as category_name, count(*) as num_films
from sakila.category
inner join sakila.film_category 
using (category_id)
having category_id ; -- you can use having as short hand for the equal to thing for the keys 


-- 2 Display the first and last names, as well as the address, of each staff member. 
-- need the staff table, address table
select first_name, last_name, address 
from sakila.staff s
join sakila.address a 
on s.address_id = a.address_id;


-- 3 Display the total amount rung up by each staff member in August of 2005.
	-- use payment table, staff table ? 
    -- want a sum or group by of each staff member on the amount column 
select sum(p.amount)as amount_rung_up, p.staff_id
from sakila.payment p
join sakila.staff s 
on p.staff_id = s.staff_id 
where month(p.payment_date) =8 and year(p.payment_date)=2005
group by p.staff_id
; -- if the first and last name were not unique you wouldnt be able to aggregate it 
-- you forgot to refernce the date and use a where function  
-- using short hand for = group by 1,2; 1 is the first column 
-- its like saying group by column 1 

-- 4 List each film and the number of actors who are listed for that film. 
	-- film_actor, actor or film /film_actor ? 
    -- you want the film name so pick film, 
select f.film_id, f.title, count(fa.actor_id) as number_or_actors
from sakila.film f
join sakila.film_actor fa
on f.film_id = fa.film_id
group by f.film_id, f.title; 
-- * you should have used an inner join here instead of just using join 


-- 5 Using the tables payment and customer and the JOIN command,
-- list the total paid by each customer.  
	-- sum 
-- List the customers alphabetically by last name. 
	-- order by desc

select c.customer_id,c.last_name,
sum(p.amount) as total_customer_paid
 from  sakila.customer c
 join sakila.payment p
 on c.customer_id = p.customer_id
 group by c.customer_id,c.last_name
 order by c.last_name;
 