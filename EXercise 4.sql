--(Chinook DB) Create a query that lists the id and name of all tracks that have not yet been purchased at least once.  
--Sort the results by track name in alphabetical order.
SELECT Track.TrackId, Track.Name
FROM Track
LEFT OUTER JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
WHERE InvoiceLineId is NULL
ORDER BY Name ASC;

--(Chinook DB) Create a query that lists the id and name of all playlists that do not have any tracks assigned to them. 
--Alias the columns appropriately.
SELECT playlist.PlaylistId, playlist.Name 
FROM Playlist
LEFT OUTER JOIN PlaylistTrack ON Playlist.PlaylistId = PlaylistTrack.PlaylistId
WHERE TrackId is NULL;

--(Numbers db) Using the Multiples_Of_Two and Multiples_Of_Three tables, show the results of a query that only displays numbers 
--that have a matching value in the other table. Here?s the 
--catch: You are not permitted to use a WHERE clause or joins for this query.
USE NumbersDB;
SELECT Twos FROM NumbersDB.dbo.Multiples_Of_Two
INTERSECT
SELECT Threes FROM NumbersDB.dbo.Multiples_Of_Three

--(Chinook db) Create a query to find a list of all employees that have never served as a rep for any customers. Both the 
--employee?s first and last names should only be displayed in a single field named ?Employee Name?, and include the employee?s 
--job title in your results.
USE Chinook;
SELECT employee.FirstName, employee.LastName, employee.Title
FROM Employee
LEFT OUTER JOIN Customer ON Customer.SupportRepId= Employee.employeeId
WHERE customerId is NULL;