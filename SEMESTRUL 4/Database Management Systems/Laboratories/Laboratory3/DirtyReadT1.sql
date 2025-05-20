USE Booking;
GO

BEGIN TRAN
UPDATE OwnerBooking 
SET name = 'owner' 
WHERE id = 5;
WAITFOR DELAY '00:00:10';
ROLLBACK;