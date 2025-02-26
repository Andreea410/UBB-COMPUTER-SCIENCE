/*
Create a database for Ziua Izabelei
Important entities: Tents, Bands, Caterers, Guests
*/
-- A tent has a name and a color. A tent can serve food from multiple caterers. Tents name are unique.
-- A caterer has a name and an address and a flag if it has a vegetarian menu. A caterer can provide food to multiple tents.
-- A band has a name, a music genre, the fee per show and can sing in only one tent. It also has the start and end time of the show (format HH:MM).
-- A tent can however support multiple bands.
-- A guest has a name, a date of birth and is assigned to a tent.

CREATE TABLE Tents(
	tentID int PRIMARY KEY,
	tentName varchar(50) UNIQUE,
	color varchar(50) NOT NULL
);

CREATE TABLE Carterers(
	cartererID int PRIMARY KEY,
	cartererName varchar(50) NOT NULL,
	cartererAddress varchar(50) NOT NULL,
	flag bit NOT NULL
);

CREATE TABLE TentsCarteres(
	tentID int,
	cartererID int,
	PRIMARY KEY(tentID,cartererID),
	FOREIGN KEY(tentID) REFERENCES Tents(tentID),
	FOREIGN KEY(cartererID) REFERENCES Carterers(cartererID)
);

CREATE TABLE Bands(
	bandID int PRIMARY KEY,
	bandName varchar(50) NOT NULL,
	musicGenre varchar(50) NOT NULL,
	fee decimal(10,2) NOT NULL,
	tentID int,
	FOREIGN KEY(tentID) REFERENCES Tents(tentid)
);

CREATE TABLE Guest(
	guestID int PRIMARY KEY,
	guestName varchar(50) NOT NULL,
	birthday DATE NOT NULL,
	tentID int,
	FOREIGN KEY(tentID) REFERENCES Tents(tentID)
)

--INSERTING DATA
INSERT INTO Tents(tentID,tentName,color) VALUES
(1,'tent1','red'),
(2,'tent2','blue'),
(3,'tent3','black'),
(4,'tent4','red');

INSERT INTO Carterers(cartererID,cartererName,cartererAddress,flag) VALUES
(1,'c1','address1',0),
(2,'c2','address2',1),
(3,'c3','address3',0),
(4,'c4','address4',0);

INSERT INTO TentsCarteres(tentID,cartererID) VALUES
(1,3),
(2,1),
(2,3),
(3,1);

INSERT INTO Bands(bandID,bandName,musicGenre,fee,tentID) VALUES
(1,'band1','jazz',100,1),
(2,'band2','rock',250,2),
(3,'band3','jazz',400,1),
(4,'band4','rap',200,3);

INSERT INTO Guest(guestID,guestName,birthday,tentID) VALUES
(1,'guest1','2024/12/12',1),
(2,'guest2','2024/12/12',1),
(3,'guest3','2024/12/12',2),
(4,'guest4','2024/12/12',3),
(5,'guest5','2024/12/12',4),
(6,'guest6','2024/12/12',2);
GO
-- 2. Create a procedure that receives two tents names N1 and N2. It moves all the guests and bands from tent N1 to N2.
-- It deletes all the relations between the caterers and the tent N1. Then it deletes tent N1.
-- *** observation: suppose tents N1 and N2 already exists, no need to verify

CREATE OR ALTER PROCEDURE moveTent(@N1 varchar(50) , @N2 varchar(50))
AS
BEGIN
	DECLARE @N1ID int
	DECLARE @N2ID int

	SET @N1ID = (SELECT tentID FROM Tents WHERE tentName = @N1)
	SET @N2ID = (SELECT tentID FROM Tents WHERE tentName = @N2)

	UPDATE Guest
	SET tentID = @N2ID
	WHERE tentID = @N1ID

	UPDATE Bands
	SET tentID = @N2ID
	WHERE tentID = @N1ID

	DELETE FROM TentsCarteres WHERE tentID = @N1ID

	DELETE FROM Tents WHERE tentID = @N1ID

END

EXECUTE moveTent 'tent3','tent1' 
SELECT * FROM Tents
SELECT * FROM TentsCarteres
SELECT * FROM Bands
SELECT * FROM Guest
GO
-- 3. Create a view that shows the names of the bands that sing in tents with more than 50 guests.

CREATE OR ALTER VIEW showBands
AS
	SELECT b.bandName as BandName FROM Bands b
	LEFT JOIN Tents t ON b.tentID = t.tentID
	LEFT JOIN Guest g ON g.tentID = t.tentID
	GROUP BY b.tentID , b.bandName
	HAVING COUNT(DISTINCT g.guestID) > 2
GO

SELECT * FROM showBands
GO
-- 4. Create a function that receives T and a providesVegMenu bit. It then shows all the caterers names that provide food for 
-- at least T tents and does/doesn't have a vegetarian menu (depending on the bit).

CREATE OR ALTER FUNCTION getCarterers(@T int ,@providesVegMenu bit)
RETURNS TABLE
AS
RETURN
	SELECT c.cartererName AS CartererName
	FROM Carterers c
	LEFT JOIN TentsCarteres tc ON c.cartererID = TC.cartererID
	WHERE c.flag = @providesVegMenu
	GROUP BY c.cartererName 
	HAVING COUNT(DISTINCT tentID) >= @T 
GO

SELECT * FROM getCarterers(2,0)
