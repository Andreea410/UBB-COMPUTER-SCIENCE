USE Booking

INSERT INTO Language(id,provenience,name) VALUES (1, 'Latina','Romanian');
INSERT INTO Language(id,provenience,name) VALUES (2,'Latina','Italian');
INSERT INTO Language(id, provenience, name) VALUES (3, 'Germanic', 'German');
INSERT INTO Language(id, provenience, name) VALUES (4,  'Sino-Tibetan','Mandarin');
INSERT INTO Language(id, provenience, name) VALUES (5, 'Afro-Asiatic','Arabic');
INSERT INTO Language(id, provenience, name) VALUES (6, 'Afro-Asiatic','Arabic');

--update because Latina is in Romanian and the rest of the data is in English
UPDATE Language SET provenience = 'Latin' WHERE id BETWEEN 1 AND 2
--delete because data is duplicated
DELETE FROM Language WHERE name = 'Arabic' AND id >5;
SELECT * FROM Language;

INSERT INTO OwnerBooking(name) VALUES ('Ioan');
INSERT INTO OwnerBooking(name) VALUES ('Vasile');
INSERT INTO OwnerBooking(name) VALUES ('Iosif');
INSERT INTO OwnerBooking(name) VALUES ('Maria');
INSERT INTO OwnerBooking(name) VALUES('LORENA');
INSERT INTO OwnerBooking(name) VALUES('Iosid');

--Delete because mistyped name
DELETE FROM OwnerBooking WHERE name like 'L%';
DELETE FROM OwnerBooking WHERE name='Iosid';
SELECT * FROM OwnerBooking;

SELECT "name" AS Owners_Desc FROM OwnerBooking 
ORDER BY "name" DESC

INSERT INTO Client(name , email) VALUES('Magdalena','magdalena123@yahoo.com');
INSERT INTO Client(name , email) VALUES('Ioana','ioana.io@gmail.com');
INSERT INTO Client(name , email) VALUES('Laurentiu','laurentiu-andrei@yahoo.com');
INSERT INTO Client(name , email) VALUES('Vasile','vasile1999@gmail.com');
INSERT INTO Client(name , email) VALUES('mariana','mariana__$@gmail.com');

UPDATE Client SET name='Mariana' WHERE name like 'mariana';
SELECT * FROM Client;

INSERT INTO LanguagesSpokenByClient(languageID,clientID) VALUES (1,19);
INSERT INTO LanguagesSpokenByClient(languageID,clientID) VALUES (1,20);
INSERT INTO LanguagesSpokenByClient(languageID,clientID) VALUES (2,19);
INSERT INTO LanguagesSpokenByClient(languageID,clientID) VALUES (3,21);
INSERT INTO LanguagesSpokenByClient(languageID,clientID) VALUES (5,21);

--VIOLATES REFERENTIAL INTEGRITY CONSTRAINTS
INSERT INTO LanguagesSpokenByClient(languageID,clientID) VALUES (6,21);

SELECT * FROM LanguagesSpokenByClient;

INSERT INTO LanguagesSpokenByOwner(languageID,ownerID) VALUES (1,14);
INSERT INTO LanguagesSpokenByOwner(languageID,ownerID) VALUES (1,15);
INSERT INTO LanguagesSpokenByOwner(languageID,ownerID) VALUES (2,14);
INSERT INTO LanguagesSpokenByOwner(languageID,ownerID) VALUES (3,17);

SELECT * FROM LanguagesSpokenByOwner;

INSERT INTO Payment(method ,payment_date) VALUES ('card',2024/11/2)
INSERT INTO Payment(method ,payment_date) VALUES ('card','2024-11-02')
INSERT INTO Payment(method ,payment_date) VALUES ('cash','2024-10-25')

SELECT * FROM Payment

