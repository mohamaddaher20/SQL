--Mohamad Taha Daher 
--Assignment #1

USE CHINOOK;

--Query 1
--(Chinook db) Display the First Name, Last Name of each customer along with the First Name and Last Name of
--their support rep,sorted by customer last and first names. Give the support rep columns an appropriate alias. (59 records)
SELECT Customer.FirstName, Customer.LastName, CONCAT(Employee.FirstName, ' ',  Employee.LastName) AS 'Representative'
FROM Customer
	INNER JOIN Employee ON Customer.SupportRepId = Employee.EmployeeId
	ORDER BY Customer.LastName, Customer.FirstName ASC; 

--Query 2
--(Chinook db) Display the track name, genre name, and mediatype name for each track in the database,
--sorted by track name. (3503 records)
SELECT Track.Name AS 'Track Name', Genre.Name AS 'Genre', Mediatype.Name AS 'Mediatype'
FROM Track
	INNER JOIN Genre ON Track.GenreId = Genre.GenreId
	INNER JOIN MediaType ON Track.MediaTypeId = MediaType.MediaTypeId
	ORDER BY Track.Name ASC;

--Query 3
--(Chinook db) Display the name of every artist and the total number of albums each artist has available for sale.
--Results should show the highest totals first. (275 records)
SELECT Artist.Name, COUNT(Album.Title) AS 'Number Of Albums'
FROM Artist
	LEFT JOIN Album ON Artist.ArtistId = Album.ArtistId
	GROUP BY Artist.Name
	ORDER BY "Number Of Albums" DESC;

--Query 4
--(Chinook db) Display the first name and last name of each customer along with a unique list of the types of media that
--they have purchased. (128 records)
SELECT DISTINCT Customer.FirstName,Customer.LastName, MediaType.Name AS 'MediaType'
FROM Customer
	INNER JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
	INNER JOIN InvoiceLine ON Invoice.InvoiceId = InvoiceLine.InvoiceId
	INNER JOIN Track ON InvoiceLine.TrackId = Track.TrackId
	INNER JOIN MediaType ON Track.MediaTypeId = MediaType.MediaTypeId

--Query 5
--(Chinook db) Display the first name and last name of the single customer who has purchased the most 
--video tracks. (1 record)
SELECT TOP 1 Customer.FirstName, Customer.LastName
FROM Customer
	INNER JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
	INNER JOIN InvoiceLine ON Invoice.InvoiceId = InvoiceLine.InvoiceId
	INNER JOIN Track ON InvoiceLine.TrackId = Track.TrackId
	INNER JOIN MediaType ON Track.MediaTypeId = MediaType.MediaTypeId
	WHERE MediaType.Name LIKE '%Video%'
	GROUP BY Customer.FirstName, Customer.LastName 
	ORDER BY count(MediaType.Name) desc;

--Query 6
--(Chinook db) Display the name of the artist and number of orders for the single artist who has had the highest number 
--orders of his/her music placed. (1 record)
SELECT TOP 1 Artist.Name, COUNT(InvoiceId) "Number of Orders"
FROM Artist
	INNER JOIN Album ON Artist.ArtistId = Album.ArtistId
	INNER JOIN Track ON Album.AlbumId = Track.AlbumId
	INNER JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
	GROUP By Artist.Name
	order by count(InvoiceId) desc;

--Query 7
--(Chinook db) Display the TrackID and Track Name of any tracks that have not yet been purchased. (1519 records)
SELECT Track.TrackId, Track.Name AS 'Track Name'
FROM Track
	LEFT JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
	WHERE InvoiceId IS NULL;

---------------------------------------------------------------------------------------------------------------------------------
USE Bookstore;

--Query 8
--(Bookstore db) Using the “b_” tables, display the first and last names of all authors who currently do not
--have any books listed, sorted author last/first name. (2 records)
SELECT LName, FName
FROM B_AUTHOR
	LEFT OUTER JOIN B_BOOKAUTHOR ON B_AUTHOR.AuthorID = B_BOOKAUTHOR.AUTHORid
	WHERE ISBN IS NULL
	ORDER BY LName, FName ASC;

