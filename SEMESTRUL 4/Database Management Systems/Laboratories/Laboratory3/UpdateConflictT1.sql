USE Booking 
GO

WAITFOR DELAY '00:00:10'
BEGIN TRAN
	UPDATE LanguageSpokenByOwnerCopy
	SET languageID = 5
	WHERE id = 2
WAITFOR DELAY '00:00:05'
COMMIT TRAN


