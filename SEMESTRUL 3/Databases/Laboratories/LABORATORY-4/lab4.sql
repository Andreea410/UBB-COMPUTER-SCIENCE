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

--ADDING THE 3 TABLES
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
	IF @viewID NOT IN(
		SELECT ViewID FROM Views
		)
	BEGIN
		RETURN
	END

	IF @testID NOT IN(
		SELECT testID FROM Tests
		)
	BEGIN
		RETURN
	END

	INSERT INTO TestViews(TestID , ViewID) VALUES (@testID , @viewID)
GO

------------------------TEST 1 --------------------------------------------
CREATE OR ALTER PROCEDURE populateTableClient(@rows int) AS
	DELETE FROM Client
	DBCC CHECKIDENT ('Client', RESEED, 0);
	WHILE @rows > 0 
	BEGIN
		INSERT INTO Client(name , email) VALUES('name','email')
		SET @rows = @rows-1
	END
GO


CREATE OR ALTER PROCEDURE populateTableBooking(@rows int) AS
BEGIN
    DELETE FROM Booking;
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
EXEC addTableTest 2 ,1 , 100 , 1
EXEC addViewTest 2, 1;
GO

SELECT * FROM Views
SELECT * FROM TestViews
SELECT * FROM TestTables