INSERT INTO Booking(location,capacity,ownerID,clientID,paymentID) VALUES ('Italy' , 4,17,19,1);
INSERT INTO Booking(location,capacity,ownerID,clientID,paymentID) VALUES ('Spain' , 2,21,21,2);
INSERT INTO Booking(location,capacity,ownerID,clientID,paymentID) VALUES ('Romania',2,14,20,1);
INSERT INTO Booking(location,capacity,ownerID,clientID,paymentID) VALUES ('Spania' ,2,16,23,2);

UPDATE Booking SET location = 'Spain' WHERE location = 'Spania'
SELECT * FROM Booking

INSERT INTO Review(clientID,bookingID,rating,message) VALUES (19,1,5.00,'Everything was just as expected');
INSERT INTO Review(clientID,bookingID,rating,message) VALUES (21,4,3.5,'The accomadion could have been cleaner.');
INSERT INTO Review(clientID,bookingID,rating,message) VALUES (23,9,4.2,'The place was a little too far from the centre');
SELECT * FROM Review

SELECT * 
FROM Booking 
INNER JOIN OwnerBooking ON Booking.ownerID = OwnerBooking.id 
INNER JOIN Client ON Booking.clientID = Client.id;

SELECT * 
FROM OwnerBooking
LEFT JOIN Booking ON OwnerBooking.id = Booking.ownerID;

SELECT *
FROM Booking
RIGHT JOIN Client ON Booking.clientID = Client.id

--Display all the languages info spoken by client and owner ,and also client's and owner's info
SELECT *
FROM LanguagesSpokenByOwner
INNER JOIN Language ON Language.id = LanguagesSpokenByOwner.languageID
INNER JOIN OwnerBooking ON LanguagesSpokenByOwner.ownerID = OwnerBooking.id
FULL JOIN (
    SELECT languageID,clientID,email
    FROM LanguagesSpokenByClient
    INNER JOIN Language ON Language.id = LanguagesSpokenByClient.languageID
    INNER JOIN Client ON LanguagesSpokenByClient.clientID = Client.id
) AS ClientLanguages ON LanguagesSpokenByOwner.languageID = ClientLanguages.languageID;

--Display all the DISTINCT names from every Client and Owner, UNION==>duplicates won t show
SELECT DISTINCT name FROM Client
UNION
SELECT name FROM OwnerBooking

SELECT 'Client' AS BookingStatus , name FROM Client
UNION
SELECT 'Owner' AS BookingStatus , name FROM OwnerBooking

--Display all the languages spoken by client or owner including duplicates
SELECT id FROM Language
UNION ALL
SELECT languageID FROM LanguagesSpokenByClient

--Display mutual names between client and ownerBooking
SELECT name FROM Client
INTERSECT
SELECT name FROM OwnerBooking

--Select langauges which are also spoken by client and have the id > 1
SELECT id , name , provenience FROM Language
where id IN(
	SELECT languageID FROM LanguagesSpokenByClient
	WHERE languageID > 1
);

SELECT ownerID , languageID FROM LanguagesSpokenByOwner;

SELECT id , name , provenience FROM Language
where id NOT IN(
	SELECT languageID FROM LanguagesSpokenByOwner
	WHERE languageID > 1
);


SELECT * FROM Booking
EXCEPT(
	SELECT * FROM Booking
	WHERE Booking.location = 'Spain' OR Booking.capacity > 2
);

SELECT * FROM Client
WHERE id IN(
	SELECT clientID FROM Booking 
	WHERE clientID IN(
		SELECT clientID FROM LanguagesSpokenByOwner
	)
)

--Displays the owners which speaks the same lanuage as at least one client
SELECT ownerID,languageID  FROM LanguagesSpokenByOwner
WHERE EXISTS(
	SELECT languageID FROM LanguagesSpokenByClient 
	WHERE languageID < 3 AND LanguagesSpokenByClient.languageID = LanguagesSpokenByOwner.languageID
)

--Displays the Client which speaks at least one language
SELECT * FROM Client
WHERE EXISTS(
	SELECT ClientId FROM LanguagesSpokenByClient
	WHERE clientID = Client.id
)

