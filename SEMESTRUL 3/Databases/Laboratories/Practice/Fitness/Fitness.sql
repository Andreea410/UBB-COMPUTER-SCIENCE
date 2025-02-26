--FITNESS CENTER MANAGER

CREATE TABLE Members(
	mid int PRIMARY KEY,
	mbirthday DATE,
	start_date DATE
);

CREATE TABLE Trainers(
	tid int PRIMARY KEY,
	tname varchar(50) NOT NULL,
	specialization varchar(50) NOT NULL,
	experience int
);

CREATE TABLE Classes(
	cid int PRIMARY KEY,
	cname varchar(50) NOT NULL,
	type_class varchar(50) NOT NULL,
	schedule varchar(50) NOT NULL,
	trainer_id int,
	FOREIGN KEY(trainer_id) REFERENCES Trainers(tid)
);

CREATE TABLE Attendance_Records(
	member_id int ,
	class_id int,
	PRIMARY KEY(member_id,class_id),
	attendance_date DATE NOT NULL,
	status varchar(50)
);
GO

INSERT INTO Members(mid,mbirthday,start_date) VALUES
(1,'2024/12/12','2024/12/12'),
(2,'2024/12/12','2024/12/12'),
(3,'2024/12/12','2024/12/12'),
(4,'2024/12/12','2024/12/12'),
(5,'2024/12/12','2024/12/12');

INSERT INTO Trainers(tid,tname,specialization,experience) VALUES
(1,'trainer1','yoga',2),
(2,'trainer2','cardio',1),
(3,'trainer3','yoga',3),
(4,'trainer4','cardio',5),
(5,'trainer5','yoga',1),
(6,'trainer6','yoga',4);

INSERT INTO Classes(cid,cname,type_class,schedule,trainer_id) VALUES
(1,'class1','yoga','',1),
(2,'class2','cardio','',2),
(3,'class3','yoga','',3),
(4,'class4','yoga','',1),
(5,'class5','yoga','',1);
GO

--Implement a stored procedure that receives a memeber ID , a class ID and an attendance date and adds am attendance record.If the record already exists , update the status.
CREATE OR ALTER PROCEDURE addAttendanceRecord(@memberId int , @classID int , @date DATE, @status varchar(50))
AS
BEGIN
	IF EXISTS(
		SELECT 1 FROM Attendance_Records 
		WHERE member_id = @memberId AND class_id = @classID)
	BEGIN
		PRINT 'Record already exists.Updating the status'
		UPDATE Attendance_Records
		SET status = @status
		WHERE member_id = @memberId AND class_id = @classID
		RETURN
	END

	INSERT INTO Attendance_Records(member_id,class_id,attendance_date,status) VALUES (@memberId , @classID , @date,@status)
END

EXECUTE addAttendanceRecord 2,2,'2024/12/12','atte'
SELECT * FROM Attendance_Records;
GO

--Create a view that shows the classes with the highest attendance
CREATE OR ALTER VIEW classesWithHighestAttendance
AS
	SELECT class_id AS classID , cname AS className , COUNT(ar.member_id) AS number_members FROM Classes c
	INNER JOIN Attendance_Records ar ON ar.class_id = c.cid
	GROUP BY class_id,cname
	HAVING COUNT (ar.member_id) = (SELECT MAX(attendance)
								FROM (SELECT COUNT(*) as attendance FROM Attendance_Records 
										GROUP BY class_id)
										AS subq)
GO
SELECT * FROM classesWithHighestAttendance
GO

--Implement a function that lists the name of trainers who have taught more than N classes , where N>= 1 is a function parameter
CREATE OR ALTER FUNCTION getTrainers(@N int) 
RETURNS TABLE
AS 
RETURN 
	SELECT t.tname AS trainerName ,COUNT(DISTINCT c.cid) AS numberClasses FROM Trainers t
	INNER JOIN Classes c ON c.trainer_id = t.tid
	GROUP BY t.tname
	HAVING COUNT(DISTINCT c.cid) > @N
GO

SELECT * FROM getTrainers(1)
