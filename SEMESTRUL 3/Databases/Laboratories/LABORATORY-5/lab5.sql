USE Booking
GO

-----------------------------------------
---------CREATING THE TABLES-------------
-----------------------------------------

CREATE TABLE Ta(
	aid INT PRIMARY KEY,
	a2 INT UNIQUE,
)
GO

ALTER TABLE Ta
ADD a3 INT;


CREATE TABLE Tb(
	bid INT PRIMARY KEY,
	b2 INT
)
GO

CREATE TABLE Tc(
	cid INT PRIMARY KEY,
    aid int REFERENCES Ta(aid),
    bid int REFERENCES Tb(bid)
)
GO

-----------------------------------------------------------------------
--------PROCEDURES WHICH AUTOMATICALLY ADDS DATA INTO THE TABLES-------
-----------------------------------------------------------------------

CREATE OR ALTER PROCEDURE addDataTa(@rows int) AS
	DECLARE @a2 INT
	SET @a2 = @rows*2 + 100
	WHILE @rows > 0 BEGIN
		INSERT INTO Ta VALUES (@rows, @a2,@rows)
		SET @rows = @rows -1
		SET @a2 = @a2 - 2
	END
GO

CREATE OR ALTER PROCEDURE addDataTb(@rows int) AS
	DECLARE @b2 INT
	SET @b2 = @rows*2 + 100
	WHILE @rows > 0 BEGIN
		INSERT INTO Tb VALUES (@rows,@b2)
		SET @rows = @rows-1
		SET @b2 = @b2 - 2
	END
GO

CREATE OR ALTER PROCEDURE addDataTc(@rows int) AS
	DECLARE @aid INT
	DECLARE @bid INT
	WHILE @rows > 0 BEGIN
		SET @aid = (SELECT TOP 1 aid FROM Ta ORDER BY  NEWID())
		SET @bid = (SELECT TOP 1 bid FROM Tb ORDER BY  NEWID())
	    INSERT INTO Tc VALUES (@rows , @aid , @bid)
		SET @rows = @rows - 1
	END
GO

----------------------------------------------------------------
-----------------------CREATE INDEXES --------------------------
----------------------------------------------------------------

EXEC addDataTa 100
EXEC addDataTb 100
EXEC addDataTc 
GO



SELECT * FROM Ta ORDER BY aid --Clustered index scan
SELECT * FROM Ta WHERE aid = 660 --Clustered index seek

CREATE NONCLUSTERED INDEX nonclustered_index ON Ta(a2); --Create nonclustered index
GO

SELECT * FROM Ta ORDER BY a2; -- Nonclustered index scan
SELECT a2 FROM Ta WHERE a2 = 1410 -- Nonclustered index seek

SELECT aid, a2, a3 FROM Ta WHERE a2 = 1400; --Key lookup
GO

SELECT * FROM Tb WHERE b2 = 110

---Create non-clustered index on the field b2
IF EXISTS (SELECT NAME FROM sys.indexes WHERE NAME = 'N_idx_Tb_b2')
DROP INDEX N_idx_Tb_b2 ON Tb
CREATE NONCLUSTERED INDEX N_idx_Tb_b2 ON Tb(b2)
GO

CREATE OR ALTER VIEW view1 AS
    SELECT TOP 1000 T1.a2, T2.b2
    FROM Tc T3 
		JOIN Ta T1 
		ON T3.aid = T1.aid 
		JOIN Tb T2 
		ON T3.bid = T2.bid
    WHERE T2.b2 > 500 AND T1.a2 < 1500
GO

SELECT * FROM view1
GO

