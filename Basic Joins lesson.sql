use mavenmovies;

-- Joins

-- Inner join

SELECT 
	inventory.inventory_id,
    inventory.store_id,
    film.title,
    film.description
from inventory
Inner join film
on inventory.film_id = film.film_id;

-- Left join

SELECT distinct
	inventory.inventory_id as inven_inven,
    rental.inventory_id as ren_inven
from inventory
	left join rental
		ON inventory.inventory_id = rental.inventory_id;
        
-- Left Join Test

SELECT 
	film_text.title,
    count(film_actor.actor_id) as number_of_actors
from film_text
	left join film_actor
		ON film_text.film_id = film_actor.film_id
group by film_text.title;



-- Bridging unrelated tables

SELECT 
	actor.first_name,
    actor.last_name,
    film.title
    -- film_actor.film_id,
    -- film_actor.actor_id
    
from film_actor
	Left join actor
		ON film_actor.actor_id = actor.actor_id
	left join film
		ON film_actor.film_id = film.film_id;


--  Bridging unrelated tables continued 


SELECT 
		actor.first_name AS first_name,
        actor.last_name AS last_name,
        film.title AS title
from actor		
	INNER JOIN film_actor
		On actor.actor_id = film_actor.actor_id
	INNER JOIN film
		On film.film_id = film_actor.film_id;
        
	-- Multi condition Join
    
    SELECT
		film.film_id,
        film.title,
        film.rating,
        category.name
	from film
		INNER JOIN film_category
			ON film.film_id = film_category.film_id
		INNER JOIN category
			ON film_category.category_id = category.category_id
		AND category.name = 'horror'
		order by film_id;	
        
-- Multi Condition join

SELECT
  distinct film.title AS title,
  film.description AS description
from film
	INNER JOIN inventory
		ON inventory.film_id = film.film_id
        AND inventory.store_id = 2
        
    






       
       