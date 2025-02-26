-- Create a database for a health tracking system. The entities of interest to the problem domain are:
-- Users, Activities, Meals, Health Metrics and User Activities Journal. 
-- A user has a name, an age and a gender. Names are unique. 
-- An activity has a name and a number of calories burned per hour. Names are unique. 
-- A meal has a name and a number of calories per serving. Names are unique. 
-- The system stores data about health metrics: user, date of recording, weight, blood pressure and heart rate. 
-- Users can perform multiple activities. The system will store the date when the activity was performed and the duration (in minutes).
-- 2. Implement a stored procedure that receives the details of a health metric and adds the metric
-- in the database. If the date of recording is in the future (e.g. today is 05-01-2024 and the date of
-- recording for the health metric is 06-01-2024), the system will display an error message and it
-- will not save the health metric in the database.
-- 3. Create a view that displays the average weight and the maximum blood pressure for each user
-- based on the data recorded during the last year (2023).
-- 4. Implement a function that returns the average duration of a specific activity A for a given user
-- U, where A and U are function parameters.

--DELETE TABLES IF THEY EXIST
IF OBJECT_ID('UsersActivites','U') IS NOT NULL
DROP TABLE UsersActivites
IF OBJECT_ID('HealthMetrics','U') IS NOT NULL 
DROP TABLE HealthMetrics
IF OBJECT_ID('Users','U') IS NOT NULL
DROP TABLE Users
IF OBJECT_ID('Meals','U') IS NOT NULL
DROP TABLE Meals
IF OBJECT_ID('Activities','U') IS NOT NULL
DROP TABLE Activities


--CREATING THE TABLES
USE PracticeDatabase
GO

CREATE TABLE Users(
	name varchar(50) PRIMARY KEY,
	age int NOT NULL,
	gender varchar(1) NOT NULL CHECK(gender IN ('F','M','O'))
);

CREATE TABLE Activities(
	name varchar(50) PRIMARY KEY,
	numberCaloriesPerHour int NOT NULL CHECK(numberCaloriesPerHour >= 0),
);

CREATE TABLE Meals(
	name varchar(50) PRIMARY KEY,
	numberCaloriesPerServing int NOT NULL CHECK(numberCaloriesPerServing >= 0),
);

CREATE TABLE HealthMetrics(
	id int PRIMARY KEY,
	userName varchar(50) NOT NULL,
	dateRecording DATE NOT NULL ,
	weight DECIMAL(10,1) NOT NULL CHECK (weight > 0),
	bloodPressure int NOT NULL CHECK(bloodPressure > 0),
	heartRate int NOT NULL CHECK(heartRate > 0),
	FOREIGN KEY(userName) REFERENCES Users(name) ON DELETE CASCADE
);

CREATE TABLE UsersActivites(
	userName varchar(50) NOT NULL,
	activityName varchar(50) NOT NULL,
	dateActivity DATE NOT NULL CHECK (dateActivity <= GETDATE()),
	durationMinutes int NOT NULL CHECK (durationMinutes >= 0),
	PRIMARY KEY(userName, activityName, dateActivity),
	FOREIGN KEY(userName) REFERENCES Users(name) ON DELETE CASCADE,
	FOREIGN KEY(activityName) REFERENCES Activities(name) ON DELETE CASCADE
);
GO

--INSERTING DATA IN THE TABLES
INSERT INTO Users(name,age,gender) VALUES
('u1',20,'F'),
('u2',45,'M'),
('u3',33,'F'),
('u4',76,'F'),
('u5',29,'M');

INSERT INTO Activities(name,numberCaloriesPerHour) VALUES
('a1',85),
('a2',28),
('a3',100),
('a4',54);

INSERT INTO Meals(name , numberCaloriesPerServing) VALUES
('m1',600),
('m2',340),
('m3',760),
('m4',1200);

INSERT INTO UsersActivites(userName,activityName,dateActivity,durationMinutes) VALUES
('u1','a1','2024/12/12',60),
('u1','a2','2024/12/12',87),
('u2','a4','2024/12/12',30),
('u3','a3','2024/12/12',45),
('u3','a1','2024/12/12',60);

GO
-- 2. Implement a stored procedure that receives the details of a health metric and adds the metric
-- in the database. If the date of recording is in the future (e.g. today is 05-01-2024 and the date of
-- recording for the health metric is 06-01-2024), the system will display an error message and it
-- will not save the health metric in the database.

CREATE OR ALTER PROCEDURE addHealthMetric (@id int,@userName varchar(50),@dateRecording DATE,@weight int,@bloodPressure int,@heartRate int)
AS
BEGIN
	IF @dateRecording > GETDATE()
	BEGIN
		PRINT 'ERROR DATE: The date you introduced is in the future'
		RETURN
	END

	INSERT INTO HealthMetrics(id,userName,dateRecording,weight,bloodPressure,heartRate) VALUES (@id,@userName,@dateRecording,@weight,@bloodPressure,@heartRate);

END
GO

EXECUTE addHealthMetric 2,'u1','2024/12/12',33,160,90;
GO
-- 3. Create a view that displays the average weight and the maximum blood pressure for each user
-- based on the data recorded during the last year (2023).

CREATE OR ALTER VIEW averageWeightAndMaximumBloodPressure
AS
	SELECT 
		hm.userName AS userName,
		AVG(weight) AS averageWeight,
		MAX(bloodPressure) AS maxBloodPlesure 
	FROM Users u
	JOIN HealthMetrics hm ON hm.userName = u.name
	WHERE YEAR(hm.dateRecording) = 2023
	GROUP BY(userName)
GO

SELECT * FROM averageWeightAndMaximumBloodPressure
GO

SELECT* FROM UsersActivites
go

-- 4. Implement a function that returns the average duration of a specific activity A for a given user
-- U, where A and U are function parameters.

 CREATE OR ALTER FUNCTION getAverageDurationOfActivityAForUserU (@activityName varchar(50), @userName varchar(50))
 RETURNS TABLE
 AS
 RETURN	
	SELECT AVG(ua.durationMinutes) AS averageDuration FROM
	Users u
	JOIN UsersActivites ua ON  ua.userName = @userName
	JOIN Activities a ON a.name = ua.activityName
	WHERE u.name = @userName AND a.name = @activityName
GO	

SELECT * FROM getAverageDurationOfActivityAForUserU('a1','u1')

