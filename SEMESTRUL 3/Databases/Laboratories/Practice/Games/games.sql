--1. You must create a database that manages cinematics from different games. The purpose of the database is to
--contain all the information about the cinematics of all games and some details about the heroes that appear in cinematics.
	--A) The entities of interest for the problem domani are: Heroes, Cinematics, Games and Companies.
	--B) Each game has a name, a release date and belongs to a company. The company has a name, a description and a website.
	--C) Each cinematic has a name, an associated game and a list of heroes with an entry moment for each hero.
	--The entry moment is represented as an hour/minute/second pair (ex: a hero appears at 00:02:33). Every hero
	--has a name, a description and an importance.

--1) Write a SQL script to create a relational data model in order to represent the required data. (4 points)

--2) Create a store procedure that receives a hero, a cinematic, and an entry moment and adds the new cinematic to
--the hero. If the cinematic already exists, the entry moment is updated. (2 points)

--3) Create a view that shows the name and the importance of all heroes that appear in all cinematics. (1 point)

--4) Create a function that lists the name of the company, the name of the game and the title of the cinematic for all 
--games that have the release date greater than or equal to '2000-12-02' and less than or equal to '2016-01-01'. (2 points)

DROP TABLE Games

CREATE TABLE GamesCompanies(
	CID int PRIMARY KEY,
	CName varchar(50),
	description varchar(50),
	website varchar(50)
)

CREATE TABLE Games(
	GID int PRIMARY KEY,
	GName varchar(50),
	GDate DATE,
	company_id int,
	FOREIGN KEY(company_id) REFERENCES GamesCompanies(CID)
)

CREATE TABLE Cinematics(
	CIID int PRIMARY KEY,
	CIName varchar(50),
	game_id int ,
	FOREIGN KEY(game_id) REFERENCES Games(GID)
)

CREATE TABLE Heroes(
	HID int PRIMARY  KEY,
	HName varchar(50),
	description varchar(50),
	importance varchar(50)
)

CREATE TABLE HeroesCinematics(
	hero_id int,
	cinematic_id int,
	entry_moment TIME,
	FOREIGN KEY(hero_id) REFERENCES Heroes(HID),
	FOREIGN KEY(cinematic_id) REFERENCES Cinematics(CIID)
)
GO
--INSERTING DATA

INSERT INTO GamesCompanies(CID,CName,description,website) VALUES
(1,'gc1','d1','web1'),
(2,'gc2','d2','web2'),
(3,'gc3','d3','web3'),
(4,'gc4','d4','web4');

INSERT INTO Games(GID,GName,GDate,company_id) VALUES
(1,'game1','2024/12/12',1),
(2,'game2','2024/12/12',1),
(3,'game3','2024/12/12',2),
(4,'game4','2024/12/12',3),
(5,'game5','2024/12/12',2);

INSERT INTO Cinematics(CIID,CIName,game_id) VALUES
(1,'cinema1',2),
(2,'cinema2',1),
(3,'cinema3',2),
(4,'cinema4',3);

INSERT INTO Heroes(HID,HName,description,importance) VALUES
(1,'hero1','d1','imp1'),
(2,'hero2','d2','imp2'),
(3,'hero3','d3','imp3'),
(4,'hero4','d4','imp4');
GO

--2) Create a store procedure that receives a hero, a cinematic, and an entry moment and adds the new cinematic to
--the hero. If the cinematic already exists, the entry moment is updated. (2 points)

CREATE OR ALTER PROCEDURE addHeroCinematic(@heroID int , @cinematicID int , @entry TIME)
AS
BEGIN
	IF EXISTS(
		SELECT 1 FROM HeroesCinematics 
		WHERE hero_id =@heroID and cinematic_id = @cinematicID
	)
	BEGIN
		PRINT 'The hero already has this cinematic.Updating the entry moment...'
		UPDATE HeroesCinematics
		SET entry_moment = @entry
		WHERE hero_id =@heroID and cinematic_id = @cinematicID
		RETURN
	END

	INSERT INTO HeroesCinematics(hero_id,cinematic_id,entry_moment) VALUES (@heroID,@cinematicID,@entry)
END
GO

EXECUTE addHeroCinematic 1,2,'10:20:13';

SELECT * FROM HeroesCinematics

--3) Create a view that shows the name and the importance of all heroes that appear in all cinematics. (1 point)
  