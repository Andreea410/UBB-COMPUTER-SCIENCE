USE Practic

CREATE TABLE VideoTypes(
	vid int PRIMARY KEY,
	vname varchar(50) UNIQUE
);

CREATE TABLE Artists(
	aid int PRIMARY KEY,
	aname varchar(50),
	country varchar(50),
	birthday DATE
);

CREATE TABLE Accounts(
	accid int PRIMARY KEY,
	username varchar(50),
	email_address varchar(50)
);

CREATE TABLE Videos(
	vidid int PRIMARY KEY,
	description varchar(50),
	upload_time TIME,
	flag int,
	artist_id int,
	account_id int,
	videotypeid int,
	FOREiGN KEY(artist_id) REFERENCES Artists(aid),
	FOREiGN KEY(account_id) REFERENCES Accounts(accid),
	FOREIGN KEY(videotypeid) REFERENCES VideoTypes(vid)
);


CREATE TABLE Playlists(
	pid int PRIMARY KEY,
	pname varchar(50),
	artist_id int,
	account_id int,
	FOREiGN KEY(artist_id) REFERENCES Artists(aid),
	FOREiGN KEY(account_id) REFERENCES Accounts(accid)

);

CREATE TABLE VideosPlaylists(
	playlist_id int,
	video_id int,
	date_of_adding DATE,
	time_adding TIME,
	PRIMARY KEY(playlist_id,video_id),
	FOREiGN KEY(playlist_id) REFERENCES Playlists(pid),
	FOREiGN KEY(video_id) REFERENCES Videos(vidid)
);

DROP TABLE Videos
DROP TABLE Playlists

--INSERTING VALUES
INSERT INTO VideoTypes(vid,vname) VALUES
(1,'type1'),
(2,'type2'),
(3,'type3');
INSERT INTO Artists(aid,aname,country,birthday) VALUES
(1,'art1','rom','2024/12/12'),
(2,'art2','rom','2024/12/12'),
(3,'art3','rom','2024/12/12'),
(4,'art4','rom','2024/12/12'),
(5,'art5','rom','2024/12/12');

INSERT INTO Accounts(accid,username,email_address) VALUES
(1,'user1','@gamil'),
(2,'user2','@gamil'),
(3,'user3','@gamil'),
(4,'user4','@gamil');

INSERT INTO Videos(vidid , description , upload_time,flag,artist_id,account_id,videotypeid) VALUES
(1,'vid1','12:00',1,1,NULL,1),
(2,'vid2','13:00',0,NULL,1,2),
(3,'vid3','14:00',1,2,NULL,1),
(4,'vid4','15:00',1,NULL,2,3);

INSERT INTO Playlists(pid,pname,artist_id,account_id) VALUES
(1,'play1',1,NULL),
(2,'play2',2,NULL),
(3,'play3',	NULL,1),
(4,'play4',NULL,2);
GO

SELECT * FROM Playlists




CREATE OR ALTER PROCEDURE addVideoToPlaylist(@videoid int , @playlistID int , @date DATE , @time TIME) 
AS 
BEGIN
	IF EXISTS(
		SELECT 1 FROM VideosPlaylists
		WHERE video_id = @videoid AND playlist_id = @playlistID
	)
	BEGIN
		PRINT 'The video already exists in the playlist'
		UPDATE VideosPlaylists
		SET date_of_adding = @date , time_adding = @time
		WHERE video_id = @videoid AND playlist_id = @playlistID
		RETURN
	END

	INSERT INTO VideosPlaylists(video_id,playlist_id,date_of_adding,time_adding) VALUES (@videoid,@playlistID,@date , @time)

END
GO
EXECUTE addVideoToPlaylist 2,4,'2024/12/12','14:00'
SELECT * FROM VideosPlaylists


CREATE OR ALTER VIEW getArtists AS
SELECT 
    a.aname AS ArtistName
FROM Artists a
INNER JOIN Videos v ON v.artist_id = a.aid
WHERE v.flag = 1
GROUP BY a.aname
HAVING COUNT(v.vidid) = (
    SELECT MAX(live_videos)
    FROM (
        SELECT COUNT(v.vidid) AS live_videos
        FROM Videos
        WHERE flag = 1
        GROUP BY artist_id
    ) AS subq
);

SELECT * FROM getArtists
GO

CREATE OR ALTER FUNCTION getNumberOfAccounts(@R int)
RETURNS INT
AS
BEGIN
	DECLARE @output int
	SET @output = (SELECT COUNT(a.accid) AS totalCount FROM Accounts a 
					INNER JOIN Playlists p ON p.account_id = a.accid
					INNER JOIN VideosPlaylists vp ON vp.playlist_id = p.pid
					GROUP BY a.accid
					HAVING COUNT(Distinct vp.videotypeid) > 2
					)
	RETURN @output
END
