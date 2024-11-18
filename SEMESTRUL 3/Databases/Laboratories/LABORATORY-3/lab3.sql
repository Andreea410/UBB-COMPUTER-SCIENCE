
--MODIFY THE TYPE OF A COLUMN AND REVERT
--MODIFY
CREATE OR ALTER PROCEDURE ModifyRatingToInt AS
    ALTER TABLE Review
		ALTER COLUMN rating INT;
GO
EXECUTE ModifyRatingToInt
GO

--REVERT
CREATE OR ALTER PROCEDURE RevertRatingToFloat AS
    ALTER TABLE Review
		ALTER COLUMN rating FLOAT;  
GO
EXECUTE RevertRatingToFloat
GO


--ADD/REMOVE A COLUMN
-- ADD 'phone'
CREATE OR ALTER PROCEDURE AddPhoneColumn AS
    ALTER TABLE Client
    ADD phone VARCHAR(15);
GO
EXECUTE AddPhoneColumn
GO

-- REMOVE 'phone' 
CREATE OR ALTER PROCEDURE RemovePhoneColumn AS
    ALTER TABLE Client
    DROP COLUMN phone;
GO
EXECUTE RemovePhoneColumn
GO


--ADD/REMOVE A DEFAULT CONSTRAINT
--ADD
CREATE OR ALTER PROCEDURE AddDefaultPaymentDate AS
    ALTER TABLE Payment
		ADD CONSTRAINT DF_payment_date DEFAULT GETDATE() FOR payment_date;
GO
EXECUTE AddDefaultPaymentDate
GO

--REMOVE
CREATE OR ALTER PROCEDURE RemoveDefaultPaymentDate AS
    ALTER TABLE Payment
    DROP CONSTRAINT DF_payment_date;
GO
EXECUTE RemoveDefaultPaymentDate
GO

--ADD/REMOVE A PRIMARY KEY AND FOREIGN KEY
CREATE OR ALTER PROCEDURE RemoveForeignKey
AS
    ALTER TABLE Booking
    DROP CONSTRAINT FK_Booking_PaymentID;
GO
EXECUTE RemoveForeignKey
GO	


CREATE OR ALTER PROCEDURE RemovePrimaryKey
AS
    ALTER TABLE Payment
    DROP CONSTRAINT PK__Payment__id;
GO
EXECUTE RemovePrimaryKey
GO

CREATE OR ALTER PROCEDURE AddPrimaryKey AS
    ALTER TABLE Payment
    ADD CONSTRAINT PK_Payment_id PRIMARY KEY(id);
GO
EXECUTE AddPrimaryKey
GO

CREATE OR ALTER PROCEDURE AddForeignKey AS
	ALTER TABLE Booking
		ADD CONSTRAINT FK_Booking_PaymentID
		FOREIGN KEY (paymentID) REFERENCES Payment(id);
GO
EXECUTE AddPrimaryKey
GO

--ADD/REMOVE A CANDIDATE KEY(UNIQUE CONSTRAINT)
--FINDING THE NAME OF CONSTRAINT KEY IN BOOKING TABLE

CREATE OR ALTER PROCEDURE RemoveUniqueConstraint AS
	ALTER TABLE Booking
	DROP CONSTRAINT CK_Booking_Owner
GO
EXECUTE RemoveUniqueConstraint
GO	

CREATE OR ALTER PROCEDURE AddUniqueConstraint AS
	ALTER TABLE Booking
	ADD CONSTRAINT CK_Booking_Owner UNIQUE(ownerID)
GO
EXECUTE AddUniqueConstraint
GO


--CREATE/DROP TABLE
CREATE OR ALTER PROCEDURE CreateTableFeedback AS
	CREATE TABLE Feedback (
		id INT IDENTITY(1,1) PRIMARY KEY,
		clientID INT FOREIGN KEY REFERENCES Client(id),
		feedbackText VARCHAR(250)
	);
GO
EXECUTE CreateTableFeedback
GO

CREATE OR ALTER PROCEDURE DropTableFeedBack AS
	DROP TABLE Feedback
GO
EXECUTE DropTableFeedBack
GO


CREATE TABLE VersionTable
(
	Version INT
)

INSERT INTO VersionTable VALUES (1)

CREATE TABLE ProcedureTable(
	FirstVersion int,
	LastVersion int,
	ProcedureName varchar(50),
	PRIMARY KEY(Firstversion,LastVersion)
)

INSERT INTO ProcedureTable VALUES(1,2 , 'ModifyRatingToInt')
INSERT INTO ProcedureTable VALUES(2,1 , 'RevertRatingToFloat')
INSERT INTO ProcedureTable VALUES(2,3 , 'AddPhoneColumn')
INSERT INTO ProcedureTable VALUES(3,2 , 'RemovePhoneColumn')
INSERT INTO ProcedureTable VALUES(3,4 , 'AddDefaultPaymentDate')
INSERT INTO ProcedureTable VALUES(4,3 , 'RemoveDefaultPaymentDate')
INSERT INTO ProcedureTable VALUES(4,5, 'AddPrimaryKey')
INSERT INTO ProcedureTable VALUES(5,6, 'AddForeignKey')
INSERT INTO ProcedureTable VALUES(5,4, 'RemovePrimaryKey')
INSERT INTO ProcedureTable VALUES(6,5, 'RemoveForeignKey')
INSERT INTO ProcedureTable VALUES(6,7, 'AddUniqueConstraint')
INSERT INTO ProcedureTable VALUES(7,6, 'RemoveUniqueConstraint')
INSERT INTO ProcedureTable VALUES(7,8, 'CreateTableFeedback')
INSERT INTO ProcedureTable VALUES(8,7, 'DropTableFeedBack')

GO

CREATE OR ALTER PROCEDURE restoreVersion(@version INT) AS
    DECLARE @currentVersion INT
    DECLARE @procedureName VARCHAR(MAX)
    SELECT @currentVersion = Version FROM VersionTable
 
    WHILE @currentVersion > @version BEGIN
        SELECT @procedureName = ProcedureName FROM ProcedureTable 
			WHERE FirstVersion = @currentVersion AND LastVersion = @currentVersion-1
        EXEC (@procedureName)
        SET @currentVersion = @currentVersion-1
    END
 
    WHILE @currentVersion < @version BEGIN
        SELECT @procedureName = ProcedureName 
		FROM ProcedureTable 
		WHERE FirstVersion = @currentVersion AND LastVersion = @currentVersion+1
	    EXEC (@procedureName)
        SET @currentVersion = @currentVersion+1
    END
 
    UPDATE VersionTable SET Version = @version
    RETURN
 
EXECUTE restoreVersion 7

