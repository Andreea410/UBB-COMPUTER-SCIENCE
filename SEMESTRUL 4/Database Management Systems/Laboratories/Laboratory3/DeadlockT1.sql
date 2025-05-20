USE Booking
GO

BEGIN TRAN
	UPDATE Payment SET method = 'cash'
	WHERE id = 1;
	WAITFOR DELAY '00:00:05';
	UPDATE ExtraActivity SET location = 'location1'
	WHERE id = 2;

COMMIT TRANSACTION

SELECT * FROM Payment;
SELECT * FROM ExtraActivity;