-- meet back at 1
-- 3.06 activity 3-4 https://github.com/ironhack-edu/data_3.06_activities   
	-- Activity  3 
		-- The table client has a field birth_number that encapsulates client birthday and sex. 
			-- STEP1 The number is in the form YYMMDD for men, and in the form YYMM+50DD for women, where 
            -- YYMMDD is the date of birth. 
            -- STEP2 Create a view client_demographics with client_id, birth_date 
            -- and sex fields. 
            -- STEP3 Use that view and a CTE to find the number of loans by status and sex.  
				-- group by every dimension 
                -- partition 
				-- ME -create a join to see the loans of the clients 

    select * from bank.client ;
    
    select 
    birth_number,
    substr(birth_number,3, 2), -- create a loop to extract the numbers 
    case 
    when convert(substr(birth_number,3,2),signed integer)>50 -- by extracting the 3 and 2 number from the string to determine gender 
    then "FEM"
    else "MAL"
    end as Gender 
    from bank.client;  
    -- need to create a case statment to calculate the age 
    -- would you make this into another subquery or just add it to the same one that calculates gender ??
    select 
    birth_number,  substr(birth_number,3,2),
    case
    when convert (substr(birth_number,3,2),signed integer) > 50 -- will this work if it in subtring format or will it be unale to subtract beacuse its a sting even though it was an int to begin with ??
    then substr(birth_num,3,2),signed integer)-50
    else birth_number
    from bank.client;
    
    -- have to calculate the birth date by subtractig 50 from the inner 2 num expet for the males and concatinating it back together with the rest of the birth dayte
-- ------------------------------------------------------
select * 
from gender_client 
join bank.loan l
on gender_client.client_id = l.client_id; 
-- ---------------------------------------------------------
	-- client has client disticict id  
    -- account , account id, district id 
    -- loan loan id account id  
-- ***********************************************    
with cte_gender_loan as 
(
 select district_id,
    birth_number,
    substr(birth_number,3, 2), -- create a loop to extract the numbers 
    case 
    when convert(substr(birth_number,3,2),signed integer)>50 -- by extracting the 3 and 2 number from the string to determine gender 
    then "FEM"
    else "MAL"
    end as Gender 
    from bank.client)
select * 
from cte_gender_loan cgl 
join bank.account a 
on cgl.district_id = a.district_id
join bank.loan l 
on a.account_id = l.account_id
; 
    
 with cte_gender_loan as 
(
 select district_id,
    birth_number,
    substr(birth_number,3, 2), -- create a loop to extract the numbers 
    case 
    when convert(substr(birth_number,3,2),signed integer)>50 -- by extracting the 3 and 2 number from the string to determine gender 
    then "FEM"
    else "MAL"
    end as Gender 
    from bank.client)
select *
from cte_gender_loan cgl 
join bank.account a 
on cgl.district_id = a.district_id
join bank.loan l 
on a.account_id = l.account_id
;    
    
    
    -- Activity  4
		-- Select loans greater than the average in their district.  
			-- use a partition by district  
            -- join loan witth district table , account  
with cte_avg_dist as (
select l.account_id, avg(amount) over(partition by district_id) as avg_district, a.district_id,l.amount
from bank.loan l 
join bank.account a   
on l.account_id = a.account_id
join bank.district d 
on a.district_id = d.A1) 
select account_id, district_id, amount
from cte_avg_dist
where amount>avg_district 
;  
-- ***********************************************************************************************************************************************
-- lab  https://github.com/ironhack-labs/lab-sql-advanced-queries 
	-- Lab | SQL Advanced queries
		-- In this lab, you will be using the Sakila database of movie rentals.
			-- Instructions
				-- 1 List each pair of actors that have worked together. 
					-- self join where the film id is the same but the actor id is not ?
				-- For each film, list actor that has acted in more films.    
                -- rank each actor by film 
					-- ME count the film id for the actor to see if its greater than 1 
-- we have done this questio earilier as a self join
-- yu want to remove duplicates using where f1.actor_id<f2.actor_id  
-- have to make a join 2 times to get all the actor names 
select * from sakila.film_actor;  
-- film_id, actor_id 
select *, count(fa1.film_id) over (partition by fa1.actor_id) as number_of_films
from sakila.film_actor fa1
join sakila.film_actor fa2 
on fa1.actor_id <> fa1.actor_id and fa1.film_id = fa2.film_id 
order by fl.film_id 
; 
-- then do a count on the number of films each actor has done with a partition by ?
select *, avg(amount) over(partition by status) as avg_amount


-- answers you need to use temporary tables to complete these as well as better subqueries  
-- LAB Questions  
-- part 
-- part 2
with actor_movies as (
select actor_id, count(film_id) as num_films
from sakila.film_actor -- get the number of films each actor acted in 
group by actor_id
)
select f.title, concat(a.first_name,' ', a.last_name) as best_actor -- get the name of the actor 
from (
select film_id, actor_id, rank() over (-- t starts here 
partition by film_id -- oders the actors by film and how many films they have been in 
order by num_films
desc 
) as m 
from film_actor
inner join actor_movies 
using (actor_id))t -- t ends the subquery 
inner join actor a on t.actor_id = a.actor_id -- get the names of the actors 
inner join film f on t.film_id = f.film_id -- get the name of the film 
where m = 1; -- wherever the rank is one that is the number one actor 
 

create temporary table actor_movies as 
select actor_id, count(film_id) as film_count
from sakila.film_actor
group by actor_id; 

select film_actor.actor_id, film_id,film_count
from sakila.film_actor 
join actor_movies 
on actor_movies.actor_id = film_actor.actor_id
order by film_id
;
-- now you want to rank the above data  
with cte_actor_ranks as (
select film_actor.actor_id, film_id,film_count,
rank() over(partition by film_id order by film_count desc) as rank_actors -- 
from sakila.film_actor 
join actor_movies 
on actor_movies.actor_id = film_actor.actor_id
order by film_id)
select * from cte_actor_ranks
where rank_actors = 1
; 


drop temporary table actor_movies ;
create temporary table actor_movies as
SELECT actor_id , count(film_id) as film_count
FROM sakila.film_actor
group by actor_id;
with cte_actor_ranks as
(
SELECT film_actor.actor_id, film_id, film_count,
rank() over(partition by film_id order by film_count desc) as rank_actors
FROM sakila.film_actor
join actor_movies
on actor_movies.actor_id = film_actor.actor_id
order by film_id
)
select * from cte_actor_ranks
where rank_actors = 1
;
select * from actor_movies ;
                
	
                