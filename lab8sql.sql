-- LAB 8 
-- 1 Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
select title,length,rank() over (order by length  desc) as 'rank'
from sakila.film
having length <> ' ' or length <> 'null' or length <> 0;    
-- dont use or

-- teacher 
-- if you dont mention anything it is ascending 
select title,length, RANK() over (order by length) ranks
from sakila.film 
where length is not null and length >0;

-- 2 Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, rating and the rank.

select  
title, length, rating ,rank() over (partition by rating order by length desc ) as A
from sakila.film 
having length <> ' ' or length <> 'null' or length <> 0;  
-- taecher 
select title, length, rating,
rank() over (partition by rating order by length desc) as ranks 
from sakila.film 
where length is not null and length > 0;

-- 3 How many films are there for each of the categories in the category table. 
-- Use appropriate join to write this query
select * from sakila.category;  

select  sc.category_id, count(fc.film_id) as 'film count'
from sakila.category sc
join sakila.film_category fc  
on sc.category_id = fc.category_id
group by sc.category_id
; 

-- teacher fil and film category 
use sakila; -- can use this to replace the from function only have to reference the table 
-- better practice is to use the whole from function 
select name as category_name , count(*) as num_films
from sakila.category c1
inner join sakila.film_category c2
on c1.category_id = c2.category_id
group by name 
order by num_films desc;



-- 4 Which actor has appeared in the most films? 
select * from sakila.actor; 
select * from sakila.film_actor;  
-- select the actor id so they are listed 
-- then rank and order the count of the actor ids in the sakila.film table 
-- then add a count of the actor id column to see if some of the actors appear in the same number of films as others 
select  SA.actor_id, rank() over (order by count(fA.actor_id) desc) as 'actor_rank', count(fA.actor_id) as 'actor_count'
from sakila.actor SA
join sakila.film_actor FA 
on SA.actor_id = FA.actor_id
group by SA.actor_id 
; 

-- teacher  
-- link between the tables is the actor_id
-- select actor.actor_id, actor.first_name, actor.last_name,
-- ount(actor_id) as film_account

 -- ???????????????????????????????????????????????
 -- first get all the information and build from there step by step 
 
 
 select  fa.actor_id ,count(*) as counts 
 from actor a 
 join film_actor fa 
 on a.actor_id = fa.actor_id
 group by fa.actor_id
 order by counts desc
 limit 1;
 
 -- 
 -- use this to see how many times the  
 -- for the below quesiton ?
use sakila; -- fixed the problem  without this it will have an issue with the from clause 
select SC.customer_id,count(SR.customer_id) as 'active customer count'
from sakila.customer SC
join sakila.rental SR
on SC.customer_id = SR.customer_id
group by SC.customer_id 
order by 'active customer count' desc
;

 
 

-- 5 Most active customer (the customer that has rented the most number of films) 
-- customer id rental id ? 
-- you want to count the number of times the customer_id repeates to identify which one has rented the most movies in the rental table 
-- not sure if the select function is correct or its just ranking the 
select * from sakila.customer;
select * from sakila.rental; 
select SC.customer_id, rank() over (order by count(SR.customer_id)desc) as 'active customer count rank',count(SR.customer_id) as 'cutomer count'
from sakila.customer SC
join sakila.rental SR
on SC.customer_id = SR.customer_id
group by SC.customer_id
; 
-- **********************************************************************
-- bonus  
select film.title, count(rental_id) as rental_count
from sakila.film
inner join sakila.inventory using (film_id)
inner join sakila.rental using (inventory_id)
group by film_id
order by rental_count desc
limit 1; 
-- this uses short hand for referencing the join  above  
-- but its best to reference directly so dont do the above but you can try it if you want 
-- so you can recognize it when you see it 

-- ********** you should go over this since joins are super important 

-- no we are going to connect python with mySQL pulling the data so we can look at it in pytho 

