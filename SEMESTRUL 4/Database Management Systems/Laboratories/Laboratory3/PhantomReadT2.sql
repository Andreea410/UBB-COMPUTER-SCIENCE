USE Booking
GO

SET IDENTITY_INSERT OwnerBooking ON;
INSERT INTO OwnerBooking(id,name) VALUES (2,'owner');
SET IDENTITY_INSERT OwnerBooking OFF;

--DELETE FROM OwnerBooking WHERE id = 2