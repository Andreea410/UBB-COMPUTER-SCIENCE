-- Create a database for a hospital management system. The entities of interest to the problem domain are: Patients, Doctors, Medications, Appointments and Prescriptions.
--A patient has an ID, a name, a date of birth and a gender. IDs are unique. A doctor has a name and a department.
--A medication has a name and a manufacturer. Names are unique. 
--The system stores data about scheduled appointments between patients and doctors and it will store the date and time for each appointment.
--A prescription represents the medication that was prescribed during the appointment, including the dosage.
-- 1. Write an SQL script that creates the corresponding relational data model.
-- 2. Implement a stored procedure that receives a patient, a doctor and a date-time and creates a new appointment. If there is already an appointment for the same doctor and patient, the date of the existing appointment is updated.
-- 3. Create a view that shows the names of the doctors with scheduled appointments during the month of February, 2024.
-- 4. Implement a function that returns the total count of each medication prescribed by a doctor D across all appointments, where D is a function parameter.

--DELETING THE TABLES IF ALREADY EXIST
IF OBJECT_ID('Prescriptions', 'U') IS NOT NULL
DROP TABLE Prescriptions;
IF OBJECT_ID('Appointments', 'U') IS NOT NULL
DROP TABLE Appointments;
IF OBJECT_ID('Medications', 'U') IS NOT NULL
DROP TABLE Medications;
IF OBJECT_ID('Doctors', 'U') IS NOT NULL
DROP TABLE Doctors;
IF OBJECT_ID('Patients', 'U') IS NOT NULL
DROP TABLE Patients;


--CREATING TABLES
CREATE TABLE Patients(
	id int PRIMARY KEY,
	name varchar(50) NOT NULL,
	birthday DATE NOT NULL,
	gender char(1) NOT NULL CHECK(gender  IN ('F','M','O'))
);

CREATE TABLE Doctors(
	name varchar(50) PRIMARY KEY,
	department varchar(50) NOT NULL
);

CREATE TABLE Medications(
	name varchar(50) PRIMARY KEY,
	manufacturer varchar(50) NOT NULL
);

CREATE TABLE Appointments(
	id int PRIMARY KEY,
	patient_id int,
	doctor_name varchar(50),
	date DATE NOT NULL CHECK(date <= GETDATE()),
	time TIME NOT NULL,
	FOREIGN KEY(patient_id) REFERENCES Patients(id) ON DELETE CASCADE,
	FOREIGN KEY(doctor_name) REFERENCES Doctors(name) ON DELETE CASCADE,
);

CREATE TABLE Prescriptions(
	id int PRIMARY KEY,
	appoinmentID int,
	medication_name varchar(50),
	dosage int,
	FOREIGN KEY(medication_name) REFERENCES Medications(name) ON DELETE CASCADE,
	FOREIGN KEY(appoinmentID) REFERENCES Appointments(id) ON DELETE CASCADE
);

GO

--INSERTING DATA
INSERT INTO Patients(id,name,birthday,gender) VALUES
(1,'d1','2024/12/12','F'),
(2,'d2','2024/12/12','M'),
(3,'d3','2024/12/12','F'),
(4,'d4','2024/12/12','M');

INSERT INTO Doctors(name,department) VALUES
('d1','dep1'),
('d2','dep1'),
('d3','dep2'),
('d4','dep3'),
('d5','dep4');

INSERT INTO Medications(name,manufacturer) VALUES
('m1','man1'),
('m2','man1'),
('m3','man2'),
('m4','man3');


INSERT INTO Appointments(id,patient_id,doctor_name,date,time) VALUES
(1,1,'d1','2024/12/12','12:58'),
(2,2,'d1','2024/12/12','13:55'),
(3,3,'d2','2024/12/12','12:58'),
(4,4,'d3','2024/12/12','12:58');


INSERT INTO Prescriptions(id,appoinmentID,medication_name,dosage) VALUES
(1,1,'m1',10),
(2,2,'m2',2),
(3,1,'m1',3),
(4,1,'m3',1),
(5,3,'m4',5);

GO
-- 2. Implement a stored procedure that receives a patient, a doctor and a date-time and creates a new appointment. If there is already an appointment for the same doctor and patient, 
--the date of the existing appointment is updated.


CREATE OR ALTER PROCEDURE addAppoiment(@patientID int , @doctorName varchar(50),@date DATE , @time TIME)
AS
BEGIN
	--Check if patient exists
	IF NOT EXISTS(
		SELECT * FROM Patients
		WHERE id = @patientID
	)
	BEGIN
		PRINT 'The patient doesn t exist'
		RETURN
	END

	--Check if doctor exists
	IF NOT EXISTS(
		SELECT 1 FROM Doctors
		WHERE name = @doctorName
	)
	BEGIN
		PRINT 'The doctor doesn t exist'
		RETURN
	END

	--check if the appoinment already exists
	IF EXISTS(
		SELECT 1 FROM Appointments
		WHERE patient_id = @patientID AND doctor_name = @doctorName
	)
	BEGIN
		PRINT 'The appoinment already exists.I will update the date and time'
		UPDATE Appointments
		SET date = @date , time = @time
		WHERE patient_id = @patientID AND doctor_name = @doctorName
		RETURN
	END

	DECLARE @id INT
	SELECT @id = ISNULL(MAX(id), 0) + 1 FROM Appointments;
	INSERT INTO Appointments(id,patient_id,doctor_name,date,time) VALUES (@id,@patientID,@doctorName,@date,@time)
END

SELECT * FROM Appointments; 
EXECUTE addAppoiment 2,'d3','2024/02/11','19:30' ;
GO

-- 3. Create a view that shows the names of the doctors with scheduled appointments during the month of February, 2024.
CREATE OR ALTER View ShowDoctorsWithAppoinments 
AS
	SELECT name FROM
	Doctors d 
	JOIN Appointments a ON A.doctor_name = d.name
	GROUP BY d.name , a.date
	HAVING a.date > '2024/01/31' AND a.date < '2024/03/01'
GO

SELECT * FROM ShowDoctorsWithAppoinments
GO

-- 4. Implement a function that returns the total count of each medication prescribed by a doctor D across all appointments, where D is a function parameter.

CREATE OR ALTER FUNCTION getTotalCountOfMedication (@doctorName varchar(50))
RETURNS TABLE
AS
RETURN
	SELECT COUNT(p.medication_name) AS totalCount ,p.medication_name AS medicationName 
	FROM Doctors d
	JOIN Appointments a ON a.doctor_name = d.name
	JOIN Prescriptions p ON p.appoinmentID = a.id
	WHERE d.name = @doctorName
	GROUP BY p.medication_name
	
GO
SELECT * FROM getTotalCountOfMedication('d1');