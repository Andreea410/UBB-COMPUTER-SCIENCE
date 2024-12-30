
--Create tables
CREATE TABLE Director(
	name varchar(50) PRIMARY KEY,
	numberAwards int NOT NULL
);

CREATE TABLE Company(
	id int PRIMARY KEY,
	name varchar(50) NOT NULL
);

CREATE TABLE Actor(
	name varchar(50) PRIMARY KEY,
	ranking decimal(10,2) 
);

CREATE TABLE Movie(
	name varchar(50) PRIMARY KEY,
	releaseDate DATE,
	companyID int,
	directorName varchar(50),
	FOREIGN KEY(companyID) REFERENCES Company(id), 
	FOREIGN KEY(directorName) REFERENCES Director(name) 
);

CREATE TABLE Production(
	title varchar(50) PRIMARY KEY,
	movieName varchar(50) NOT NULL,
	FOREIGN KEY(movieName) REFERENCES Movie(name) 
);

CREATE TABLE ProductionActor(
	actorName varchar(50),
	productionTitle varchar(50),
	entryMoment varchar(50),
	PRIMARY KEY(actorName , productionTitle),
	FOREIGN KEY(actorName) REFERENCES Actor(name),
	FOREIGN KEY(productionTitle) REFERENCES Production(title)
);

GO

--INSERT DATA
INSERT INTO Director(name , numberAwards) VALUES
('d1',10),
('d2',5),
('d3',2),
('d4',18);

INSERT INTO Company(id,name) VALUES
(1,'c1'),
(2,'c2'),
(3,'c3'),
(4,'c4');

INSERT INTO Actor(name,ranking) VALUES
('a1',5.00),
('a2',4.98),
('a3',3.65),
('a4',5.00);

INSERT INTO Movie(name , releaseDate,companyID,directorName) VALUES
('m1','2024-12-12',1,'d1'),
('m2','2024-12-12',1,'d3'),
('m3','2024-12-12',2,'d2'),
('m4','2024-12-12',3,'d1');


INSERT INTO Production(title,movieName) VALUES
('p1','m1'),
('p2','m2'),
('p3','m1'),
('p4','m4');
GO

--Create a sorted procedure that receives an actor , an entry moment and a cinema production
-- and adds the new actor to the cinema production

CREATE OR ALTER PROCEDURE addActorToProduction(@actor varchar(50),@entry varchar(50),@title varchar(50)) AS
BEGIN
	IF NOT EXISTS(
		SELECT 1
		FROM Actor
		WHERE name = @actor
	)
	BEGIN
		PRINT 'Actor does not exist'
		RETURN
	END

	IF NOT EXISTS(
		SELECT 1
		FROM Production
		WHERE title = @title
	)
	BEGIN
		PRINT 'Production does not exist'
		RETURN
	END

	IF EXISTS 
	(
		SELECT 1 FROM ProductionActor
		WHERE actorName = @actor AND productionTitle = @title
	)
	BEGIN
		PRINT 'This combo already exists'
		RETURN
	END

	INSERT INTO ProductionActor(actorName,productionTitle,entryMoment) VALUES (@actor,@title,@entry)
END
GO

EXECUTE addActorToProduction 'a1','','p4';
SELECT * FROM ProductionActor;
GO

--Create a view that shows the name of the actors that appear in all cinema productions
CREATE OR ALTER VIEW showActorsThatAppearInAllProductions
AS
	SELECT name FROM Actor a
	JOIN ProductionActor pa on a.name = pa.actorName
	JOIN Production p on p.title = pa.productionTitle
	GROUP BY a.name
	HAVING COUNT(DISTINCT pa.productionTitle) = (SELECT COUNT(*) FROM Production)
GO

SELECT * FROM showActorsThatAppearInAllProductions;
GO
--Create a function that returns all movies that have the release date after '2018-01-01' and have 
-- at least p productions where p is a function parameter

CREATE OR ALTER FUNCTION moviesThatHaveAtLeastPProductions(@P int)
RETURNS TABLE
AS
RETURN
	SELECT m.name,m.releaseDate FROM Movie m
	JOIN Production p ON p.movieName = m.name 
	GROUP BY m.name , m.releaseDate
	HAVING COUNT(DISTINCT p.title) > @P AND m.releaseDate > '2018-01-01'
GO

SELECT * FROM moviesThatHaveAtLeastPProductions(1)
