-- Create a database for managing the 2023 Rugby World Cup. The entities of interest to the problem
-- domain are: Cities, Stadiums, National Teams, Players, Coaches and Games. Cities have a name.
-- Names must be unique. Stadiums have a name and belong to a city. National teams belong to a
-- country and have a list of players and a list of coaches. There can be only one national team per
-- country. Players have a name, birth date, nationality, position and a flag indicating if the player is
-- captain. Coaches have a name and nationality. The system stores information about all the games
-- played during the World Cup: the date, the two teams involved, stadium, final score, winner and a
-- flag indicating if the final score was decided in overtime.
-- 1. Write a SQL script that creates the corresponding relational data model.
-- 2. Implement a stored procedure that receives the details of a game and stores the game in the
-- database. If the two teams already played against each other on the same date, then the final score is
-- updated.
-- 3. Create a view that shows the names of the stadiums where all games played were decided in
-- overtime.
-- 4. Implement a function that returns the number of teams that won all the games played on a
-- stadium S with a score difference greater than R. where S and R are function parameters.

IF OBJECT_ID('Games','U') IS NOT NULL
DROP TABLE Games
IF OBJECT_ID('Coaches','U') IS NOT NULL
DROP TABLE Coaches
IF OBJECT_ID('Players','U') IS NOT NULL
DROP TABLE Players
IF OBJECT_ID('Stadiums','U') IS NOT NULL
DROP TABLE Stadiums
IF OBJECT_ID('Cities','U') IS NOT NULL
DROP TABLE Cities
IF OBJECT_ID('NationalTeams','U') IS NOT NULL
DROP TABLE NationalTeams


--CREATE TABLES
CREATE TABLE Cities
(
	cityName varchar(50) PRIMARY KEY
);

CREATE TABLE Stadiums(
	stadiumName varchar(50) PRIMARY KEY,
	cityName varchar(50),
	FOREIGN KEY(cityName) REFERENCES Cities(cityName) ON DELETE CASCADE
);

CREATE TABLE NationalTeams(
	nationalTeamID int PRIMARY KEY,
	country VARCHAR(50) UNIQUE
)

CREATE TABLE Players(
	name varchar(50) PRIMARY KEY,
	birthday DATE NOT NULL,
	nationality VARCHAR(50) NOT NULL,
	position varchar(50) NOT NULL,
	flag INT CHECK(flag IN (0,1)),
	nationalTeamID int,
	FOREIGN KEY(nationalTeamID) REFERENCES NationalTeams(nationalTeamID)
);

CREATE TABLE Coaches(
	name varchar(50) PRIMARY KEY,
	nationality varchar(50) NOT NULL,
	nationalTeamID int,
	FOREIGN KEY(nationalTeamID) REFERENCES NationalTeams(nationalTeamID),

);

CREATE TABLE Games (
    id INT PRIMARY KEY,
    team1_id INT NOT NULL,
    team2_id INT NOT NULL,
    date DATE NOT NULL,
    score VARCHAR(10) NOT NULL,
    winner INT NOT NULL,
    flag INT DEFAULT 0 CHECK(flag IN (0, 1)),
    stadium_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (team1_id) REFERENCES NationalTeams(nationalTeamID),
    FOREIGN KEY (team2_id) REFERENCES NationalTeams(nationalTeamID),
    FOREIGN KEY (winner) REFERENCES NationalTeams(nationalTeamID),
    FOREIGN KEY (stadium_name) REFERENCES Stadiums(stadiumName)
);


--INSERT DATA
INSERT INTO Cities(cityName) VALUES
('c1'),
('c2'),
('c3'),
('c4');

INSERT INTO Stadiums(stadiumName,cityName) VALUES
('s1','c1'),
('s2','c2'),
('s3','c1'),
('s4','c3');

INSERT INTO NationalTeams(nationalTeamID,country) VALUES
(1,'co1'),
(2,'co2'),
(3,'co3'),
(4,'co4');

INSERT INTO Players(name,birthday,nationality,position,flag,nationalTeamID) VALUES
('p1','2024/12/12','n1','atacant',1,1),
('p2','2024/12/12','n2','atacant',1,2),
('p3','2024/12/12','n1','fundas',0,1),
('p4','2024/12/12','n2','fundas',0,1),
('p5','2024/12/12','n3','mijlocas',0,1),
('p6','2024/12/12','n3','atacant',0,2),
('p7','2024/12/12','n3','atacant',0,3);

INSERT INTO Coaches(name,nationality,nationalTeamID) VALUES
('coach1','n1',1),
('coach2','n2',2),
('coach3','n3',3);

GO
-- 2. Implement a stored procedure that receives the details of a game and stores the game in the
-- database. If the two teams already played against each other on the same date, then the final score is
-- updated.

CREATE OR ALTER PROCEDURE AddGame(@id int , @team1ID int , @team2ID int , @date DATE , @score varchar(10), @winner int,@flag int, @stadiumName varchar(50))
AS
BEGIN
	IF EXISTS(
		SELECT 1 FROM Games
		WHERE team1_ID = @team1ID AND team2_id = @team2ID AND date = @date
	)
	BEGIN
		PRINT 'Updating the score'
		UPDATE Games
		SET score = @score
		WHERE team1_id = @team1ID AND team2_ID = @team2ID AND date = @date
		RETURN
	END

	INSERT INTO Games(id,team1_ID,team2_ID,date,score,winner,flag,stadium_name) VALUES (@id,@team1ID,@team2ID,@date,@score,@winner,@flag,@stadiumName) 
END

EXECUTE AddGame 2, 2,3,'2024/12/27','2:2',2,1,'s1';
GO

-- 3. Create a view that shows the names of the stadiums where all games played were decided in
-- overtime.

CREATE VIEW ShowAllStadiumsInOverTime AS
	SELECT s.stadiumName 
	FROM Stadiums s
	JOIN Games g ON g.stadium_name = s.stadiumName
	WHERE g.flag = 1
	GROUP BY (s.stadiumName)
GO

SELECT * FROM ShowAllStadiumsInOverTime
GO
-- 4. Implement a function that returns the number of teams that won all the games played on a
-- stadium S with a score difference greater than R. where S and R are function parameters.

CREATE OR ALTER FUNCTION getNumberTeams(@S varchar(50),@R int)
RETURNS INT
AS
BEGIN
	DECLARE @count int
	SET @count = (SELECT Count(DISTINCT g.winner) FROM Games g 
	WHERE g.stadium_name = @S
	AND ABS(CONVERT(INT, SUBSTRING(G.score, 1, CHARINDEX('-', G.score) - 1)) -
              CONVERT(INT, SUBSTRING(G.score, CHARINDEX('-', g.score) + 1, LEN(g.score)))) > @R
			  )
	RETURN @count
END

