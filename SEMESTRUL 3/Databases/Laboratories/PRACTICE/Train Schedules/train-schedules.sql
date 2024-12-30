/*Model for the practical exam

Create a database to manage train schedules. The database will store data about the routes of
all the trains. The entities of interest to the problem domain are: Trains, Train Types, Stations,
and Routes. Each train has a name and belongs to a type. The train type has only a description.
Each station has a name. Station names are unique. Each route has a name, an associated train,
and a list of stations with arrival and departure times in each station. Route names are unique.
The arrival and departure times are represented as hour:minute pairs, e.g., train arrives at 5pm
and leaves at 5:10pm.
1) Write an SQL script that creates the corresponding relational data model. (4p)
2) Implement a stored procedure that receives a route, a station, arrival and departure times,
and adds the station to the route. If the station is already on the route, the arrival and departure
times are updated. (1p)
3) Create a view that shows the names of the routes that pass through all the stations. (2p)
4) Implement a function that lists the names of the stations with more than R routes, where R>=1
is a function parameter. (2 points)
(1p of)
*/

USE TrainSchedules

--DROP TABLES IF THEY EXIST
IF OBJECT_ID('RouteStation','U') IS NOT NULL
	DROP TABLE RouteStation;
IF OBJECT_ID('Route','U') IS NOT NULL
	DROP TABLE Route;
IF OBJECT_ID('Station','U') IS NOT NULL
	DROP TABLE Station;
IF OBJECT_ID('Train','U') IS NOT NULL
	DROP TABLE Train;
IF OBJECT_ID('TrainType','U') IS NOT NULL
	DROP TABLE TrainType;

--CREATE TABLES
CREATE TABLE TrainType(
	description varchar(50) PRIMARY KEY
);

CREATE TABLE Train(
	name varchar(50) PRIMARY KEY,
	train_type varchar(50) NOT NULL,
	FOREIGN KEY(train_type) REFERENCES TrainType(description)
);

CREATE TABLE Station(
	name varchar(50) PRIMARY KEY
);

CREATE TABLE Route(
	name varchar(50) PRIMARY KEY,
	trainName varchar(50),
	FOREIGN KEY(trainName) REFERENCES Train(name)
);

CREATE TABLE RouteStation(
	id int PRIMARY KEY IDENTITY(1,1),
	routeName varchar(50),
	stationName varchar(50),
	departureTime TIME,
	arrivalTime TIME,
	FOREIGN KEY(routeName) REFERENCES Route(name),
	FOREIGN KEY(stationName) REFERENCES Station(name)
);

GO


--2) Implement a stored procedure that receives a route, a station, arrival and departure times,
--and adds the station to the route. If the station is already on the route, the arrival and departure
--times are updated. (1p)
CREATE OR ALTER PROCEDURE addStationToRoute(@route varchar(50),@station varchar(50),@arrival TIME , @departure TIME) AS
BEGIN

	--Verify if route exists
	IF NOT EXISTS(
		SELECT 1
		FROM Route WHERE name = @route
	)
	BEGIN
		PRINT 'The route does not exist'
		RETURN
	END

	--Verify if station exists
	IF NOT EXISTS(
	SELECT 1
	FROM Station WHERE name = @station
	)
	BEGIN
		PRINT 'The station does not exist'
		RETURN
	END

	--Verify if station already on the route
	IF EXISTS(
		SELECT 1
		FROM RouteStation WHERE routeName = @route AND stationName = @station
	)
	BEGIN
		PRINT 'The route already exists.We will update the arrival and departure time'
		--Update arrival and departure time
		UPDATE RouteStation
		SET arrivalTime = @arrival , departureTime = @departure
		WHERE routeName = @route AND stationName = @station
		RETURN
	END

	--Insert values into the table
	INSERT INTO RouteStation(routeName,stationName,departureTime,arrivalTime) VALUES (@route,@station,@arrival,@departure)
END
GO

INSERT INTO TrainType(description) VALUES
('Long-Distance'),
('High-Speed'),
('International night');


INSERT INTO Train(name , train_type) VALUES
('EuroNight','International night'),
('Railjet','Long-Distance'),
('Intercity-Express','Long-Distance');

INSERT INTO Station(name) VALUES
('Razboieni'),
('Unirea halta'),
('Aiud'),
('Cluj-Napoca');

INSERT INTO Route(name,trainName) VALUES
('Cluj Napoca-Teius','Railjet'),
('Cluj Napoca-Sighisoara','Intercity-Express'),
('Cluj Napoca-Aiud','Railjet'),
('Cluj Napoca-Unirea','Railjet'),
('Sibiu-Cluj Napoca','EuroNight');

INSERT INTO RouteStation(routeName,stationName,departureTime,arrivalTime) VALUES
('Cluj Napoca-Teius','Razboieni','16:00','17:39'),
('Cluj Napoca-Teius','Aiud','16:00','17:12'),
('Cluj Napoca-Sighisoara','Unirea halta','16:00','17:51'),
('Cluj Napoca-Aiud','Aiud','16:00','18:30');

SELECT * FROM RouteStation;

execute addStationToRoute 'Cluj Napoca-Teius','Razboieni','20:39','18:00';
execute addStationToRoute 'Sibiu-Cluj Napoca','Aiud','10:12','12:45';
execute addStationToRoute 'Cluj Napoca-Teius','Unirea halta','20:48','18:00';
execute addStationToRoute 'Cluj Napoca-Teius','Cluj-Napoca','21:45','18:00';


GO

--3) Create a view that shows the names of the routes that pass through all the stations. (2p)
CREATE OR ALTER VIEW showRoutesPassingAllStations AS
	SELECT r.name AS routeName
	FROM Route r
	JOIN RouteStation rs ON r.name = rs.routeName	
	JOIN Station s ON rs.stationName = s.name
	GROUP BY r.name
	HAVING COUNT(DISTINCT s.name) = (SELECT COUNT(*) FROM Station);

GO

SELECT * FROM showRoutesPassingAllStations;
GO

--4) Implement a function that lists the names of the stations with more than R routes, where R>=1
--is a function parameter. (2 points)

CREATE OR ALTER FUNCTION getStationWithMoreThanRRoutes(@R int)
RETURNS TABLE
AS
RETURN
	SELECT s.name AS stationName
	FROM Station s
	JOIN RouteStation rs on s.name = rs.stationName
	JOIN Route r on r.name = rs.routeName
	GROUP BY s.name
	HAVING COUNT(DISTINCT r.name) > @R;
GO

SELECT * FROM getStationWithMoreThanRRoutes(1);
GO