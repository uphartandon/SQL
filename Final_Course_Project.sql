USE  mavenmovies;

/* 
1. My partner and I want to come by each of the stores in person and meet the managers. 
Please send over the managers’ names at each store, with the full address 
of each property (street address, district, city, and country please).  
*/ 

-- Solution:

SELECT 
	staff.first_name AS Manager_First_Name,
    staff.last_name AS Manager_Last_Name,
    address.address AS address,
    address.district AS district,
    city.city AS city,
    country.country AS Country
    
from staff
	INNER join address
		ON staff.address_id = address.address_id
	INNER JOIN city
		ON address.city_id = city.city_id
	INNER JOIN country
		ON city.country_Id = country.country_id;



	
/*
2.	I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, 
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost. 
*/

SELECT 
	inventory.store_id AS store_id,
    inventory.inventory_id AS inventory_id, 
    -- film_id
    film.title AS name_of_film,
    film.rating AS film_rating,
    film.rental_rate AS film_rental,
    film.replacement_cost AS replacement_cost

from inventory
	inner join film
		ON inventory.film_id = film.film_id;
	

/* 
3.	From the same list of films you just pulled, please roll that data up and provide a summary level overview 
of your inventory. We would like to know how many inventory items you have with each rating at each store. 
*/
SELECT 
	inventory.store_id AS store_id,
	film.rating AS film_rating,
    count(inventory.inventory_id) AS count_inventory_id
    -- film_id
    -- film.title AS name_of_film,
    
    -- film.rental_rate AS film_rental,
    -- film.replacement_cost AS replacement_cost
from inventory
	inner join film
		ON inventory.film_id = film.film_id
group by  film_rating, store_id;
	












/* 
4. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement cost, 
sliced by store and film category. 
*/ 


SELECT  
	inventory.store_id AS store_id,
	count(inventory.film_id) AS count_of_film,
    category.name AS film_category,
    avg(film.replacement_cost) AS Avg_replacement_cost,
    sum(film.replacement_cost) AS total_replacement_cost
    
from inventory
	INNER JOIN film	
		ON inventory.film_id = film.film_id
	INNER JOIN film_category
		ON inventory.film_id = film_category.film_id
	INNER JOIN category
		ON film_category.category_id = category.category_id
	group by store_id, film_category;









/*
5.	We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, 
and their full addresses – street address, city, and country. 
*/

SELECT 
	customer.first_name AS First_Name,
    customer.last_name AS Last_Name,
    customer.active As active,
    address.address AS customer_address,
    city.city AS city,
    country.country AS cutomer_country_loc
    
from customer
	left join address
		ON customer.address_id = address.address_id
	left Join city
		ON address.city_id = city.city_id
	-- where city.city is null
	Left join country
		ON city.country_id = country.country_id ;


 












/*
6.	We would like to understand how much your customers are spending with you, and also to know 
who your most valuable customers are. Please pull together a list of customer names, their total 
lifetime rentals, and the sum of all payments you have collected from them. It would be great to 
see this ordered on total lifetime value, with the most valuable customers at the top of the list. 
*/
SELECT
	customer.customer_id,
	customer.first_name AS First_Name,
    customer.last_name AS Last_Name,
    count(rental.customer_id) AS lifetime_rental_count,
    sum(payment.amount) AS customer_payment

from customer
	INNER JOIN rental
		ON customer.customer_id = rental.customer_id
	INNER JOIN payment
		ON rental.rental_id = payment.rental_id
	group by customer.customer_id
	order by customer_payment desc;
		
        












    
/*
7. My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table? 
Could you please note whether they are an investor or an advisor, and for the investors, 
it would be good to include which company they work with. 
*/

SELECT 
	first_name,
    last_name,
    'null' as company_name,
    'Advisor' as Type
from advisor
UNION
SELECT 
	first_name,
	last_name,
    company_name,
    'Investor' as Type
FROM investor;









/*
8. We're interested in how well you have covered the most-awarded actors. 
Of all the actors with three types of awards, for what % of them do we carry a film?
And how about for actors with two types of awards? Same questions. 
Finally, how about actors with just one award? 
*/


SELECT
	CASE 
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
		ELSE '1 award'
	END AS number_of_awards, 
    AVG(CASE WHEN actor_award.actor_id IS NULL THEN 0 ELSE 1 END) AS pct_w_one_film
	
FROM actor_award
	

GROUP BY 
	CASE 
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
		ELSE '1 award'
	END

