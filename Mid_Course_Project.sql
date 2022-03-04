use mavenmovies;

/*
1.	We will need a list of all staff members, including their first and last names, 
email addresses, and the store identification number where they work. 

*/ 
SELECT first_name,
		last_name,
        email,
        store_id
from staff;


/*
2.	We will need separate counts of inventory items held at each of your two stores. 

*/ 
	SELECT 
		store_id,
		count(inventory_id) as inventory_items_count
     from inventory
     group by store_id;


/*
3.	We will need a count of active customers for each of your stores. Separately, please. 
*/

SELECT 
	store_id,
    count(customer_id) as Active_customer
from customer
    where active = 1
group by store_id;


/*
4.	In order to assess the liability of a data breach, we will need you to provide a count 
of all customer email addresses stored in the database. 
*/
SELECT distinct 
	count(email) As email_count_database
from  customer;

/*
5.	We are interested in how diverse your film offering is as a means of understanding how likely 
you are to keep customers engaged in the future. Please provide a count of unique film titles 
you have in inventory at each store and then provide a count of the unique categories of films you provide. 
*/

/*SELECT * from inventory;
SELECT 
	distinct(count(name)) As Unique_cat_count
 from category;*/
 
 SELECT 	
		store_id,
		count(distinct(film_id)) AS unique_film
FROM inventory
group by store_id;

/*
6.	We would like to understand the replacement cost of your films. 
Please provide the replacement cost for the film that is least expensive to replace, 
the most expensive to replace, and the average of all films you carry. ``	
*/

SELECT * from film;
SELECT 
	-- replacement_cost,
	-- film_id,
    min(replacement_cost) As least_expensive,
    max(replacement_cost) As most_expensive,
    avg(replacement_cost) As avg_cost
from film;
    







/*
7.	We are interested in having you put payment monitoring systems and maximum payment 
processing restrictions in place in order to minimize the future risk of fraud by your staff. 
Please provide the average payment you process, as well as the maximum payment you have processed.

*/

SELECT 
	avg(amount) AS average_amount,
	max(amount) As Max_payment
  from payment;




/*
8.	We would like to better understand what your customer base looks like. 
Please provide a list of all customer identification values, with a count of rentals 
they have made all-time, with your highest volume customers at the top of the list.
*/

SELECT 
	customer_id,
    count(rental_id) AS count_of_rentals
from rental
group by customer_id
order by count_of_rentals desc




