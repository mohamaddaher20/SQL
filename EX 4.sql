--Mohamad Taha Daher
--Exercise 4

USE Chinook;

--(Chinook DB) Create a query that lists the id and name of all tracks that have not yet been purchased at least once.
--Sort the results by track name in alphabetical order.
SELECT Track.TrackId, Track.Name
FROM Track
LEFT OUTER JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
GROUP BY Track.TrackId, Track.Name
HAVING count(InvoiceLine.InvoiceId) = 0
ORDER BY Name ASC;

--(Chinook DB) Create a query that lists the id and name of all playlists that do not have any tracks assigned to them. Alias the columns appropriately.
SELECT Playlist.PlaylistId, Playlist.Name
FROM Playlist 
LEFT OUTER JOIN PlaylistTrack ON Playlist.PlaylistId = PlaylistTrack.PlaylistId
GROUP BY Playlist.PlaylistId, Name
HAVING count(TrackId) = 0
ORDER BY Name ASC;

--(Numbers db) Using the Multiples_Of_Two and Multiples_Of_Three tables, show the results of a query that only displays numbers that have a matching value in the other
--table. Here’s the catch: You are not permitted to use a WHERE clause or joins for this query.


--(Chinook db) Create a query to find a list of all employees that have never served as a rep for any customers. Both the employee’s first and last names should 
--only be displayed in a single field named “Employee Name”, and include the employee’s job title in your results.
SELECT CONCAT(Employee.FirstName,' ', Employee.LastName) as "Employee Name", Employee.Title
FROM Employee
LEFT OUTER JOIN Customer ON Employee.EmployeeId = Customer.SupportRepId
GROUP BY CONCAT(Employee.FirstName,' ',Employee.LastName), Employee.Title
HAVING count(CustomerId) = 0

--(Multiple DBs) Create a query to gather a list of all first & last names and the country of residence of people living in either Canada or France,
--from the Customer and Employee tables in Chinook and the Person.Person and Person.CountryRegion tables in AdventureWorks.