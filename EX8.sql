--Exercise 8
SELECT * FROM Track;

--look at each trak in the original track table and determine which tracks are greater than 500 thousands.
--If >500k copy the record into the premium table and assign the appropriate rating and price. 
--If <500k leave it in the original table. 
TRANCATE TABLE PremiumTrack;

SELECT * FROM PremiumTrack;

--Track 127 should fall into tier 1
DECLARE @TrackName varchar(200);
DECLARE @Composer varchar(220);
DECLARE @Milliseconds int, @Bytes int, @UnitPrice numeric(10,2); @Rating int, @counter = 1, @MaxTrackId int;

SELECT @MaxTrackId = MAX(TrackId) FROM Track;

WHILE @counter <= @MaxTrackId;
BEGIN

	SELECT @TrackName = Name,
			@Compose = Composer,
			@Milliseconds = Milliseconds,
			@Bytes = Bytes,
	FROM Track WHERE TrackId = @counter;
	SET @Rating = 1;
	SET @UnitPrice = 1.99;

	IF @Milliseconds >= 500000
	BEGIN 
		IF @Milliseconds < 1000000
		BEGIN 
			SET @Rating = 1;
			SET @UnitPrice = 1.99;
		END
		ELSE IF @Milliseconds <2000000
		BEGIN
			SET @Rating = 2;
			SET @UnitPrice = 2.99;
		END
		ELSE IF @Milliseconds <2500000
		BEGIN
			SET @Rating = 3;
			SET @UnitPrice = 3.99;
		END
		ELSE IF @Milliseconds <3000000
		BEGIN
			SET @Rating = 4;
			SET @UnitPrice = 4.99;
		END
		ELSE
		BEGIN
			SET @Rating = 5;
			SET @UnitPrice = 5.99;
		END
		INSERT INTO PremiumTrack (Name, Composer,Milliseconds, Bytes, UnitPrice, Rating)
		VALUES(@TrackName, @Composer, @Milliseconds, @Bytes, @UnitPrice, @Rating);
	END
	SET @counter += 1;
END