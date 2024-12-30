USE Zoos

----DROP TABLE IF THEY EXIST
IF OBJECT_ID('Zoos_Animals','U') IS NOT NULL 
DROP TABLE Zoos_Animals;
IF OBJECT_ID('Food_Animals','U') IS NOT NULL 
DROP TABLE Food_Animals;
IF OBJECT_ID('Animals','U') IS NOT NULL 
DROP TABLE Animals;
IF OBJECT_ID('Visits','U') IS NOT NULL 
DROP TABLE Visits;
IF OBJECT_ID('Visitors','U') IS NOT NULL 
DROP TABLE Visitors;
IF OBJECT_ID('Zoos','U') IS NOT NULL 
DROP TABLE Zoos;

----------CREATE TABLES-----------
--Create Animal table
CREATE TABLE Animals(
	id int PRIMARY KEY,
	name varchar(50) NOT NULL,
	birthday DATE NOT NULL
);

ALTER TABLE Animals 
ADD CONSTRAINT unique_constraint UNIQUE(name)

--Create Zoo table
CREATE TABLE Zoos(
	id int PRIMARY KEY,
	administrator varchar(50) NOT NULL,
	name varchar(50) NOT NULL
);

--Create Zoos_Animals table
CREATE TABLE Zoos_Animals(
	zooID INT ,
	animalID int,
	PRIMARY KEY (zooID,animalID),
	FOREIGN KEY (animalID) REFERENCES Animals(id),
	FOREIGN KEY (zooID) REFERENCES Zoos(id)
);

--Create Food table
CREATE TABLE Food(
	id int PRIMARY KEY,
	name varchar(50) NOT NULL
);

--Create Food_Animals table
CREATE TABLE Food_Animals(
	animalID INT ,
	foodID INT ,
	dailyQuota INT NOT NULL,
	PRIMARY KEY(animalID,foodID),
	FOREIGN KEY (animalID) REFERENCES Animals(id),
	FOREIGN KEY (foodID) REFERENCES Food(id)
);

--Create Visitors table
CREATE TABLE Visitors(
	id int PRIMARY KEY,
	name varchar(50) NOT NULL,
	age int NOT NULL
);


--Create Visits table
CREATE TABLE Visits(
	id int PRIMARY KEY,
	dayVisit DATE NOT NULL,
	price DECIMAL(10,2) NOT NULL,
	visitorID int,
	zooID int,
	FOREIGN KEY (visitorID) REFERENCES Visitors(id),
	FOREIGN KEY (zooID) REFERENCES Zoos(id)
);
GO




-----2
--CREATE OR ALTER PROEDURE TO DELETE FOOD DATA FOR A SPECIFIC ANIMAL
CREATE OR ALTER PROCEDURE deleteFood(@animal varchar(50)) AS
BEGIN

	--Verify if animal exists
	IF NOT EXISTS(
		SELECT 1
		FROM Animals
		WHERE name = @animal
	)
	BEGIN
		PRINT 'Animal does not exist';
		RETURN;
	END;

	--Declare variable to store animal's id
	DECLARE @animalID INT

	--Get the animal ID
	SET @animalID=(SELECT id FROM Animals WHERE name = @animal);

	--Delete all food where animal included
	DELETE FROM Food_Animals 
	WHERE animalID = @animalID;

	PRINT 'Food quotas for the specific animal have been deleted'
END;
GO
	
INSERT INTO Animals (id, name, birthday) VALUES (1, 'Lion', '2015-01-01');
INSERT INTO Food (id, name) VALUES (1, 'Meat');
INSERT INTO Food_Animals (animalID, foodID, dailyQuota) VALUES (1, 1, 10);

SELECT * FROM Food_Animals;
EXECUTE deleteFood 'Lion';
GO

----3
--CREATE A VIEW THAT SHOWS THE IDS OF THE ZOOS WITH THE SMALLEST NUMBER OF VISITS

CREATE OR ALTER VIEW minVisitsZoos AS
	SELECT zooID FROM Visits
	GROUP BY zooID
	HAVING COUNT(*) = 
	(
		SELECT MIN(visit_count)
		FROM
		(
			SELECT COUNT(*) AS visit_count FROM Visits
			GROUP BY zooID
		) AS visits_count
	)
GO

SELECT * FROM minVisitsZoos;
GO

--INSERTING DATA TO TEST
INSERT INTO Zoos(id, administrator, name) VALUES
(1, 'Floricica', 'Safari Park'),
(2, 'Maria', 'Jungle World'),
(3, 'Viorel', 'Oceanic Zoo');
INSERT INTO Visitors (id, name, age) VALUES
(1, 'Alice', 25),
(2, 'Bob', 30),
(3, 'Carol', 27),
(4, 'David', 35);
INSERT INTO Visits (id, dayVisit, price, visitorID, zooID) VALUES
(1, '2024-01-01', 20.00, 1, 1),
(2, '2024-01-15', 25.00, 2, 1),
(3, '2024-01-20', 18.00, 3, 2),
(4, '2024-02-05', 22.50, 4, 3),
(5, '2024-02-10', 20.00, 1, 3),
(6, '2024-03-01', 27.00, 2, 3);
GO


--4
CREATE OR ALTER Function getVisitorsWithZoosAtLeastAnimals(@N int)
RETURNS TABLE 
AS
RETURN
(
	SELECT DISTINCT v.visitorID
	FROM Visits v
	INNER JOIN Zoos_Animals za ON v.zooID = za.zooID
	GROUP BY v.visitorID, v.zooID
	HAVING COUNT (za.animalID) >= @n
)
GO

SELECT * FROM getVisitorsWithZoosAtLeastAnimals(3);


INSERT INTO Animals (id, name, birthday) VALUES
(2, 'Elephant', '2012-06-15'),
(3, 'Giraffe', '2018-03-10'),
(4, 'Tiger', '2016-08-05'),
(5, 'Zebra', '2017-05-20'),
(6, 'Penguin', '2019-02-10');

INSERT INTO Zoos_Animals (zooID, animalID) VALUES
(1, 1),  
(1, 2), 
(1, 3),  
(2, 4), 
(2, 5),  
(2, 6),  
(3, 2),  
(3, 6); 




