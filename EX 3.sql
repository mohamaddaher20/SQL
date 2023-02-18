
--Mohamad Taha Daher
--Exercise #3

USE Chinook;

--Add at least one record to the Track table
INSERT INTO Track (Name, UnitPrice, MediaTypeId, Milliseconds)
VALUES ('Mohamad', '6.54', '8', '45');

--Build a query to show how many records are not part of a playlist
SELECT *
FROM Track
LEFT OUTER JOIN PlaylistTrack ON Track.TrackID = PlaylistTrack.TrackId
WHERE PlaylistTrack.PlaylistId is null;

--Display the Name of every available track. In addition, display the number of times that the track has been included as part of an order.
SELECT Name, count(InvoiceLine.invoiceid) as Purchased
FROM Track 
LEFT OUTER JOIN InvoiceLine ON Track.Trackid = InvoiceLine.InvoiceLineId
group by Name 

--Display the TrackID, Track Name, of any tracks in Chinook DB that have not yet been purchased.
SELECT Track.Name, InvoiceID
FROM Track
LEFT OUTER JOIN InvoiceLine ON Track.trackId = InvoiceLine.trackId
WHERE InvoiceId is null;

