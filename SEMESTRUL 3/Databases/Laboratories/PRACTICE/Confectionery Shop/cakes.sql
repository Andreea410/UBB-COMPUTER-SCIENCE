
--DROP TABLES IF THEY EXIST
IF OBJECT_ID('OrdersOfCake','U') IS NOT NULL
DROP TABLE OrdersOfCake;
IF OBJECT_ID('Orders','U') IS NOT NULL
DROP TABLE Orders;
IF OBJECT_ID('Cakes','U') IS NOT NULL
DROP TABLE Cakes;
IF OBJECT_ID('Chefs','U') IS NOT NULL
DROP TABLE Chefs;
IF OBJECT_ID('CakeTypes','U') IS NOT NULL
DROP TABLE CakeTypes;

--Create tables
CREATE TABLE Chefs
(
	name varchar(50) PRIMARY KEY,
	gender varchar(1),
	birthday DATE
);

CREATE TABLE CakeTypes(
	name varchar(50) PRIMARY KEY,
	description varchar(50) NOT NULL
);

CREATE TABLE Cakes(
	name varchar(50) PRIMARY KEY,
	shape varchar(50) NOT NULL,
	weight int NOT NULL,
	price DECIMAL(10,2) NOT NULL,
	cakeType varchar(50) NOT NULL,
	chef varchar(50) NOT NULL,
	FOREIGN KEY(cakeType) references CakeTypes(name),
	FOREIGN KEY(chef) references Chefs(name)
);

CREATE TABLE Orders(
	id int PRIMARY KEY,
	date DATE NOT NULL
);

CREATE TABLE OrdersOfCake(
	orderID int NOT NULL,
	cakeName varchar(50) NOT NULL,
	quantity int NOT NULL,
	PRIMARY KEY(orderID,cakeName),
	FOREIGN KEY(orderID) REFERENCES Orders(id),
	FOREIGN KEY(cakeName) REFERENCES Cakes(name)
);



--INSERT DATA
INSERT INTO CakeTypes(name , description) VALUES
('Red Velvet','d1'),
('Chocolate','d2'),
('Vanilla','d3'),
('Cupcakes','d4'),
('Black Forest','d5');

INSERT INTO Chefs(name , gender,birthday) VALUES
('c1','M','2024-06-03'),
('c2','F','2024-06-03'),
('c3','M','2024-06-03'),
('c4','F','2024-06-03');

INSERT INTO Cakes(name,shape,weight,price,cakeType,chef) VALUES
('cake1','r1',100,10,'Red Velvet','c1'),
('cake2','r2',101,11,'Red Velvet','c2'),
('cake3','r3',102,10,'Chocolate','c3'),
('cake4','r4',103,10,'Vanilla','c1'),
('cake5','r4',103,10,'Cupcakes','c1'),
('cake6','r4',103,10,'Black Forest','c1'),
('cake7','r4',103,10,'Chocolate','c1');

INSERT INTO Orders(id,date) VALUES
(1,'2024-12-12'),
(2,'2024-12-12'),
(3,'2024-12-12'),
(4,'2024-12-12');

INSERT INTO OrdersOfCake(orderID,cakeName,quantity) VALUES
(1,'cake1',3),
(1,'cake2',2),
(2,'cake3',1),
(3,'cake4',2),
(3,'cake2',1);
GO

--	Implement a store procedure that receives an order ID , a cake name and a positive number P
-- representing the number of ordere pieces and adds the cake to the order.
-- If the cake is already on the order , the number of ordered pieces is set to P

CREATE OR ALTER PROCEDURE addCakeToOrder(@orderID int , @cakeName varchar(50),@P int) AS
BEGIN
	--Verify if cake exists
	IF NOT EXISTS
	(
		SELECT 1 FROM Cakes
		WHERE name  = @cakeName
	)
	BEGIN
		PRINT 'Cake does not exist'
		RETURN
	END

	--Verify if order exists
	IF NOT EXISTS
	(
		SELECT 1 FROM Orders
		WHERE id  = @orderID
	)
	BEGIN
		PRINT 'Order does not exist'
		RETURN
	END

	--Verify if cake already in order
	IF EXISTS(
		SELECT 1
		FROM OrdersOfCake
		WHERE cakeName = @cakeName AND orderID = @orderID
	)
	BEGIN
		PRINT 'Cake already exists in the order.Updating the quantity'
		UPDATE OrdersOfCake
		SET quantity = @P
		WHERE cakeName = @cakeName AND orderID = @orderID
		RETURN
	END

	--If cake not in order , add it
	PRINT 'Cake does not exist in the order'
	INSERT INTO OrdersOfCake(orderID,cakeName,quantity) VALUES (@orderID,@cakeName,@P)
END
GO

EXECUTE addCakeToOrder 4,'cake4',5;
SELECT * FROM OrdersOfCake;
GO

--Create a function that lists the names of all the chefs who are specialized in preparation of all cakes
CREATE OR ALTER FUNCTION listChefsSpecializedInAllCakes()
RETURNS TABLE
AS
RETURN
	SELECT c.name AS ChefName 
	FROM Chefs c
	JOIN Cakes cakes ON cakes.chef = c.name
	JOIN CakeTypes t ON cakes.cakeType = t.name
	GROUP BY c.name
	HAVING COUNT(DISTINCT cakes.cakeType) = (SELECT COUNT(*) FROM CakeTypes)
GO

SELECT * FROM listChefsSpecializedInAllCakes();
GO
