USE Booking 
GO

SET TRANSACTION ISOLATION LEVEL SNAPSHOT --set the isolation level an optimistic one
BEGIN TRAN
	SELECT * FROM LanguageSpokenByOwnerCopy 
	WHERE id = 2;
	WAITFOR DELAY '00:00:10'
	SELECT * FROM LanguageSpokenByOwnerCopy 
	WHERE id = 10;
	UPDATE LanguageSpokenByOwnerCopy
	SET languageID = 5
	WHERE id = 2
COMMIT TRAN