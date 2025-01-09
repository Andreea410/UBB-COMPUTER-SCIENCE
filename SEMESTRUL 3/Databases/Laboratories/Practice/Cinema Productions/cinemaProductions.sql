USE PracticeDatabase

CREATE TABLE Companies(
	cid int PRIMARY KEY,
	cname varchar(50)
);

CREATE TABLE StageDirectors(
	did int PRIMARY KEY,
	dname varchar(50),
	nr_awards int
);

CREATE TABLE Movies(
	mid int PRIMARY KEY , 
	mname varchar(50),
	release_date DATE , 
	director_id int,
	FOREIGN KEY(director_id) REFERENCES StageDirectors(did)
);

CREATE TABLE CinemaProductions(
	pid int PRIMARY KEY,
	title varchar(50),
	movie_id int,
	FOREIGN KEY(movie_id) REFERENCES Movies(mid)
);

CREATE TABLE Actors(
	aid int PRIMARY KEY,
	aname varchar(50),
	ranking DECIMAL(10,2)
);

CREATE TABLE CinemaProductionActors(
	actor_id int,
	cinema_prod_id int,
	entry_moment DATETIME,
	PRIMARY KEY(actor_id,cinema_prod_id),
	FOREIGN KEY(actor_id) REFERENCES Actors(aid),
	FOREIGN KEY(cinema_prod_id) REFERENCES CinemaProductions(pid)
)
GO
--INSERTING DATA
INSERT INTO Companies(cid,cname) VALUES
(1,'company1'),
(2,'company2'),
(3,'company3'),
(4,'company4');
INSERT INTO StageDirectors(did,dname,nr_awards) VALUES
(1,'director1',10),
(2,'director2',8),
(3,'director3',2),
(4,'director4',9),
(5,'director5',0);
INSERT INTO Movies(mid,mname,release_date,director_id) VALUES
(1,'movie1','2024/12/12',1),
(2,'movie2','2024/12/12',1),
(3,'movie3','2024/12/12',2),
(4,'movie4','2024/12/12',3),
(5,'movie5','2024/12/12',2);
INSERT INTO CinemaProductions(pid,title,movie_id) VALUES
(1,'cinema1',1),
(2,'cinema2',1),
(3,'cinema3',2),
(4,'cinema4',2),
(5,'cinema5',1),
(6,'cinema6',3);

INSERT INTO Actors(aid,aname,ranking) VALUES
(1,'actor1',5.00),
(2,'actor2',3.00),
(3,'actor3',4.32),
(4,'actor4',4.12);

GO

CREATE OR ALTER PROCEDURE addNewActor(@actorID int,@cinema_prod_id int,@entryMoment DATETIME)
AS
BEGIN
	IF EXISTS(
		SELECT 1 FROM CinemaProductionActors 
		WHERE actor_id = @actorID AND cinema_prod_id = @cinema_prod_id
	)
	BEGIN
		PRINT 'The actor already belongs to the cinema production'
		RETURN
	END

	INSERT INTO CinemaProductionActors(actor_id,cinema_prod_id,entry_moment) VALUES (@actorID,@cinema_prod_id,@entryMoment);
END

EXECUTE addNewActor 1,6,'2024/12/12 12:30'
SELECT * FROM CinemaProductionActors
GO

CREATE OR ALTER VIEW showNameOfActors 
AS
	SELECT a.aname AS ActorName FROM Actors a
	INNER JOIN CinemaProductionActors cpa ON cpa.actor_id = a.aid
	INNER JOIN CinemaProductions cp ON cpa.cinema_prod_id = cp.pid
	GROUP BY a.aname
	HAVING COUNT(cpa.cinema_prod_id) = (SELECT COUNT(*) FROM CinemaProductions)
GO

select * from showNameOfActors
GO

CREATE OR ALTER FUNCTION getMovies(@P int)
RETURNS TABLE
AS
RETURN 
	SELECT m.mid,m.mname,m.release_date ,COUNT(DISTINCT cp.pid) AS countCinemaProd FROM Movies m 
	INNER JOIN CinemaProductions cp ON cp.movie_id = m.mid
	GROUP BY m.mid,m.mname,m.release_date
	HAVING COUNT(DISTINCT cp.pid) >=  @P AND m.release_date > '2018/01/01'
GO

SELECT * FROM getMovies(0)