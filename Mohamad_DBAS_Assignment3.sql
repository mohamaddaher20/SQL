# Name: Mohamad Taha Daher
# W#: 0459521

# Assignment 3 SELECT Queries, Aggregates and JOINS

USE sakila;

# Query 1 - Create a query that returns all film titles in alphabetical order for the language with ID = 1.
SELECT title
FROM film
WHERE language_id= 1
ORDER BY title ASC;

# Query 2 - Create a query that will list all the film titles containing the word “Drama” in the description. (You need only to accommodate the displayed spelling of the word.)
SELECT title
FROM film
WHERE description like '%Drama%';

# Query 3 - Create a query that lists all films with the ratings 'G', 'PG, and 'PG-13' and also do not have an original language ID.Build the query to check for all conditions, regardless of the data. Sort the results alphabetically by rating, then title.
SELECT title, rating
FROM film
WHERE rating='G' OR rating='PG' OR rating='PG-13' AND original_language_id is null
ORDER BY rating,title ASC;

# Query 4 - Create a query that lists all cities who have 'Canada' as a country.  Build the query as if you do not know Canada's country id.Hint: Remember you can have selects within select queries. Sort the results reverse alphabetically by city name.
SELECT city
FROM city
WHERE country_id=(select country_id from country where country='Canada')
ORDER BY city DESC;

# Query 5 - Create a query that returns all films that either start with the letter ‘A’, or end with the letter ‘t’.Suppress any duplicate film names and sort the results in reverse alphabetical order.
SELECT DISTINCT title
FROM film
WHERE title like 'A%' OR title like '%T'
ORDER BY title DESC;

# Query 6 - Create a query that returns each customer ID and the count of payments they have made. Make sure you call the second column "count". Sort results by count in reverse order.
SELECT customer_id, count(all amount) AS Count
FROM payment
GROUP BY customer_id
ORDER BY count DESC;

# Query 7 - Create a query that lists the CategoryId and count of films (name this column Cat_Count).
# Restrict your results to only those categories with more than 60 films. Sort the results by the Category Count in descending order.
SELECT category_id, COUNT(all film_id) AS Cat_Count
FROM film_category
GROUP BY category_id
HAVING Cat_Count >60
ORDER BY Cat_Count DESC;

# Query 8 - Create a query that displays the total of films are not in inventory. Call the single column "Total Not In Inventory".
SELECT count(film_id) AS "Total Not In Inventory"
FROM film
WHERE not exists(select film_id from inventory
WHERE inventory.film_id =film.film_id);

# Query 9- Create a query that displays a list of all cities and their associated countries, alphabetized by country
SELECT city, country
FROM country
    INNER JOIN City ON country.country_id = city.country_id
ORDER BY country ASC;

# Query 10- Create a query that displays the names of every actor and the number of movies they are in. Display the actor's last and first names and sort from most movies to least. Rename columns as indicated.
SELECT last_name AS LastName, first_name AS FirstName, count(DISTINCT film_id) AS Num_of_Movies
FROM actor
    INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id order by Num_of_Movies DESC;

# Query 11- Create a query that displays a list of all customers who currently reside in Japan. Show their last and first names, city and country, sorted by city of residence, then by customer last name, first name.
SELECT customer_id, last_name, first_name, city, country
FROM country
    INNER JOIN City ON country.country_id = city.country_id
    INNER JOIN Address ON city.city_id = address.city_id
    INNER JOIN Customer ON address.address_id = customer.address_id
WHERE country='Japan';

# Query 12- Create a query that lists all G-rated movies in which actress Audrey Olivier has appeared. Display the actress' name in a single field named ActorName. Rename other columns as indicated.

SELECT CONCAT(last_name,',',' ',first_name) AS ActorName, title AS Movie, rating AS MovieRating
FROM actor
    INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
    INNER JOIN film ON film_actor.film_id = film.film_id
WHERE rating= 'G' AND (last_name='Olivier' and first_name='Audrey');

# Query 13- Create a query that displays which and how many movies are available for rental from store #1, that have an R  rating, are 2 hours or less in run time, and that include deleted scenes as a special feature. Sort by movie length, from shortest to longest. Rename the Available column as indicated.
SELECT title, count(all inventory_id) AS "Num Availabel", rating, length, special_features
FROM film
    INNER JOIN inventory ON film.film_id = inventory.film_id
WHERE store_id= 1 AND rating='R' AND length <= 120 AND special_features like '%Deleted Scenes%'
GROUP BY title ORDER BY length ASC;

# Query 14- Create a query that displays all movies from the Action or Comedy categories that were rented by Canadian customers, sorted by movie title. Display the name of the rented movie, its category, the customer's name as a single field and the country.Rename columns as indicated.
SELECT title AS MovieRented, name AS Category, CONCAT(first_name,'',last_name) AS Customer, country
FROM film
    INNER JOIN film_category ON film.film_id = film_category.film_id
    INNER JOIN category ON film_category.category_id = category.category_id
    INNER JOIN inventory ON film.film_id = inventory.film_id
    INNER JOIN Rental ON inventory.inventory_id = rental.inventory_id
    INNER JOIN Payment ON rental.rental_id = payment.rental_id
    INNER JOIN customer ON payment.customer_id = customer.customer_id
    INNER JOIN address ON customer.address_id = address.address_id
    INNER JOIN city ON address.city_id = city.city_id
    INNER JOIN country ON city.country_id = country.country_id
WHERE (name= 'Action' OR name='comedy') AND country='Canada'
ORDER BY MovieRented ASC;

# Query 15- Create a query that displays how many movies were rented by customer Ruby Washington, listed by category. Display the customer's last and first names, the category and how many movies from each category were rented by this customer. Sort by category, then by customer last name. Rename columns as indicated.
SELECT last_name AS LastName, first_name AS FirstName, name AS Category, count(title) AS "Num Rented"
FROM film
    INNER JOIN film_category ON film.film_id = film_category.film_id
    INNER JOIN category ON film_category.category_id = category.category_id
    INNER JOIN inventory ON film.film_id = inventory.film_id
    INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
    INNER JOIN customer ON rental.customer_id = customer.customer_id
WHERE last_name ='Washington' AND first_name='Ruby'
GROUP BY category
ORDER BY Category, LastName ASC;