--Query 9
--(Bookstore db) Using the “b_” tables, display the Customer number, First name, and Last name of any customers who have
--yet to place an order, sorted customer last/first name. (6 records)
SELECT B_Customers.Customer#, FirstName, LastName
FROM B_CUSTOMERS
	LEFT JOIN B_ORDERS ON B_Customers.Customer# = B_ORDERS.Customer#
	WHERE Order# IS NULL
	ORDER BY LastName, FirstName ASC;

--------------------------------------------------------------------------------------------------------------------------------
USE CarsDB;

--Query 10
--(Cars db) Using the Cars_Car_Types, Cars_Number_Of_Doors and Cars_Colors tables, create a query that returns every 
--possible combination of the values of each table. (Hint: The result set should contain 24 rows.)
SELECT CAR_TYPE, COLOR, DOORS 
FROM CARS_CAR_TYPES
	CROSS JOIN CARS_COLORS 
	CROSS JOIN CARS_NUMBER_OF_DOORS;

----------------------------------------------------------------------------------------------------------------------------------
USE LunchesDB;

--Query 11
--(Lunches db) List the employee ID, last name, and phone number of each employee with the name and phone number of 
--his or her manager. Make sure that every employee is listed, even those that do not have a manager. 
--Sort by the employee’s id number. (10 records)
SELECT e1.Employee_Id, e1.Last_Name, e1.Phone_Number, e2.FIRST_NAME, e2.LAST_NAME, E2.PHONE_NUMBER
FROM L_EMPLOYEES e1
LEFT JOIN L_EMPLOYEES e2 ON e1.MANAGER_ID = e2.EMPLOYEE_ID
ORDER BY e1.EMPLOYEE_ID

----------------------------------------------------------------------------------------------------------------------------------
--Query 12
--(Multiple dbs) Create one full list of first names and last names of all customers from the Chinook tables, 
--all authors from the Bookstore tables, all customers from the Bookstore tables, and all employees from the Lunches tables.
--Sort the list by last name and first name in ascending order. (103 records) 	*** See note about this query below rubric ***

--NOTE*SELECT GenreID COLLATE DATABASE_DEFAULT, Name COLLATE DATABASE_DEFAULT FROM Genre;

SELECT FirstName COLLATE DATABASE_DEFAULT AS 'FirstName', LastName COLLATE DATABASE_DEFAULT AS 'LastName' FROM Chinook.dbo.Customer
UNION ALL 
SELECT Fname COLLATE DATABASE_DEFAULT, Lname COLLATE DATABASE_DEFAULT FROM Bookstore.dbo.B_AUTHOR 
UNION ALL
SELECT FirstName COLLATE DATABASE_DEFAULT, LastName COLLATE DATABASE_DEFAULT FROM Bookstore.dbo.B_CUSTOMERS 
UNION ALL
SELECT First_Name COLLATE DATABASE_DEFAULT, Last_Name COLLATE DATABASE_DEFAULT FROM LunchesDB.dbo.L_EMPLOYEES
ORDER BY LastName COLLATE DATABASE_DEFAULT, FirstName COLLATE DATABASE_DEFAULT ASC;

----------------------------------------------------------------------------------------------------------------------------------
USE NumbersDB;

--Query 13
--(Numbers db) Using the Numbers_Twos and Numbers_Threes tables, show the results of a query that only displays numbers
--that do not have a matching value in the other table. (51 records)
SELECT Threes, Twos
FROM Multiples_Of_Two
	FULL OUTER JOIN Multiples_Of_Three ON Multiples_Of_Two.Twos = Multiples_Of_Three.Threes
	WHERE Twos IS NULL OR Threes IS NULL;

--Query 14
--(Numbers db) Using the Numbers_Twos and Numbers_threes tables, show the results of a query that only displays numbers
--that have a matching value in the other table. Here’s the catch: You are not permitted to use a WHERE clause or JOINs 
--for this query. (17 records) **NOTE: I got 16 results instead of 17 because of one of the exercises.  
SELECT TWOS FROM NumbersDB.dbo.Multiples_Of_Two
INTERSECT
SELECT THREES FROM NumbersDB.dbo.Multiples_Of_Three

---------------------------------------------------------------------------------------------------------------------------------