SELECT * FROM Booking B INNER JOIN(
	SELECT name,email,id FROM Client C
	WHERE email LIKE '%yahoo.com' AND name LIKE 'L%'
)AS ClientsWithYahoo ON B.clientID = ClientsWithYahoo.id;

SELECT * FROM Booking B INNER JOIN(
	SELECT name,id FROM OwnerBooking O
	WHERE name LIKE 'i%'
)AS OwnersStaringM ON B.clientID = OwnersStaringM.id;

--Displays the number of languages each client speaks , if speaks more than 1 language
SELECT clientID, COUNT(languageID) AS TotalLanguages
FROM LanguagesSpokenByClient
GROUP BY clientID
HAVING COUNT(languageID) > 1;  

--Displays the top 2 owners which speaks as many lamguages as possible and more than 1 language
SELECT TOP 2 ownerID, COUNT(languageID) AS TotalLanguages
FROM LanguagesSpokenByOwner
GROUP BY ownerID
HAVING COUNT(languageID) > 1
ORDER BY COUNT(languageID) DESC;

--Displays the number of bookings every owner has
SELECT ownerID, COUNT(*) AS TotalBookings
FROM Booking
GROUP BY ownerID;

--Displays the number of languages from each proveniece and displays the provenience with at least 2 languages
SELECT  provenience, COUNT(id) AS TotalLanguages
FROM Language
GROUP BY provenience
HAVING count(id) > 1;

--Displays the max and min capacity descending from each location
SELECT TOP 2 location, MIN(capacity) AS MinCapacity, MAX(capacity) AS MaxCapacity
FROM Booking
GROUP BY location
ORDER BY MaxCapacity DESC;

---Display the clients which made a booking with the min capacity
SELECT *
FROM Client
WHERE id = ANY (
    SELECT clientID
    FROM Booking
    WHERE capacity = 2
);

--Rewrited with IN operator and Aggregation ALSO has subquery in form clause
SELECT *
FROM Client
WHERE id IN(
	SELECT ClientId
	FROM Booking
	WHERE capacity = (
		SELECT MIN(capacity)
		FROM Booking
	)
)

--Displays all the languages which are not spoken by the owners
SELECT *
FROM Language
WHERE id NOT IN (
    SELECT languageID
    FROM LanguagesSpokenByOwner
    WHERE ownerID = ANY (
        SELECT id
        FROM OwnerBooking
    )
);

--Rewrited using IN operator
SELECT *
FROM Language
WHERE id NOT IN(
	SELECT languageID
	FROM LanguagesSpokenByOwner
	WHERE ownerID IN(
		SELECT id 
		FROM OwnerBooking
	)
)

--Displays all the languages which are spoken by clients 
SELECT *
FROM Language
WHERE id IN (
    SELECT languageID
    FROM LanguagesSpokenByClient
    WHERE clientID = ANY (
        SELECT id
        FROM Client
    )
)
ORDER BY id desc;

--Rewrited using IN operator
SELECT *
FROM Language
WHERE id IN(
	SELECT LanguageID 
	FROM LanguagesSpokenByClient
	WHERE clientID IN(
		SELECT id
		FROM Client
	)
)
ORDER BY id DESC;

--Displays all the Bookings
SELECT *
FROM Booking
WHERE id = ALL (
    SELECT bookingID
    FROM Review
    WHERE rating < ALL (SELECT rating FROM Review)
);

--Rewrited using the aggregated function
SELECT *
FROM Booking
WHERE id NOT IN (
    SELECT bookingID
    FROM Review
    WHERE rating < (SELECT MIN(rating) FROM Review)
);
 

SELECT DISTINCT Provenience FROM Language
SELECT DISTINCT capacity FROM Booking

--Arithmetic expression
SELECT SUM(capacity) AS TotalCapacity
FROM Booking;

SELECT bookingID,AVG(rating) AS AverageRating
FROM Review
GROUP BY bookingID;

SELECT MAX(rating) - MIN(rating) AS RatingDifference
FROM Review;

