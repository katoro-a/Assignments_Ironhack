-- activity 3.03 act 1,3,4 (45min) 
	-- Keep working on the bank database.
	-- Let's find for each account an owner and a disponent.  
    -- its the same query that we did before  
    
select * 
from bank.disp d1
join bank.disp d2
on d1.account_id = d2.account_id
and d1.type <> d2.type
where d1.type = 'DISPONENT' and d1.type <> d2.type;    

select d1. type, d2.type, d1.account_id, d2.account_id
from bank.disp d1
join bank.disp d2
on d1.account_id = d2.account_id  
and d1.client_id = d2.client_id
where d1.type = 'DISPONENT'
;

 
 -- question 3 https://www.mysqltutorial.org/mysql-cross-join/
	-- notes
    -- cross joins, if you had n and x rown is would be n*x rows total 
		-- this means it returns a cartesian product of rows from the joined tables 
	-- a cross join does not have the on or using clause that regular joins have 
    -- a cross join will act as an inner join when you use an inner clause 
		-- ex select * from t1 
        -- cross join t2
        -- where t1.id = t2.id; - this clause makes it act like an inner join 
-- QUESTION 4 THINK ABOUT THE POSSIBLE USES FOR CROSS JOIN QUERIES 
	-- happen between 2 different tables 
    -- make a combination of all the rows in one with all the rows in the other 
		-- get all the combinations of an item ie size and color of clothing 
        -- generate data for testing ?

-- LAB SQL SELF AND CROSS JOINS , sql self and cross join all 3 questions 
	-- 1 Get all pairs of actors that worked together.   
    
-- answer by teacher, make 2 temporary tables and combine 
drop temporary table if exists x1;
drop temporary table if exists x2; 

create temporary table x1
select  fa.film_id,concat(a.first_name," ", a.last_name) as name 
from sakila.film_actor fa
join sakila.actor a 
on a.actor_id = fa.actor_id;
-- need to create table for x2 
create temporary table x2
select; -- look at screen shot and then test



select * 
from x1
join x2
on x1.film_id=x2.film_id; 

-- another way to do it is without the tables and just makeing a bunch of joins
-- check screen shots *** do right after class or on sunday 
    
#drop temporary table if exists Actor_ids_1;
#create temporary table Actor_ids_1

create temporary table actors_A
select f.film_id, fa.actor_id
from sakila.film f
join sakila.film_actor fa
on f.film_id = fa.film_id  
;  
select * from actors_A;
-- self join  
-- store result then get actor names 
select f1.actor_id, f2.actor_id,f1.film_id
from sakila.film_actor f1
join sakila.film_actor f2
on f1.film_id = f2.film_id
and f1.actor_id <> f2.actor_id;

create temporary table sakila.actors_films
select f1.actor_id as id_1, f2.actor_id as id_2,f1.film_id
from sakila.film_actor f1
join sakila.film_actor f2
on f1.film_id = f2.film_id
and f1.actor_id <> f2.actor_id;  
 
select * from sakila.actors_films; 
 
select af.id_1,af.id_2, a.first_name, a.last_name, a2.first_name, a2.last_name
from sakila.actors_films af
join sakila.actor a
on af.id_1 = a.actor_id
join sakila.actor a2
on af.id_2 = a2.actor_id;





-- or should we be using a cross join with film_actor =film_id ?

	-- 2 Get all pairs of customers that have rented the same film more than 3 times.
	-- self join? 
    -- base it off of inventory id ? to know if its bee
select * 
from sakila.rental r1
join sakila.rental r2
on r1.inventory_id = r2.inventory_id
; 

select r1.rental_id, r1.inventory_id
from sakila.rental r1
join sakila.rental r2
on r1.inventory_id = r2.inventory_id
where r1.inventory_id >3 and r1.customer_id>3; 

-- teacher answer 
-- first find all the ppl that rented the movie mroe than 3 times 
create temporary table morefilms 
select customer_id, count(*) as counts 
from sakila.rental 
group by customer_id 
having counts>3; 

select * from morefilms; -- shows all the ppl who rented a film more than 3 times 
-- DONT UNDERSTAND THE FIRST PART WHERE IT ASKS FOR THE PAIRS 


select * from moreFilms f1
join (select customer_id, count(*) as counts from rental 
group by customer_id
having counts>3) f2
on f1.customer_id<> f2.customer_id; 




-- 3 Get all possible pairs of actors and films. 
	-- use a cross join for this one not a self since its between 2 different tables 
select  a.actor_id, fa.actor_id, fa.film_id
from sakila.actor a
cross join sakila.film_actor fa
on a.actor_id = fa.actor_id
;
-- have to join 2 tables then do a cross join 
-- dont usually need a primary key or foreign key 

# all possible pairs means its a cross join  
select concat(a.first_name,' ', a.last_name) as actor_name,
f.title 
from sakila.actor a
cross join sakila.film as f;














