USE Booking
GO	

CREATE OR ALTER PROCEDURE addTable(@tableName varchar(50)) AS
	if @tableName IN
		(SELECT Name FROM Tables)
	BEGIN
	RETURN
	END

	IF @tableName NOT IN
		(SELECT table_name FROM INFORMATION_SCHEMA.TABLES)
	BEGIN
	RETURN
	END

	INSERT INTO Tables(Name) VALUES (@tableName)
GO

----------ADDING THE 3 TABLES ---------------------------------
EXEC addTable 'Client' 
GO

EXEC addTable 'Booking'
GO

EXEC addTable 'LanguagesSpokenByClient'
GO

SELECT * FROM Tables
GO


CREATE OR ALTER PROCEDURE addViews(@viewName varchar(50)) AS
	if @viewName IN
		(SELECT Name FROM Views)
	BEGIN
	RETURN 
	END

	if @viewName NOT IN
		(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS)
	BEGIN
	RETURN
	END

	INSERT INTO Views(Name) VALUES (@viewName)
GO

--CREATING THE 3 VIEWS

CREATE OR ALTER VIEW ClientBookingInfo AS
SELECT 
	c.id AS ClientID,
	c.name AS ClientName,
	c.email AS ClientEmail,
	b.location AS BookingLocation,
	b.capacity AS BookingCapcity
	FROM Client c
	INNER JOIN Booking b ON c.id = b.clientID;
GO

CREATE OR ALTER VIEW ClientLanguages AS
SELECT
	c.id AS ClientID,
	c.name AS ClientName,
	c.email AS ClientEmail,
	l.languageID AS LanguageID
	FROM Client c
	INNER JOIN LanguagesSpokenByClient l ON l.clientID = c.id;
GO


CREATE OR ALTER VIEW BookingClientLanguages AS
SELECT
    b.id AS BookingID,
    b.location AS BookingLocation,
    b.capacity AS BookingCapacity,
    c.id AS ClientID,
    c.name AS ClientName,
    l.languageID AS LanguageID
FROM
    Booking b
INNER JOIN
    Client c ON b.clientID = c.id
INNER JOIN
    LanguagesSpokenByClient l ON c.id = l.clientID;
GO

--ADDING THE VIEWS IN THE VIEWS TABLE
EXEC addViews 'ClientBookingInfo'
GO

EXEC addViews 'BookingClientLanguages'
GO

EXEC addViews 'ClientLanguages'
GO

SELECT * FROM Views
GO

CREATE OR ALTER PROCEDURE addTest(@testName varchar(50)) AS
	IF @testName IN
	(
		SELECT Name 
		FROM Tests
	)
	BEGIN
	RETURN 
	END

	INSERT INTO Tests(Name) VALUES (@testName)
GO

CREATE OR ALTER PROCEDURE addTableTest(@testID int,@tableID int,@noOfRows int,@Position int) AS
	IF @tableID NOT IN
	(
		SELECT TableID FROM Tables)
	BEGIN
	RETURN
	END

	IF @testID NOT IN
	(
		SELECT testID FROM Tests
	)
	BEGIN
	RETURN 
	END

	INSERT INTO TestTables(testID, tableID , NoOfRows,Position) VALUES (@testID,@tableID,@noOfRows,@Position);
GO

CREATE OR ALTER PROCEDURE addViewTest(@testID int , @viewID int) AS
BEGIN
    IF @viewID NOT IN (
        SELECT ViewID FROM Views
    )
    BEGIN
        PRINT 'ViewID not in Views'
        RETURN
    END

    IF @testID NOT IN (
        SELECT testID FROM Tests
    )
    BEGIN
        PRINT 'TestID not in Tests'
        RETURN
    END

    INSERT INTO TestViews(TestID, ViewID) VALUES (@testID, @viewID)
END
GO


