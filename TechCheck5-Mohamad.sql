#Name: Mohamad Taha Daher
#Tech Check # 5

USE sakila;

# Query 1- Write a query that returns the film ID, title and language for all films with a rating of PG-13.
# Rename columns as indicated.
SELECT film_id, title AS Movies, name AS language
FROM film
    INNER JOIN language ON film.language_id = language.language_id
WHERE rating='PG-13';

# Query 2- Write a query that displays the CustomerID and total amount of all payments that customer 47
# made for movies they rented in the month of August. Rename columns as indicated. (Hint: Month() function)
SELECT customer.customer_id, SUM(all amount) AS "Total$ -August Rentals"
FROM customer
    INNER JOIN rental ON customer.customer_id = rental.customer_id
    INNER JOIN payment ON rental.rental_id = payment.rental_id
WHERE Customer.customer_id=47 AND month(rental_date)=8
GROUP BY payment.customer_id;

# Query 3- Write a query that returns the number of payments received by each staff member.
# Display the staff ID and last name, and how many payments they received. Rename columns as indicated.
SELECT staff.staff_id, last_name AS StaffName, COUNT(all amount) AS "Num of payment By staff"
FROM staff
    INNER JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id;

# Query 4- Write a query that displays a list of each actor, movie name and movie category for all movies with a category of Animation.
# Sort by actor last name and movie title. Rename columns as indicated.
SELECT first_name, last_name, title AS Movies, name AS Category
FROM actor
    INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
    INNER JOIN film ON film_actor.film_id = film.film_id
    INNER JOIN film_category ON film.film_id = film_category.film_id
    INNER JOIN category ON film_category.category_id = category.category_id
WHERE name='Animation'
ORDER BY last_name, title ASC;

# Query 5- Write a query to display the first and last names (in a single field), the address, city and country for all customers from Germany.
# Sort by city in reverse alphabetical order. Rename columns as indicated.
SELECT CONCAT(first_name, last_name) AS CustomerName, address, city, country
FROM customer
    INNER JOIN address ON customer.address_id = address.address_id
    INNER JOIN city ON address.city_id = city.city_id
    INNER JOIN country ON city.country_id = country.country_id
WHERE country='Germany'
ORDER BY city DESC;
