#Tech Check #4

#Name: Mohamad Taha Daher
#W#: 0459521

USE sakila;

#Query 1
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE 'G%'
ORDER BY first_name ASC;

#Query 2
SELECT name AS "Language"
FROM language
ORDER BY name ASC;

#Query 3
SELECT address, phone
FROM address
WHERE district='California'
ORDER BY phone DESC;

#Query 4
SELECT DISTINCT rating
FROM film
ORDER BY rating;#ASC;

#Query 5
SELECT first_name,last_name,username, password
FROM staff
WHERE first_name='Mike' AND last_name='Hillyer';