CREATE OR ALTER PROCEDURE runTest(@testID int) AS
	IF @testID NOT IN (
		SELECT TestID FROM Tests
	)
	BEGIN
		RETURN 
	END

	DECLARE @testRunId int
	DECLARE @testStartTime dateTime2
	DECLARE @testEndTime dateTime2
	DECLARE @table varchar(50)
	DECLARE @rows int
	DECLARE @pos int
	DECLARE @command varchar(100)
	DECLARE @startTime datetime2
	DECLARE @endTime datetime2
	DECLARE @view varchar(50)

    SET @testRunId = 
		(SELECT MAX(TestRunID)+1  --computes the new unique ID
		FROM TestRuns)
    IF @testRunId IS NULL
        SET @testRunId = 0

	DECLARE tableCursor CURSOR SCROLL FOR
		SELECT T1.name , T2.noOfRows,T2.Position
		FROM Tables T1 JOIN TestTables T2 ON T1.TableID = T2.TableID
		WHERE T2.TestID = @testID
		ORDER BY T2.Position

	DECLARE viewCursor CURSOR FOR
    SELECT V.Name
    FROM Views V JOIN TestViews TV ON V.ViewID = TV.ViewID
    WHERE TV.TestID = @testId

	-- Deleting existing data
	SET @testStartTime = SYSDATETIME()

    -- Open tableCursor before using it
    OPEN tableCursor 
	FETCH LAST FROM tableCursor INTO @table , @rows , @pos -- Start processing from the last table
	WHILE @@FETCH_STATUS = 0 BEGIN -- Continues until no more tables
		EXEC ('DELETE FROM ' + @table) 
		FETCH PRIOR FROM tableCursor INTO @table , @rows , @pos -- Goes into the next table
	END
	CLOSE tableCursor

	-- Inserting into the testRuns
	SET IDENTITY_INSERT TestRuns ON -- Allows setting the unique id
	INSERT INTO TestRuns(TestRunID, Description, StartAt) 
		VALUES (@testRunId, 'Tests results for: ' + CAST(@testID AS VARCHAR(50)), @testStartTime)
	SET IDENTITY_INSERT TestRuns OFF

	-- Populate Tables Dynamically
	-- Open tableCursor again before using it
	OPEN tableCursor
	FETCH tableCursor INTO @table , @rows , @pos
	WHILE @@FETCH_STATUS = 0 BEGIN
		-- Correctly handling dynamic procedure call for table population
		SET @command = 'EXEC populateTable' + @table + ' @rows=' + CAST(@rows AS VARCHAR)
		SET @startTime = SYSDATETIME()
		EXEC(@command) -- Execute dynamic command
		SET @endTime = SYSDATETIME()

		INSERT INTO TestRunTables(TestRunID, TableID, StartAt, EndAt)
			VALUES (@testRunId, (SELECT TableID FROM Tables WHERE Name = @table), @startTime, @endTime)
		FETCH tableCursor INTO @table , @rows , @pos
	END
	CLOSE tableCursor
	DEALLOCATE tableCursor

	-- Run Views
	-- Open viewCursor before using it
	OPEN viewCursor
    FETCH viewCursor INTO @view
    WHILE @@FETCH_STATUS = 0 BEGIN
        SET @command = 'SELECT * FROM ' + @view
        SET @startTime = SYSDATETIME()
        EXEC (@command) -- Execute dynamic SQL for views
        SET @endTime = SYSDATETIME()
        INSERT INTO TestRunViews (TestRunID, ViewID, StartAt, EndAt) 
		VALUES (@testRunId, 
			(SELECT ViewID FROM Views WHERE Name = @view), 
			@startTime, @endTime)
        FETCH viewCursor INTO @view
    END
    CLOSE viewCursor
    DEALLOCATE viewCursor

    UPDATE TestRuns
    SET EndAt = SYSDATETIME()
    WHERE TestRunID = @testRunId


GO

------------------------TEST 1 --------------------------------------------
CREATE OR ALTER PROCEDURE populateTableClient(@rows int) AS
	
	DBCC CHECKIDENT ('Client', RESEED, 0);
	WHILE @rows > 0 
	BEGIN
		INSERT INTO Client(name , email) VALUES('name','email')
		SET @rows = @rows-1
	END
GO


CREATE OR ALTER PROCEDURE populateTableBooking(@rows int) AS
BEGIN
 
    DELETE FROM OwnerBooking;
    DELETE FROM Payment;

    DBCC CHECKIDENT ('OwnerBooking', RESEED, 0);
    DBCC CHECKIDENT ('Payment', RESEED, 0);

    INSERT INTO OwnerBooking(name) VALUES ('name'); -- id = 1
    INSERT INTO Payment(method) VALUES ('cash');    -- id = 1

    
    DBCC CHECKIDENT ('Booking', RESEED, 0);

    WHILE @rows > 0 
    BEGIN
        INSERT INTO Booking(location, capacity, ownerID, clientID, paymentID) 
        VALUES ('location', 2, 1, @rows, 1);
        SET @rows = @rows - 1;
    END
END
GO

EXEC addTest 'test1'
GO

SELECT * FROM Tests
EXEC addTableTest 1 ,1 , 100 , 1
GO
EXEC addTableTest @testID = 1,@tableID = 2, @noOfRows = 100, @Position = 2;
GO
EXEC addViewTest 1, 1; 
GO


SELECT * FROM Views
SELECT * FROM Tables
SELECT * FROM Tests
SELECT * FROM TestViews
SELECT * FROM TestTables
SELECT * FROM Booking
DBCC CHECKIDENT ('Views', RESEED, 0);

EXECUTE runTest 1

SELECT * FROM TestRunTables
GO

------------------TEST 2 -----------------------------------

CREATE OR ALTER PROCEDURE populateTableLanguagesSpokenByClient(@rows INT) AS
BEGIN

	DELETE FROM Language
	INSERT INTO Language (id,provenience, name) VALUES (1,'provenience', 'name');

    WHILE @rows > 0 
    BEGIN
        INSERT INTO LanguagesSpokenByClient (languageID, clientID) 
        VALUES (1, @rows);  -- Adjust according to your needs
        SET @rows = @rows - 1;
    END
END;


EXEC addTest 'test2'
EXEC addTableTest 2,1,1000,1
EXEC addTableTest 2,2,1000,2
EXEC addTableTest 2,3,1000,3
GO

EXEC addViewTest 2, 2; 
GO

EXECUTE runTest 2
SELECT * FROM TestRunTables
GO


--------TEST 3----------------------
EXEC addTest 'test3'
GO

EXEC addTableTest 3,1,200,1
EXEC addTableTest 3,3,200,2
GO

DELETE FROM TestTables WHERE TestID = 3 
DELETE FROM Booking

EXEC addViewTest 3, 3; 
GO

EXECUTE runTest 3
SELECT * FROM TestRunTables
GO





