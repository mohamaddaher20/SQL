

/* Create a query that returns only customers who have specified a company */
SELECT *
FROM Customer
WHERE Company != 'NULL';


/* Create a query that returns only tracks that do not specify a composer. ********/
SELECT *
FROM Track
WHERE Composer= NULL;

/* Create a query that returns all tracks that are love songs (ie, contain the word ‘Love’).*/
SELECT *
FROM Track
WHERE Name LIKE '%Love%';

/* Create a query that returns all tracks between 1MB and 2MB in size sorted by largest to smallest size.************/
SELECT *
FROM Track;

/* Create a query that returns the First and last name of customers whose email address is a Canadian (.ca) email address.*/
SELECT *
FROM Customer
WHERE Email LIKE '%ca';

/* Write a query that displays the average amount spent per order in the database. Round the result to two decimal places.
Using your query from 1, modify it so that it displays the average amount of money that each customer has spent in the chinook database
Using your query from (a), modify it so that it only displays customers whose average order amount is greater than 6 dollars.
Sort the results from highest to lowest amounts. */
SELECT FirstName, LastName, Total
FROM Customer
	INNER JOIN Invoice ON customer.customerId = Invoice.customerId
WHERE Total > 6
ORDER BY Total DESC;


/* Write a query that displays the total number of tracks.
Using your query from 2, modify it so that it displays the number of tracks per album.
Using your query from a, modify it so that it displays the number of tracks per artist.
Using your query from b, modify it so that it displays the artist(s) with the most tracks. */


/*Display the track name, genre name, and mediatype name for each track in the database.*/
SELECT Track.Name AS Track, Genre.Name Genre, MediaType.Name AS Mediatype 
FROM Track
	INNER JOIN Genre ON genre.genreId = Track.GenreId
	INNER JOIN MediaType ON MediaType.MediaTypeId = Track.MediaTypeId;


/*Display the first name and last name of each customer along with the name of each track that they have purchased and the date the track was purchased on. 
Sort the results by customer last name, then first name, then name of the track.*/
SELECT FirstName, LastName, InvoiceDate, Track.Name
FROM customer
	INNER JOIN Invoice ON Invoice.CustomerId= Customer.CustomerId
	INNER JOIN InvoiceLine ON InvoiceLine.InvoiceId= InvoiceLine.InvoiceId
	INNER JOIN Track ON Track.TrackId= InvoiceLine.TrackId

/*Display the name of each track along with the name of the album it’s from and the name of the artist who performs it.*/
SELECT Track.Name AS Track, Title AS Album, Artist.Name
FROM Track
	INNER JOIN Album ON album.AlbumId= Track.AlbumId
	Inner join Artist ON artist.ArtistId= Album.ArtistId
