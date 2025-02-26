-- Create a database for the Spotify application. The entities of interest to the problem domain are:
-- Songs, Artists, Accounts and Playlists. 
-- Each song has a name, duration in minutes and release date. Duration must be greater than 0 and lower than 20. 
-- An artist has a name, country of origin and date of birth. 
-- Each song can have one main artist and multiple featuring artists. An account has a username and email address. Usernames must be unique.
--  Both artists and users (accounts) can create playlists. One playlist contains multiple songs and has a name.

USE PracticeDatabase

CREATE TABLE Artists(
	id int PRIMARY KEY,
	name varchar(50) NOT NULL,
	countryOrigin varchar(50) NOT NULL,
	birthday DATE NOT NULL
);


CREATE TABLE Songs(
	id int PRIMARY KEY,
	name varchar(50) NOT NULL,
	durationMinutes int NOT NULL CHECK (0< durationMinutes and durationMinutes <20),
	releaseDate DATE NOT NULL,
	mainArtistID int,
	FOREIGN KEY(mainArtistID) REFERENCES Artists(id)
);

CREATE TABLE FeaturingArtists(
	artistID int,
	songID int,
	FOREIGN KEY(artistID) REFERENCES Artists(id),
	FOREIGN KEY(songID) REFERENCES Songs(id)
);

CREATE TABLE Accounts(
	id int PRIMARY KEY,
	username varchar(50) NOT NULL UNIQUE,
	emailAddress varchar(50) NOT NULL
);

CREATE TABLE Playlists(
	id int PRIMARY KEY,
	name varchar(50) NOT NULL,
	artistID int,
	accountID int,
	FOREIGN KEY(artistID) REFERENCES Artists(id),
	FOREIGN KEY(accountID) REFERENCES Accounts(id)
)

CREATE TABLE PlaylistSongs(
	songID int,
	playlistID int,
	FOREIGN KEY(playlistID) REFERENCES Playlists(id),
	FOREIGN KEY(songID) REFERENCES Songs(id)
)
GO

--INSERTING DATA
INSERT INTO Artists(id,name,countryOrigin,birthday) VALUES
(1,'a1','c1','2024/12/12'),
(2,'a2','c2','2024/12/12'),
(3,'a3','c1','2024/12/12'),
(4,'a4','c3','2024/12/12');

INSERT INTO Songs(id,name,durationMinutes,releaseDate,mainArtistID) VALUES
(1,'s1',3,'2024/12/15',1),
(2,'s2',6,'2024/12/15',2),
(3,'s3',3,'2024/12/15',2),
(4,'s4',1,'2024/12/15',3);

INSERT INTO FeaturingArtists(artistID,songID) VALUES
(1,2),
(4,2),
(3,1);

INSERT INTO Playlists(id,name,artistID,accountID) VALUES
(1,'p1',1,NULL),
(2,'p2',2,2),
(3,'p3',3,1),
(4,'p4',3,2);

INSERT INTO PlaylistSongs(songID,playlistID) VALUES
(1,3),
(2,3),
(4,3),
(2,2),
(3,2),
(3,3);


GO
-- 2. Implement a stored procedure that receives details of an account and stores the account in the database.
CREATE OR ALTER PROCEDURE addAccount(@id int , @username varchar(50),@email varchar(50))
AS 
BEGIN
	IF EXISTS(
		SELECT 1 FROM Accounts
		WHERE id = @id
	)
	BEGIN
		PRINT 'There already exists an account with this id'
		RETURN
	END

	IF EXISTS(
		SELECT 1 FROM Accounts
		WHERE username = @username
	)
	BEGIN
		PRINT 'There already exists an account with this username'
		RETURN
	END

	INSERT INTO Accounts(id,username,emailAddress) VALUES (@id,@username,@email)
END

EXECUTE addAccount 3,'a3','email3';
GO

-- 3. Create a view that shows the names of the playlists that contain the most songs.

CREATE OR ALTER VIEW getPlaylistWithMostSongs
AS
	SELECT TOP 1 P.id AS PlaylistID , COUNT(songID) AS NumberSongs 
	FROM Playlists p 
	INNER JOIN PlaylistSongs ps ON ps.playlistID = p.id
	GROUP BY (P.id) 
	ORDER BY NumberSongs desc
GO
	
SELECT * FROM getPlaylistWithMostSongs;
GO

-- 4. Implement a function that returns the number of artists that have created more than R playlists that have a total duration greater than T,
--where R and T are function parameters.

CREATE OR ALTER FUNCTION getNrArtists (@R int , @T int)
RETURNS INT
AS
BEGIN
	DECLARE @count int
	SET @count = 
	(	
		SELECT COUNT(DISTINCT p.id) AS playlistCount FROM Playlists p
		JOIN PlaylistSongs ps ON ps.playlistID = p.id
		JOIN Songs s ON s.id = ps.songID
		GROUP BY (P.id) 
		HAVING COUNT(DISTINCT p.id) > @R
			AND SUM(s.durationMinutes) > @T
	)
	RETURN @count
END
GO

SELECT dbo.getNrArtists(1, 1) AS ArtistCount;

