USE PracticeDatabase

CREATE TABLE Categories(
	cid int PRIMARY KEY,
	cname varchar(50) UNIQUE,
	cdescription varchar(50)
);

CREATE TABLE Locations(
	lid int PRIMARY KEY,
	lname varchar(50) UNIQUE ,
	ldescription varchar(50)
);

CREATE TABLE Plants(
	pid int PRIMARY KEY,
	pname varchar(50) UNIQUE,
	pdescription varchar(50),
	acquisition_date DATE,
	least_watered DATE,
	location_id int,
	FOREIGN KEY(location_id) REFERENCES Locations(lid)
);

CREATE TABLE Images(
	iid int PRIMARY KEY,
	image_path varchar(50),
	caption varchar(50),
	upload_date DATE,
	plant_id int,
	FOREIGN KEY(plant_id) REFERENCES Plants(pid)
);

CREATE TABLE CategoryPlants(
	category_id int,
	plant_id int,
	PRIMARY KEY(category_id,plant_id),
	FOREIGN KEY(plant_id) REFERENCES Plants(pid),
	FOREIGN KEY(category_id) REFERENCES Categories(cid)
);

--INSERTINT DATA
INSERT INTO Categories(cid,cname,cdescription) VALUES
(1,'category1','d1'),
(2,'category2','d2'),
(3,'category3','d3'),
(4,'category4','d4'),
(5,'category5','d5');

INSERT INTO Locations(lid,lname,ldescription) VALUES
(1,'location1','desc1'),
(2,'location2','desc2'),
(3,'location3','desc3'),
(4,'location4','desc4');

DELETE FROM Plants
INSERT INTO Plants(pid,pname,pdescription,acquisition_date,least_watered,location_id) VALUES
(1,'plant1','de1','2024/11/20','2024/12/30',1),
(2,'plant2','de2','2024/12/31','2024/12/12',1),
(3,'plant3','de3','2024/12/12','2024/12/12',2),
(4,'plant4','de4','2024/12/21','2025/01/01',3),
(5,'plant5','de5','2024/10/1','2024/12/12',2);

DELETE FROM Images
INSERT INTO Images(iid,image_path,caption,upload_date,plant_id) VALUES
(1,'path1','c1','2024/12/12',1),
(2,'path2','c2','2024/12/12',1),
(3,'path3','c3','2024/12/12',2),
(4,'path4','c4','2024/12/12',2),
(5,'path5','c5','2024/12/12',3);

DELETE FROM CategoryPlants
INSERT INTO CategoryPlants(category_id,plant_id) VALUES
(1,1),
(1,2),
(2,3),
(2,1),
(3,4);

GO

CREATE OR ALTER PROCEDURE addPlant(@plantName varchar(50),
@plantDescription varchar(50),
@acqdate DATE , @lastWatered DATE,@location int)
AS
BEGIN
	IF EXISTS(
		SELECT 1 FROM Plants
		WHERE pname = @plantName
	)
	BEGIN
		PRINT 'A plant with the same name already exists in the database'
		RETURN
	END

	DECLARE @id int
	SET @id = (SELECT Max(pid) FROM Plants) + 1
	IF @id IS NULL
		SET @id = 1

	INSERT INTO Plants(pid,pname,pdescription,acquisition_date,least_watered,location_id) VALUES (@id,@plantName,@plantDescription,@acqdate,@lastWatered,@location)

END
GO

SELECT * FROM Plants
EXECUTE addPlant 'plant10','','2024/12/12','2024/12/12',2
GO

CREATE OR ALTER VIEW getTotalPlantsAndLeastAcquisitionDate
AS
	SELECT COUNT(p.pid) AS NumberPlants , l.lid AS LocationID, Max(acquisition_date) AS LatestAcquisitonDate  FROM Plants p
	INNER JOIN Locations l ON p.location_id = l.lid
	GROUP BY l.lid
	--HAVING acquisition_date = (SELECT MAX(acquisition_date) FROM Plants
		--						WHERE location_id = l.lid)
GO
SELECT * FROM getTotalPlantsAndLeastAcquisitionDate
GO

CREATE OR ALTER FUNCTION getPlantWIthMininimumXImages(@X int)
RETURNS TABLE
AS
RETURN
	SELECT TOP 1 p.pid AS PlantID,least_watered AS LeastWateredDate FROM Plants p
	INNER JOIN Images i ON i.plant_id = p.pid
	GROUP BY (p.pid),least_watered
	HAVING COUNT(i.iid) >= @X
	ORDER BY p.least_watered DESC

GO
SELECT * FROM getPlantWIthMininimumXImages(2)