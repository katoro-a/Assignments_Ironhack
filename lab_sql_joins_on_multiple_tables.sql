-- In this lab, you will be using the Sakila database of movie rentals.
-- my attempt 
-- Instructions
	-- 1 Write a query to display for each store its store ID, city, and country. 
-- store , city, country  
	
    -- city id = country id , city id 
	-- contry = country id  
    
-- address = address id , city id   ]
-- store = store id address id 
-- my attempt 
select s.store_id, ci.city, ci.city_id,c.country_id, c.country
from sakila.city ci
join sakila.country c
on ci.country_id = c.country_id
join sakila.address a 
on ci.city_id = a.city_id
join sakila.store s
on a.address_id = s.address_id
; 
-- answer (join on 4 tables) (does the order of the join matter ???) ask 
	-- store 
	-- address , address_id
	-- city  city_id
	-- country country_id 
-- ------------------------------------------------------------------------

	-- 2 Write a query to display how much business, in dollars, each store brought in.
		-- store store id 
        -- staff - store id , staff id 
        -- payment - staff id  
select s.store_id, sum(p.amount)as total 
from sakila.store s
join sakila.staff st
on s.store_id = st.store_id
join sakila.payment p 
on st.staff_id = p.staff_id
group by s.store_id; 

-- answer so look at the id and go to the table with the main key to see if its connected 
	--  tables used :store ,customer ,payment 


-- ----------------------------------------------------------------------
	-- 3 What is the average running time of films by category?  
		-- film - film_id , (length)
        -- film_category - film_id, category i 
        -- category - category id 
select c.category_id, c.name, avg(f.length) as running_time
from sakila.film f
join sakila.film_category fc
on f.film_id = fc.film_id
join sakila.category c
on fc.category_id = c.category_id
group by c.category_id,c.name
;
	-- 4 Which film categories are longest?  
		-- use having or descending on the running_time  
         -- better to use a sum butthe average also works
    select  c.name, avg(f.length) as running_time
from sakila.film f
join sakila.film_category fc
on f.film_id = fc.film_id
join sakila.category c
on fc.category_id = c.category_id
group by c.name  
order by running_time desc
;
	-- 5 Display the most frequently rented movies in descending order.  
		-- film ? -  *film id*
        -- inventory *film id* store id *inventory id*
        -- rental - customer id , rental id , staff_id *inventory id*
		-- payment - customer id  staff id 
        
-- you should have put the title of the film not only the film id 
select f.film_id, count(r.rental_id) as rented_num
from sakila.film f 
join  sakila.inventory i
on f.film_id = i.film_id
join sakila.rental r
on i.inventory_id = r.inventory_id
join sakila.payment p
on r.customer_id = p.customer_id
group by f.film_id
order by rented_num;
    -- film inventory rental 
    
	-- 6 List the top five genres in gross revenue in descending order.
		-- 1 paymennt - customer id (amount), customer id ,staff id ,rental id ,payment id 
        -- 3 custoerm customer id 
        -- 2 film_category -  film id , cateogry id 
-- 	NOT CORRECT NUMBERS ARE NOT THE SAME 
select fc.category_id, sum(p.amount) as revenue
from sakila.film_category fc 
join  sakila.inventory i
on fc.film_id = i.film_id
join sakila.rental r
on i.inventory_id = r.inventory_id
join sakila.payment p
on r.customer_id = p.customer_id 
group by fc.category_id
order by revenue
limit 5;
    -- answer 
		-- category, film_category , inventory , payment
        -- TAKE NOTE OF HOW YOU WRITE YOUR ON'S 
        -- order of the connections does not matter 
        -- ****** connections can be to other tables you already listed *****
select c.name, sum(p.amount) as revenue
from sakila.category c
join sakila.film_category fc
on c.category_id = fc.category_id
join sakila.inventory i 
on i.film_id = fc.film_id
join sakila.rental r 
on r.inventory_id = i.inventory_id
join sakila.payment p 
on p.rental_id = r.rental_id
group by c.name
order by revenue desc;

	-- 7 Is "Academy Dinosaur" available for rent from Store 1? 
    -- inventory store film 
    
    -- try this yourself 
    having = "Academy Dinosaur"  store_id = 1;
    
    -- filter for the inventory id and rank the rental date and filter for null 
    -- the answer given dosnt really give the answer check inventory to see if they have been returned 
    -- the answers to use as reference
    
-- 1
select store_id, city, country
from sakila.store s
join sakila.address a
on s.address_id = a.address_id
join sakila.city c
on c.city_id = a.city_id
join sakila.country co
on  c.country_id = co.country_id;
-- 2
select s.store_id, round(sum(amount), 2)
from sakila.store s
join sakila.customer c
on s.store_id = c.store_id
join sakila.payment p
on c.customer_id = p.customer_id
group by s.store_id;
-- 3
select category.name, avg(length)
from sakila.film join sakila.film_category using (film_id)
                 join sakila.category using (category_id)
group by category.name
order by avg(length) desc;
-- 4
select category.name, avg(length)
from sakila.film join sakila.film_category using (film_id)
                 join sakila.category using (category_id)
group by category.name
order by avg(length) desc;
-- 5
select title, count(*) as `rental frequency`
from sakila.film
join sakila.inventory
on film.film_id = inventory.film_id
join sakila.rental using (inventory_id)
group by title
order by `rental frequency` desc;
-- 6
select name, fc.category_id, sum(amount) as `gross revenue`
from sakila.payment_test p
join sakila.rental r
on p.rental_id = r.rental_id
join sakila.inventory i
on i.inventory_id = r.inventory_id
join sakila.film f
on f.film_id = i.film_id
join sakila.film_category fc
on fc.film_id = f.film_id
join sakila.category  c
on c.category_id = fc.category_id
group by fc.category_id
order by `gross revenue` desc
limit 5;
-- 7
select film.film_id, film.title, store.store_id, inventory.inventory_id
from sakila.inventory
join sakila.store using (store_id)
join sakila.film using (film_id)
where film.title = 'Academy Dinosaur' and store.store_id = 1;    
    
    
    