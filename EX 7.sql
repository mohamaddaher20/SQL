--Mohamad Taha Daher
--Exercise 7

--1
--Start off by writing a SELECT query to show all artists and their associated albums. Your results 
--should include both artists WITH associated albums and artists WITHOUT albums.
SELECT Artist.Name, Title, Artist.ArtistId
FROM Artist
	LEFT OUTER JOIN Album ON Artist.ArtistId = Album.ArtistId
ORDER BY Name

--2
--From the resulting data, choose two artists, one with at least one associated album, and the second 
--with no associated albums. Make note of each artist’s name and Artist ID.
--ArtistId = 184 , Artist Name = Rodox , Album= NULL
--ArtistId = 124 , Artist Name = R.E.M , Album= Green

--3
--First, for the artist with NO albums, use transactions and error handling structures to:
--Attempt to delete the artist.
--If no errors occur (which should be the case), commit the action.
--If an error occurs, use error-handling techniques to display all relevant error information in the Results window.
--If an error occurs, the delete attempt should be reverted.
--Note: This delete should work, since it doesn’t break any FK constraints.
BEGIN TRANSACTION
BEGIN TRY
	DELETE FROM Artist WHERE artistId = 184;
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrorNumber,		
	      ERROR_SEVERITY() AS ErrorSeverity,	
	      ERROR_STATE() AS ErrorState,			
	      ERROR_PROCEDURE() AS ErrorProcedure,	
	      ERROR_LINE() AS ErrorLine,			
	      ERROR_MESSAGE() AS ErrorMessage
		  IF @@TRANCOUNT > 0
			ROLLBACK;
END CATCH
	IF @@TRANCOUNT > 0
		COMMIT;
GO

--4
--Write a simple SELECT query to verify whether the artist record was deleted and committed.
SELECT Name, ArtistId
FROM Artist					--It got deleted 
WHERE Name = 'Rodox';

--5
--Next, using your artist that DOES have associated album(s), use transactions and error handling to:
--Attempt to delete the artist.
--If no errors occur, commit the action.
--If an error occurs, (which it should!) use error-handling techniques to display all relevant error information in the Results window.
--If an error occurs, the delete attempt should be reverted.

BEGIN TRANSACTION
BEGIN TRY
	DELETE FROM Artist WHERE ArtistId= 124;
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrorNumber,		
	      ERROR_SEVERITY() AS ErrorSeverity,	
	      ERROR_STATE() AS ErrorState,			
	      ERROR_PROCEDURE() AS ErrorProcedure,	
	      ERROR_LINE() AS ErrorLine,			
	      ERROR_MESSAGE() AS ErrorMessage
		  IF @@TRANCOUNT > 0
			ROLLBACK;
END CATCH
	IF @@TRANCOUNT > 0
		COMMIT;
GO

--6
--View the error data that should have been displayed when you ran the code from step 5.
--Error Number: 547
--ErrorSeverity: 16
--ErrorState: 0
--ErrorProcedure: NULL
--ErrorLine: 3
-- ErrorMessage:The DELETE statment conflicted with the REFERENCE

--7
--Write another simple SELECT query to verify that the artist record was NOT deleted (ie. Was rolled back).
SELECT ArtistId, Name
FROM Artist
WHERE ArtistId = 124;

--8
--Finally, let’s see some error throwing, both with and without custom errors.

--9
--FIRST ATTEMPT
BEGIN TRANSACTION
BEGIN TRY
	DELETE FROM Artist WHERE ArtistId= 124;
END TRY
BEGIN CATCH
		  IF @@TRANCOUNT > 0
			ROLLBACK;
END CATCH
	IF @@TRANCOUNT > 0
		COMMIT;
GO
--Nothing happened- no message

--SECOND ATTEMPT WITH THE THROW
BEGIN TRANSACTION
BEGIN TRY
	DELETE FROM Artist WHERE ArtistId= 124;
END TRY
BEGIN CATCH
	THROW
		  IF @@TRANCOUNT > 0
			ROLLBACK;
END CATCH
	IF @@TRANCOUNT > 0
		COMMIT;
GO
--I got the error message
--Msg 547, Level 16, State 0, Line 110
--The DELETE statement conflicted with the REFERENCE constraint "FK_AlbumArtistId". The conflict occurred in database "Chinook", table "dbo.Album", column 'ArtistId'.

--THIRD ATTEMPT
BEGIN TRANSACTION
BEGIN TRY
	DELETE FROM Artist WHERE ArtistId= 124;
END TRY
BEGIN CATCH
	THROW 12345, 'This is my custom error', 1
		  IF @@TRANCOUNT > 0
			ROLLBACK;
END CATCH
	IF @@TRANCOUNT > 0
		COMMIT;
GO
--I did not got the error