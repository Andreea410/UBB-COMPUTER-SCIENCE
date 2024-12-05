CREATE TABLE OwnerBooking(
	id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	name varchar(50)
)

CREATE TABLE Client(
	id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	name varchar(50) NOT NULL, 
	email varchar(50)
)

CREATE TABLE Language(
	id smallint NOT NULL PRIMARY KEY,
	provenience varchar(50),
	name varchar(50)
)

CREATE TABLE LanguagesSpokenByOwner(
	languageID smallint FOREIGN KEY REFERENCES Language(id),
	ownerID int FOREIGN KEY REFERENCES OwnerBooking(id)
	unique(ownerID,languageID)
)

CREATE TABLE LanguagesSpokenByClient(
	languageID smallint FOREIGN KEY REFERENCES Language(id),
	clientID int FOREIGN KEY REFERENCES Client(id)
	unique(clientID,languageID)
)

CREATE TABLE Payment(
	id smallint IDENTITY(1,1) NOT NULL PRIMARY KEY,
	method varchar(50) CHECK (method IN ('CASH','CARD')),
	payment_date date
)

CREATE TABLE Booking(
	id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	location varchar(50) NOT NULL,
	capacity int,
	ownerID int FOREIGN KEY REFERENCES OwnerBooking(id) UNIQUE,
	clientID int FOREIGN KEY REFERENCES Client(id) UNIQUE,
	paymentID smallint FOREIGN KEY REFERENCES Payment(id)
)

CREATE TABLE Review(
	id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	clientID int FOREIGN KEY REFERENCES Client(id),
	rating float,
	message varchar(200),
	bookingID int FOREIGN KEY REFERENCES Booking(id)
)

CREATE TABLE ExtraActivity(
	id smallint IDENTITY(1,1) NOT NULL PRIMARY KEY,
	location varchar(50)
)

CREATE TABLE bookingActivities(
	bookingID int FOREIGN KEY REFERENCES Booking(id),
	activityID smallint FOREIGN KEY REFERENCES ExtraActivity(id)
	unique(bookingId,activityID)
)

ALTER TABLE LanguagesSpokenByOwner
DROP CONSTRAINT UQ__Language__4F6DE7C91EDC48B0;

SELECT
    tc.CONSTRAINT_NAME,
    tc.CONSTRAINT_TYPE,
    kcu.COLUMN_NAME
FROM
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
ON
    tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE
    tc.TABLE_NAME = 'LanguagesSpokenByOwner';

ALTER TABLE LanguagesSpokenByOwner
ALTER COLUMN languageID SMALLINT NOT NULL;

ALTER TABLE LanguagesSpokenByOwner
ALTER COLUMN ownerID INT NOT NULL;

ALTER TABLE LanguagesSpokenByOwner
ADD PRIMARY KEY (languageID, ownerID);

SELECT
    tc.CONSTRAINT_NAME,
    tc.CONSTRAINT_TYPE,
    kcu.COLUMN_NAME
FROM
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
ON
    tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE
    tc.TABLE_NAME = 'LanguagesSpokenByClient';

ALTER TABLE LanguagesSpokenByClient
DROP CONSTRAINT UQ__Language__B0845D24E329C9D8;

ALTER TABLE LanguagesSpokenByClient
ALTER COLUMN languageID SMALLINT NOT NULL;

ALTER TABLE LanguagesSpokenByClient
ALTER COLUMN clientID INT NOT NULL;

ALTER TABLE LanguagesSpokenByClient
ADD PRIMARY KEY (languageID,clientID);

SELECT
    tc.CONSTRAINT_NAME,
    tc.CONSTRAINT_TYPE,
    kcu.COLUMN_NAME
FROM
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
ON
    tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE
    tc.TABLE_NAME = 'BookingActivities';

ALTER TABLE BookingActivities
DROP CONSTRAINT UQ__bookingA__162CA75015152E6C;


ALTER TABLE BookingActivities
ALTER COLUMN bookingID INT NOT NULL;

ALTER TABLE BookingActivities
ALTER COLUMN activityID SMALLINT NOT NULL;

ALTER TABLE BookingActivities
ADD PRIMARY KEY (bookingID , activityID);

SELECT CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Booking' AND CONSTRAINT_TYPE = 'UNIQUE';

ALTER TABLE Booking DROP CONSTRAINT CK_Booking_Owner;







