-- you have 1 and a 1/2 hours if you have questions ask take your own breaks 
-- pick 2 questions that you want to present 

-- 3.05 1,2,3  
-- https://github.com/ironhack-edu/data_3.05_activities  
-- ACTIVITY 1 
	-- 1 (bank database)Find out the average number of transactions by account. 
    -- Get those accounts that have more transactions than the average.
-- select * from bank.trans; 

-- you could use a temporary table for the inner query so you can call it more than one time  
-- you do have to reference the table more than a few times and that is a limit on of temporary tables 
select count(trans_id) as num_of_trans,  account_id 
from bank.trans 
group by account_id
having num_of_trans> 
(select avg(num_of_trans)
from 
(select count(trans_id) as num_of_trans , account_id
from bank.trans  
group by account_id) sub1  -- have to use an alias on the table created in the inner query 

)
;  
-- if you have a query inside returning a table you need to give it an alias 
-- one result you dont need to 

-- ACTIVITY 2  
	-- 1 Get a list of accounts from Central Bohemia using a subquery.  
		-- join distric and account tables
		select * from bank.district ; 
	-- TRY THIS YOURSELF************************************************
	
        
        
	
    -- 2 Rewrite the previous as a join query. 
		select d.A3,a.account_id
        from bank.account a
        join bank.district d
        on a.district_id = d.A1  
        where d.A3 = "central Bohemia"
        ;
    
	-- 3 Discuss which method will be more efficient.

-- ------------------------------------------------------------------
-- ACTIVITY 3 (makes the most transactions)
	-- 1 Find the most active customer for each district in Central Bohemia. 
		-- have to partition by district 



-- kayla referencing a previous table she made 
-- answered the question differently
-- used rank for each district then used that to find the rank 1 customers  
-- trnscount is a temporary table
SELECT * from 
(select A2 as district, d.client_id,transcount,
rank () over(partition by A2 order by transCount desc) as customerActivity
from accTRANS t
join bank.account a using (account_id)
join bank.disp d using (account_id)
join bank.districs ds on a.district_id=ds.A1 
where A3 ="central bohemia")sub1
where customrActivity =1;



-- ---------------------------------------------------------------
-- lab https://github.com/ironhack-labs/lab-sql-subqueries   
	-- use sakila 

