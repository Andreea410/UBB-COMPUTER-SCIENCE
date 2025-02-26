-- Create a database to manage services offered by a stock exchange. The database will store data about all the intermediaries involved in trading. 
-- The entities of interest to the problem domain are: Clients, Brokers, StockExchange, Stocks and Bonds. 
-- A client has a name and a unique identification number. 
-- Clients can work with multiple brokers. 
-- A broker has a name and a list of clients. Brokers can work with multiple stock exchanges. 
-- A stock exchange has a list of brokerage companies containing all the brokers the exchange is working with Multiple stocks or bonds can be listed on the same exchange.
--  Both stocks and bonds have a name and the identification number of the client which bought it through a broker.
-- 2. Implement a stored procedure that receives a client and returns all the stocks and bonds names bought
-- by the client and also the name of the brokerage company through which the client made the purchases.
-- 3. Create a view that shows all the stocks bought by the clients from identification numbers of those clients.
-- 4. Implement a function that lists the identification numbers of the clients which are investing in multiple stock exchanges.

-- 1. Write an SQL script that creates the corresponding relational data model.

CREATE TABLE StockClients(
	id int PRIMARY KEY,
	name varchar(50) NOT NULL
)

CREATE TABLE Brokers(
	name varchar(50) PRIMARY KEY
)

CREATE TABLE BrokersClients(
	clientID int,
	brokerName varchar(50),
	PRIMARY KEY(clientID,brokerName),
	FOREIGN KEY(clientID) REFERENCES StockClients(id),
	FOREIGN KEY(brokerName) REFERENCES Brokers(name)
);


CREATE TABLE StockExchanges(
	id int PRIMARY KEY
)

CREATE TABLE Bonds(
	id int PRIMARY KEY,
	name varchar(50),
	clientID int,
	exchangeID int,   
	FOREIGN KEY(clientID) REFERENCES StockClients(id),
	FOREIGN KEY(exchangeID) REFERENCES StockExchanges(id)
)

CREATE TABLE Stocks(
	id int PRIMARY KEY,
	name varchar(50),
	clientID int,
	exchangeID int,
	FOREIGN KEY(clientID) REFERENCES StockClients(id),
	FOREIGN KEY(exchangeID) REFERENCES StockExchanges(id)
)

GO
-- 2. Implement a stored procedure that receives a client and returns all the stocks and bonds names bought
-- by the client and also the name of the brokerage company through which the client made the purchases

--INSERT DATA
INSERT INTO StockClients(id,name) VALUES
(1,'c1'),
(2,'c2'),
(3,'c3'),
(4,'c4');

INSERT INTO Brokers(name) VALUES
('b1'),
('b2'),
('b3'),
('b4');

INSERT INTO BrokersClients(clientID,brokerName) VALUES
(1,'b1'),
(1,'b2'),
(2,'b1'),
(3,'b1'),
(3,'b4'),
(4,'b3');

INSERT INTO StockExchanges(id) VALUES
(1),
(2),
(3),
(4);

INSERT INTO Bonds(id,name,clientID,exchangeID) VALUES
(1,'bond1',1,1),
(2,'bond2',3,2),
(3,'bond3',2,3),
(4,'bond4',2,4);

INSERT INTO Stocks(id,name,clientID,exchangeID) VALUES
(1,'stock1',2,4),
(2,'stock2',3,2),
(3,'stock3',1,1),
(4,'stock4',2,3);




GO
CREATE OR ALTER PROCEDURE getStockAndBondsByClient(@clientID int)
AS
BEGIN
	SELECT c.name AS ClientName,s.name AS StockName,b.name AS BondName
	FROM StockClients c
	LEFT JOIN Stocks s ON s.clientID = @clientID
	LEFT JOIN Bonds b ON b.clientID = @clientID
	LEFT JOIN StockExchanges se 
	WHERE c.id = @clientID
END
 