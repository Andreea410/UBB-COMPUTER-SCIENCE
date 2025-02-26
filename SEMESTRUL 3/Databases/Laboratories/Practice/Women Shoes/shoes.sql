
--Deleting the tables if they already exist
IF OBJECT_ID('ShoesInPresentationShops' , 'U') IS NOT NULL
DROP TABLE ShoesInPresentationShops;
IF OBJECT_ID('ShoesBoughtByWoman' , 'U') IS NOT NULL
DROP TABLE ShoesBoughtByWoman;
IF OBJECT_ID('Shoes' , 'U') IS NOT NULL
DROP TABLE Shoes;
IF OBJECT_ID('ShoeModels' , 'U') IS NOT NULL
DROP TABLE ShoeModels;
IF OBJECT_ID('Women' , 'U') IS NOT NULL
DROP TABLE Women;
IF OBJECT_ID('PresentationShops' , 'U') IS NOT NULL
DROP TABLE PresentationShops;




--Creating the tables
CREATE TABLE PresentationShops(
	name varchar(50) PRIMARY KEY,
	city varchar(50) NOT NULL
);

CREATE TABLE Women(
	name varchar(50) PRIMARY KEY,
	amount decimal(10,2) NOT NULL
);

CREATE TABLE ShoeModels(
	name varchar(50) PRIMARY KEY,
	season varchar(50) NOT NULL
);

CREATE TABLE Shoes(
	id int PRIMARY KEY,
	price decimal(10,2) NOT NULL,
	shoeModelName varchar(50) NOT NULL,
	FOREIGN KEY(shoeModelName) REFERENCES ShoeModels(name) ON DELETE CASCADE
);

CREATE TABLE ShoesInPresentationShops(
	presentationShopName varchar(50),
	shoeID int,
	nrAvailable int,
	PRIMARY KEY(presentationShopName,shoeID),
	FOREIGN KEY(presentationShopName) REFERENCES PresentationShops(name) ON DELETE CASCADE,
	FOREIGN KEY(shoeID) REFERENCES Shoes(id) ON DELETE CASCADE
);

CREATE TABLE ShoesBoughtByWoman(
	womanName varchar(50),
	shoeID int,
	quantity int NOT NULL,
	amountSpent decimal(10,2) NOT NULL,
	PRIMARY KEY(womanName , shoeID),
	FOREIGN KEY(shoeID) REFERENCES Shoes(id) ON DELETE CASCADE,
	FOREIGN KEY(womanName) REFERENCES Women(name) ON DELETE CASCADE
);
GO

--Create a stored procedure that receives a shoe , a presentationShop and the number of shoes
--and adds the shoe to the presentation shop

CREATE OR ALTER PROCEDURE addShoeToPresentationShop(@shoeID int , @presentationShopName varchar(50),@nrshoes int)
AS
BEGIN
	--verify if shoe exist
	IF NOT EXISTS(
		SELECT * FROM Shoes
		WHERE id = @shoeID
	)
	BEGIN
		PRINT 'ERROR: A shoe with this id does not exist'
		RETURN
	END

	--verify if presentationShop exist
	IF NOT EXISTS(
		SELECT * FROM PresentationShops
		WHERE name = @presentationShopName
	)
	BEGIN
		PRINT 'ERROR: A presentation shop with this name does not exist'
		RETURN
	END

	IF EXISTS( --verify if already exists
		SELECT * FROM ShoesInPresentationShops
		WHERE shoeID = @shoeID AND presentationShopName = @presentationShopName AND nrAvailable = @nrshoes
	)
	BEGIN
		PRINT 'ERROR DUPLICATE: This data already exists in the database' --print message
		RETURN
	END

	IF EXISTS( --verify if already exist but with different number of shoes and update the shoes
		SELECT * FROM ShoesInPresentationShops
		WHERE shoeID = @shoeID AND presentationShopName = @presentationShopName 
	)
	BEGIN
		PRINT 'This data already exists in the database.Updating the stock' --print message
		UPDATE ShoesInPresentationShops
		SET nrAvailable = @nrshoes
		WHERE shoeID = @shoeID AND presentationShopName = @presentationShopName
		RETURN
	END

	INSERT INTO ShoesInPresentationShops(shoeID,presentationShopName,nrAvailable) VALUES (@shoeID,@presentationShopName,@nrshoes)

END
GO

--INSERT DATA
INSERT INTO ShoeModels(name,season) VALUES
('ghete','iarna'),
('sandale','vara'),
('cizme groase','iarna'),
('cizme subtiri','vara');

INSERT INTO Shoes(id,price,shoeModelName) VALUES
(1,100,'ghete'),
(2,250,'sandale'),
(3,175,'cizme groase');

INSERT INTO PresentationShops(name,city) VALUES
('p1','c1'),
('p2','c2'),
('p3','c3'),
('p4','c4');

INSERT INTO Women(name,amount) VALUES
('w1',1000),
('w2',200),
('w3',75),
('w4',570);

INSERT INTO ShoesBoughtByWoman(womanName,shoeID,quantity,amountSpent) VALUES
('w1',1,2,790),
('w2',2,1,800),
('w2',1,1,800),
('w3',3,2,800);

GO

EXECUTE addShoeToPresentationShop 1,'p1',48
SELECT * FROM ShoesInPresentationShops;
GO

--Create a view that shows the women that bought at least 2 shoes from a given shoe model

CREATE OR ALTER VIEW getWomenWhoBoughtAtLeast2Shoes AS
SELECT w.name, s.shoeModelName
FROM Women w
JOIN ShoesBoughtByWoman sb ON w.name = sb.womanName
JOIN Shoes s ON s.id = sb.shoeID
GROUP BY w.name, s.shoeModelName
HAVING SUM(sb.quantity) >= 2;  
GO


SELECT * 
FROM getWomenWhoBoughtAtLeast2Shoes
WHERE shoeModelName = 'ghete'; 

--Create a function that lists the shoes that can be found in at least T presentation shops
-- where T >= 1 is a function parameter
GO

CREATE OR ALTER FUNCTION getShoesThatAreFoundInAtLeastTPresentations (@T int)
RETURNS TABLE
AS
RETURN
	SELECT DISTINCT s.id
	FROM Shoes s
	JOIN ShoesInPresentationShops sp
	ON sp.shoeID = s.id
	GROUP BY s.id
	HAVING COUNT(sp.presentationShopName) >= @T
GO

SELECT * FROM getShoesThatAreFoundInAtLeastTPresentations(2)



