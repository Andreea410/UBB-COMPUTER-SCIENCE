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
IF OBJECT_ID('Food','U') IS NOT NULL 
DROP TABLE Food;

----------CREATE TABLES-----------
--Create Animal table
CREATE TABLE Animals(
	aid int PRIMARY KEY,
	aname varchar(50),
	birthday DATE
)

CREATE TABLE Zoos(
	zid int PRIMARY  KEY,
	administrator varchar(50),
	zname varchar(50),
)

CREATE TABLE ZoosAnimals(
	id int PRIMARY KEY,
	zoo_id int ,
	animal_id int,
	FOREIGN KEY(zoo_id) REFERENCES Zoos(zid),
	FOREIGN KEY(animal_id) REFERENCES Animals(aid)
);

CREATE TABLE Food(
	fid int PRIMARY KEY,
	fname varchar(50)
)

CREATE TABLE FoodAnimals(
	id int PRIMARY KEY,
	food_id int ,
	animal_id int,
	quota int,
	FOREIGN KEY(food_id) REFERENCES Food(fid),
	FOREIGN KEY(animal_id) REFERENCES Animals(aid)
);

CREATE TABLE Visitor(
	vid int PRIMARY KEY,
	vname varchar(50),
	vage int
)

CREATE TABLE Visits(
	visitID int PRIMARY KEY,
	visit_day int,
	price int,
	visitor_id int,
	zoo_id int,
	FOREIGN KEY(zoo_id) REFERENCES Zoos(zid),
	FOREIGN KEY(visitor_id) REFERENCES Visitor(vid)
)
GO

-- Insert data into Animals
INSERT INTO Animals (aid, aname, birthday) 
VALUES 
(1, 'Elephant', '2005-05-15'),
(2, 'Tiger', '2010-11-20'),
(3, 'Giraffe', '2012-03-03'),
(4, 'Panda', '2018-06-01');

-- Insert data into Zoos
INSERT INTO Zoos (zid, administrator, zname) 
VALUES 
(1, 'John Smith', 'Safari Park'),
(2, 'Alice Johnson', 'Rainforest Zoo'),
(3, 'Mike Brown', 'Arctic Wildlife');

-- Insert data into ZoosAnimals
INSERT INTO ZoosAnimals (id, zoo_id, animal_id)
VALUES 
(1, 1, 1),
(2, 1, 2),
(3, 2, 3),
(4, 3, 4);

-- Insert data into Food
INSERT INTO Food (fid, fname)
VALUES 
(1, 'Bananas'),
(2, 'Meat'),
(3, 'Grass'),
(4, 'Bamboo');

-- Insert data into FoodAnimals
INSERT INTO FoodAnimals (id, food_id, animal_id, quota)
VALUES 
(1, 1, 1, 50),
(2, 2, 2, 30),
(3, 3, 3, 60),
(4, 4, 4, 40);

-- Insert data into Visitor
INSERT INTO Visitor (vid, vname, vage)
VALUES 
(1, 'Emily Davis', 25),
(2, 'Chris White', 34),
(3, 'Sophia Taylor', 19),
(4, 'James Miller', 28);

-- Insert data into Visits
INSERT INTO Visits (visitID, visit_day, price, visitor_id, zoo_id)
VALUES 
(1, 1, 20, 1, 1),
(2, 2, 15, 2, 2),
(3, 3, 25, 3, 3),
(4, 4, 10, 4, 1),
(5, 5, 15, 1, 2);
GO

CREATE OR ALTER PROCEDURE deleteDataAboutAnimal(@animal_id int)
AS 
BEGIN
	IF NOT EXISTS(
		SELECT 1 FROM FoodAnimals
		WHERE animal_id = @animal_id
	)	
	BEGIN
		PRINT 'There is no food data about this animal'
		RETURN
	END

	DELETE FROM FoodAnimals WHERE animal_id = @animal_id
END
GO
EXECUTE deleteDataAboutAnimal 4
SELECT * FROM FoodAnimals
GO

CREATE OR ALTER VIEW showZooWithSmallestNumberVisits
AS 
	SELECT z.zid AS zooID FROM Zoos z
	INNER JOIN Visits v ON v.zoo_id = z.zid
	GROUP BY z.zid
	HAVING COUNT(visitor_id) = (SELECT MIN(visit_count) 
									FROM
									(
										SELECT COUNT(visitor_id) AS visit_count
										FROM Visits
										GROUP BY zoo_id
									)AS subq) 
GO
SELECT * FROM showZooWithSmallestNumberVisits
GO 

CREATE OR ALTER FUNCTION getIdsOfVistors(@N int)
RETURNS TABLE
AS
RETURN
	SELECT z.zid,V.visitor_id as visitorID FROM Zoos z 
	INNER JOIN Visits v ON v.zoo_id = z.zid
	INNER JOIN ZoosAnimals za ON za.zoo_id  = z.zid
	GROUP BY z.zid,v.visitor_id
	HAVING COUNT(za.animal_id) >= @N
GO
SELECT * FROM getIdsOfVistors(2)