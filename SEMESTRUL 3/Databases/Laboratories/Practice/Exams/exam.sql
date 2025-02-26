CREATE TABLE Professors(
	professor_id int PRIMARY KEY,
	professor_name varchar(50),
	professor_surname varchar(50) NOT NULL,
	professor_function varchar(50) NOT NULL
);

CREATE TABLE Groups(
	group_id int PRIMARY KEY,
	number_students int NOT NULL,
	leader_name varchar(50),
	tutor_name varchar(50)
);


CREATE TABLE Students(
	student_id int PRIMARY KEY,
	student_name varchar(50) NOT NULL,
	student_surname varchar(50) NOT NULL,
	student_birthday DATE NOT NULL,
	group_id int ,
	FOREIGN KEY(group_id) REFERENCES Groups(group_id)
);

CREATE TABLE Courses(
	course_id int PRIMARY KEY,
	course_name varchar(50) NOT NULL
);

CREATE TABLE Exams(
	course_id int,
	student_id int,
	date_exam DATE NOT NULL,
	mark int,
	PRIMARY KEY(course_id,student_id),
	FOREIGN KEY(course_id) REFERENCES Courses(course_id),
	FOREIGN KEY(student_id) REFERENCES Students(student_id)
)

CREATE TABLE ProfessorsCourses(
	professor_id int,
	course_id int ,
	specialization varchar(50),
	number_credits int,
	PRIMARY KEY(professor_id , course_id),
	FOREIGN KEY(course_id) REFERENCES Courses(course_id),
	FOREIGN KEY(professor_id) REFERENCES Professors(professor_id)
)

GO

--INSERTING DATA
INSERT INTO Professors(professor_id,professor_name,professor_surname,professor_function) VALUES
(1,'p1','s1','f1'),
(2,'p2','s2','f2'),
(3,'p3','s3','f3'),
(4,'p4','s4','f4');

INSERT INTO Groups(group_id,leader_name,tutor_name,number_students) VALUES
(1,'l1','t1',10),
(2,'l2','t2',15),
(3,'l3','t3',3),
(4,'l4','t4',20);

INSERT INTO Students(student_id,student_name,student_surname,student_birthday,group_id) VALUES
(1,'s1','sur1','2024/12/12',1),
(2,'s2','sur2','2024/12/12',2),
(3,'s3','sur3','2024/12/12',1),
(4,'s4','sur4','2024/12/12',1),
(5,'s5','sur5','2024/12/12',3),
(6,'s6','sur6','2024/12/12',2),
(7,'s7','sur7','2024/12/12',4);

INSERT INTO Courses(course_id,course_name) VALUES
(1,'c1'),
(2,'c2'),
(3,'c3'),
(4,'c4');

INSERT INTO ProfessorsCourses(professor_id,course_id,specialization,number_credits) VALUES
(1,1,'s1',5),
(1,2,'s2',6),
(2,1,'s1',5),
(3,3,'s3',6);


GO

--Implement a stored procedure that receives a student , a course , a date,
--and a given mark and adds the corresponding exam,If the exam exists , 
--the date and the given mark are updated.

CREATE OR ALTER PROCEDURE addExam(@student_id int , @course_id int,@date DATE,@mark int)
AS
BEGIN
	IF EXISTS(
		SELECT 1 FROM Exams
		WHERE student_id = @student_id AND course_id = @course_id
	)
	BEGIN
		PRINT 'The exam already exists.The date and mark will be updated'
		UPDATE Exams
		SET mark = @mark , date_exam = @date
		WHERE student_id = @student_id AND course_id = @course_id
		RETURN
	END

	INSERT INTO Exams(student_id,course_id,date_exam,mark) VALUES (@student_id,@course_id,@date,@mark)
END

EXECUTE addExam 2,2,'2024/12/23',10;
SELECT * FROM Exams
GO

--Create a view that shows the groups in which the maximum mark was obtained
CREATE OR ALTER VIEW getGroupMaxGrade AS
	SELECT g.group_id,g.leader_name,g.number_students,g.tutor_name FROM Exams e
	INNER JOIN Students s ON e.student_id = s.student_id
	INNER JOIN Groups g ON g.group_id = s.group_id
	GROUP BY g.group_id ,g.number_students,g.leader_name,g.tutor_name
	HAVING SUM(e.mark) = (SELECT MAX(sum_marks) FROM
								(SELECT SUM(e.mark) AS sum_marks FROM Exams e
									INNER JOIN Students s ON e.student_id = s.student_id
									INNER JOIN Groups g ON g.group_id = s.group_id
									GROUP BY g.group_id) AS GroupsMarks
								) 
GO

SELECT * FROM getGroupMaxGrade
GO

--Implement a function that lists the names of the professors that have taught at least M courses , where M >=1
CREATE OR ALTER FUNCTION getNamesProfessors(@M int) 
RETURNS TABLE
AS
RETURN 
	SELECT p.professor_name FROM Professors p
	INNER JOIN ProfessorsCourses pc on pc.professor_id = p.professor_id
	GROUP BY p.professor_name
	HAVING COUNT(DISTINCT PC.course_id) >= @M
GO

SELECT * FROM getNamesProfessors(2)