-- 1 How many copies of the film Hunchback Impossible exist in the inventory system? 
			-- sakila.inventory (film_id)
            -- sakila.film (get film id , and title )
   -- without subquery(could also have used distinct instead of count 
   select f.title, count(i.film_id) as copies_of_film_in_inventory
    from sakila.inventory i
    join sakila.film f 
    on i.film_id = f.film_id 
    where title = "Hunchback Impossible" 
    ;     
    
 
  -- how to use a subquery (find the film_id and then set it in a where function 
    select count(*) 
    from sakila.inventory 
    where film_id =  
    (select film_id
	from sakila.film
    where title= "Hunchback Impossible")-- this is not a table dosnt need an alias 
    ; 
    -- or 
    select count(distinct(inventory_id))
    from sakila.inventory
	where film_id =  
    (select film_id
	from sakila.film
    where title= "Hunchback Impossible");
    
-- 2 List all films whose length is longer than the average of all the films.  
	-- use a innerquery 
		-- average on the inside  
        select * from sakila.film;
			select *
            from sakila.film 
			where length > 
            (select avg(length) from sakila.film) 
            group by film_id, title;
-- ****** RETURN TO QUESTION 3 YOU HAVE NOT COMPLETED IT CORRECTLY 
-- **3 Use subqueries to display all actors who appear in the film Alone Trip. 
	-- sakila.film_actor 
    -- find the film id use a where clause or just the film title  
		-- WITHOUT SUBQUERY
		select concat(first_name ,' ',last_name)as name, a.actor_id, fa.film_id, f.title
		from 
        sakila.film f
		join sakila.film_actor fa
        on f.film_id = fa.film_id 
        join sakila.actor a
        on fa.actor_id = a.actor_id
        where title = "Alone Trip"
        ;  
        -- with subquery , does not give actors full name 
	select actor_id 
    from film_actor 
	where film_id =
	(select film_id
	from sakila.film
    where title= "Alone Trip"); 
    
    -- best way to write it 
    select first_name, last_name
    from sakila.actor
    where actor_id in -- how to use a list to reference multiple ids 
    (
    select actor_id 
    from sakila.film_actor 
	where film_id =
	(select film_id
	from sakila.film
    where title= "Alone Trip")
    );
            
		
-- 4 Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films. 
	-- sakila.film_category
	-- sakila.film   
-- **** HOW TO MAKE THE SUBQUERIES 1!!!
select f.title , f.film_id, c.name
from sakila.film f
join sakila.film_category fc
on f.film_id = fc.film_id
join sakila.category c
on fc.category_id = c.category_id 
where c.name = "Family";
-- using subqueries 
	-- so find the catagory id 
    -- check this answer over and try yourself 
    select  title as Title 
    from sakila.film 
    where film_id in (
    select film_id
    from sakila.film_category 
	where category_id = (
    select * 
    from sakila.film_category fc
    join sakila.category f
    where name='Family'));


	
    
-- 5 Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
	-- districts of canada 	
		-- Nova Scotia, Northwest Territories, Nunavat, Quebec, Prince Edward Island,Saskatchewan,Yukon,Alberta,Ontario,British Columbia, Manitoba, New Brunswick, Newfoundland and labrador, 
-- part 1 use subqueries 
-- should have just searched up the countries 
	-- then found the customer ids and then names as the outer query 
select -- Name and country 
from sakila.customer 

where address_id in (
select address_id in (
select address_id
from sakila.address
where city_id in (
select city_id 
from sakila.city 
where country_id in (
select contry_id
from sakila.country 
wehre country = "canada"
)));

-- part 2 use joins  
-- not using joins below 
select concat(c.first_name ,' ',c.last_name) as name, c.email
from sakila.customer c 
join sakila.address a 
on c.address_id = a.address_id 
where a.district  in ( "Nova Scotia", "Northwest Territories", "Nunavat", "Quebec", "Prince Edward Island","Saskatchewan","Yukon","Alberta","Ontario","British Columbia", "Manitoba", "New Brunswick", "Newfoundland and labrador")
;



-- 6 Which are films starred by the most prolific actor? Most prolific actor is defined as the 
	-- actor that has acted in the most number of films. First you will have to find the most
	-- prolific actor and then use that actor_id to find the different films that he/she starred. 


select fa.actor_id, count(fa.film_id) as number_of_films
from sakila.film_actor fa
join sakila.film f
on fa.film_id = f.film_id
group by fa.actor_id
order by number_of_films desc
limit 1
;  

-- part 1
select count(film_id)
from sakila.film_actor 
group by acotr_id
order by count(film_id)desc
limit 1
;
-- part 2
select title from sakila.film 
where film_id =(

select film_id
from film_actor
where actor_id = 
(select count(film_id)
from sakila.film_actor 
group by acotr_id
order by count(film_id)desc
limit 1)sub)); 
-- check screen shots 

-- use this to make a list 
-- can i use a having in clause to provide a list of the actor ids to
-- reference in the film_actor table joined to film to see what movies they starred in ?

-- then make a list of the top 10 actors by id limit with a sub query and make this the inner one 
	-- then make an outer query to find out what films have the most prolific actors 


-- 7 Films rented by most profitable customer. You can use the customer table and payment table to find the most 
-- profitable customer ie the customer that has made the largest sum of payments 
	-- sum the amount of rentals they made 
    select customer_id ,sum(amount) as total 
    from sakila.payment
    group by customer_id
    order by total desc
    limit 1 ;
    
    -- make a outer query using the id to see what movies were rented (joins you need to get the info)   
        -- payment = customer_id,  (need amount)
        -- rental = inventory_id, customer_id,
        -- inventory = inventory_id, film_id
        -- film = film_id, (title of the films)
    -- film , connect with what ? --> 



-- 8 Customers who spent more than the average payments.
	
    
    -- outer  - filter on an aggregation 
select customer_id , sum(amount) as total_spent 
from sakila.payment 
having total_spent>
(select avg(total_spent)
from
(select customer_id , sum(amount) as total_spent 
from sakila.payment
group by customer_id)
sub1)
;
    
 
 
 -- this gives you the list of ids you want
select count(trans_id) as num_of_trans,  account_id 
from bank.trans 
group by account_id
having num_of_trans> 

(select avg(num_of_trans)
from 
(select count(trans_id) as num_of_trans , account_id
from bank.trans  
group by account_id) sub1  -- have to use an alias on the table created in the inner query 
)
;  
-- teacher answer
select customer_id, avg(amount) as avgPayment 
from sakila.payment 
group by customer_id 
having avgPayment >(select avg(amount)
from payment_test);


