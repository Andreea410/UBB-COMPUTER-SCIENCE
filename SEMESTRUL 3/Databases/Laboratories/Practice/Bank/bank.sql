USE PracticeDatabase

DROP TABLE Customers
DROP TABLE cardsAssociatesBankAccount
DROP TABLE bankAccounts
DROP TABLE Cards
DROP TABLE ATMs
DROP TABLE Transactions


CREATE TABLE Customers(
	cid int PRIMARY KEY,
	cname varchar(50),
	birthday DATE,
)

CREATE TABLE BankAccounts(
	id int PRIMARY KEY,
	IBAN varchar(50),
	balance int,
	holder_id int,
	FOREIGN KEY(holder_id) REFERENCES Customers(cid)
)

CREATE TABLE Cards(
	cardID int PRIMARY KEY,
	number int,
	CVV int,
	bank_account_id int,
	FOREIGN KEY(bank_account_id) REFERENCES BankAccounts(id)
)

CREATE TABLE ATMs(
	aid int PRIMARY KEY,
	address varchar(50)
)

CREATE TABLE Transactions(
	ID INT primary key,
	atm_id int,
	card_id int,
	sum_money int,
	date_and_time DATETIME,
	FOREIGN KEY(atm_id) REFERENCES Atms(aid),
	FOREIGN KEY(card_id) REFERENCES Cards(cardID)
)
GO
--INSERTING DATA	
INSERT INTO Customers(cid,cname,birthday) VALUES
(1,'customer1','2024/12/12'),
(2,'customer2','2024/12/12'),
(3,'customer3','2024/12/12'),
(4,'customer4','2024/12/12'),
(5,'customer5','2024/12/12');
INSERT INTO BankAccounts(id,IBAN,balance,holder_id) VALUES
(1,'iban1',200,1),
(2,'iban2',2500,2),
(3,'iban3',400,1),
(4,'iban4',200,3);
INSERT INTO Cards(cardID,number,CVV,bank_account_id) VALUES
(1,890237,234,1),
(2,89430237,234,2),
(3,89054237,234,1),
(4,89022137,234,2),
(5,89023709,234,3);
INSERT INTO ATMs(aid,address) VALUES
(1,'adr1'),
(2,'adr2'),
(3,'adr3'),
(4,'adr4');
INSERT INTO Transactions(id,atm_id,card_id,sum_money,date_and_time) VALUES
(6,4,1,300,'2024/12/12 13:20'),
(6,1,1,300,'2024/12/12 13:20'),
(3,2,1,300,'2024/12/12 13:20'),
(4,2,2,300,'2024/12/12 13:20'),
(5,3,1,300,'2024/12/12 13:20');

SELECT * FROM  Transactions


GO
CREATE OR ALTER PROCEDURE deleteTransactions(@cardID int)
AS
BEGIN
	IF NOT EXISTS(
		SELECT 1 FROM Transactions 
		WHERE card_id = @cardID
		)
		BEGIN
			PRINT 'The card was not used in any transaction'
			RETURN
		END

		DELETE FROM Transactions WHERE card_id = @cardID
END

EXECUTE deleteTransactions 2
SELECT * FROM Transactions
GO

CREATE OR ALTER VIEW getCardNumbersUsedInAllAtms
AS
	SELECT c.number AS CardNumber,COUNT(DISTINCT atm_id) AS numberATMs FROM Cards c
	INNER JOIN Transactions t ON c.cardID = t.card_id
	INNER JOIN ATMs a ON t.atm_id = a.aid
	GROUP BY c.number
	HAVING COUNT(DISTINCT atm_id) = (SELECT COUNT(*) FROM ATMs)
GO

SELECT * FROM getCardNumbersUsedInAllAtms
GO

CREATE OR ALTER FUNCTION getCardsWithTransactions()
RETURNS TABLE
AS
RETURN 
	select c.number AS cardNumber , c.CVV as CVV,SUM(sum_money) AS money FROM Cards c
	INNER JOIN Transactions t ON t.card_id = c.cardID
	GROUP BY c.number,c.CVV
	HAVING SUM(sum_money) > 200
GO

SELECT * FROM getCardsWithTransactions()