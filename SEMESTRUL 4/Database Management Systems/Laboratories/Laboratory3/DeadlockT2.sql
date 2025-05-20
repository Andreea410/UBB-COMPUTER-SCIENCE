USE Booking
GO

SET DEADLOCK_PRIORITY HIGH
BEGIN TRAN
	UPDATE ExtraActivity SET location = 'location2'
	WHERE id = 2;
	WAITFOR DELAY '00:00:05';
	UPDATE Payment SET method = 'card'
	WHERE id = 1;

COMMIT TRANSACTION
