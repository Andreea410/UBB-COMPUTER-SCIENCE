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




