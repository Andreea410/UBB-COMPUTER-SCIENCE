USE Booking;
GO

CREATE OR ALTER PROCEDURE addLanguage(@provenience varchar(50), @name varchar(50)) AS
BEGIN
	
	DECLARE @id smallint;
	DECLARE @error varchar(max);
	
	SET @id = (SELECT MAX(id) FROM Language) + 1;
	SET @error = '';
	
	IF (@id IS NULL)
	BEGIN
		SET @id = 1;
	END

	IF (@name IS NULL OR @name NOT LIKE '[A-Z]%' COLLATE Latin1_General_CS_AS )
	BEGIN
		SET @error = 'Name must with an uppercase letter and can not be null';
		THROW 50000,@error,1;
	END

	IF(@provenience IS NULL OR DATALENGTH(@provenience) = 0)
	BEGIN
		SET @error = 'Proveniece must not be null or empty';
		THROW 50001,@error,1;
	END
	
	INSERT INTO Language(id,name,provenience) VALUES (@id,@name,@provenience);

END
GO

CREATE OR ALTER PROCEDURE addClient(@name varchar(50), @email varchar(50)) AS 
BEGIN
	DECLARE @error varchar(max);

	IF(@name IS NULL OR @name NOT LIKE '[A-Z]%' COLLATE Latin1_General_CS_AS)
	BEGIN
		SET @error = 'Name must start with a capital letter and can not be null.';
		THROW 50002,@error,1;
	END

	IF @email IS NULL OR LEN(@email) = 0 OR (@email NOT LIKE '%@gmail.com' AND @email NOT LIKE '%@yahoo.com')	
	BEGIN
		SET @error = 'Email must be like @gmail.com OR @email.com and can not be null';
		THROW 50003,@error,1;
	END

	INSERT INTO Client(name,email) VALUES (@name,@email);
END
GO

CREATE OR ALTER PROCEDURE addLanguageSpokenByClient(@clientName varchar(50), @languageName varchar(50)) AS
BEGIN
	DECLARE @error varchar(max);
	SET @error = '';

	IF(@clientName IS NULL)
	BEGIN
		SET @error = 'Client name must not be null.';
		THROW 50004,@error,1; 
	END

	IF(@languageName IS NULL)
	BEGIN
		SET @error = 'Language name must not be null.';
		THROW 50005,@error,1; 
	END

	DECLARE @cid int;
	DECLARE @lid smallint;

	SET @cid = (SELECT id FROM Client WHERE name = @clientName);
	IF @cid IS NULL
	BEGIN
		SET @error = 'There is not Client with the given name';
		THROW 50006,@error,1; 
	END

	SET @lid = (SELECT id FROM Language WHERE name = @languageName);
	IF @lid IS NULL
	BEGIN
		SET @error = 'There is not Language with the given name';
		THROW 50007,@error,1;
	END

	INSERT INTO LanguagesSpokenByClient(clientID,languageID) VALUES(@cid,@lid);
END
GO

CREATE OR ALTER PROCEDURE succesfullRollback AS
BEGIN
	BEGIN TRAN
	BEGIN TRY
		EXEC addLanguage 'provenienceTest2','LanguageTest2';
		EXEC addClient 'ClientTest2', 'clienttest2@yahoo.com';
		EXEC addLanguageSpokenByClient 'ClientTest2', 'LanguageTest2'
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN 
		PRINT 'Rolledback.';
		RETURN
	END CATCH
	COMMIT TRAN
END
GO

CREATE OR ALTER PROCEDURE failRollback AS
BEGIN
	BEGIN TRAN
	BEGIN TRY
		EXEC addLanguage 'Failure','Failure';
		EXEC addClient 'failure', 'fail@yahoo.com';
		EXEC addLanguageSpokenByClient 'failure', 'Failure'
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN 
		PRINT 'Rolledback.';
		RETURN
	END CATCH
	COMMIT TRAN
END
GO


EXEC succesfullRollback;
GO

EXEC failRollback;
GO

SELECT * From Client
SELECT * FROM Language 