-- Create a database to manage software developments companies. The database will store data about the software
-- development process. The entities of interest to the problem domain are: Clients, Company, Department,
-- Employees. A client has a name and a project, also each client can work with multiple companies. A company has a
-- name and a list of clients. A company has multiple departments. Each department has a type (Web, Automotive,
-- Mobile, loT) and a name Multiple employees are working for the same department. An employee can work only
-- for one department. Each employee has a name and a title (Teste, Developer, Manager).
-- 2p A.
-- Write an SQL script that creates the corresponding relational data model.
-- P. Implement a stored procedure that receives a client and returns the name of the company working on his
-- project and all the names and titles of the employees actively working on the project in question.
-- Create a view that shows the list of the clients of a company and the departments names working on those
-- projects.
-- 4. Implement a function that lists the names of the clients which are working with multiple companies and also
-- the names of the employees working on those projects.

--CREATING THE TABLES
CREATE TABLE Clients(
	name varchar(50) PRIMARY KEY,
	project varchar(50) NOT NULL
);

CREATE TABLE Companies(
	name varchar(50) PRIMARY KEY,
)

CREATE TABLE Departments(
	name varchar(50) PRIMARY KEY,
	type varchar(50)
)

CREATE TABLE CompanyDepartments(
	companyName varchar(50),
	departmentName varchar(50),
	PRIMARY KEY(companyName,departmentName),
	FOREIGN KEY(companyName) REFERENCES Companies(name),
	FOREIGN KEY(departmentName) REFERENCES Departments(name)
);

CREATE TABLE CompanyCients(
	companyName varchar(50),
	clientName varchar(50),
	PRIMARY KEY(companyName,clientName),
	FOREIGN KEY(companyName) REFERENCES Companies(name),
	FOREIGN KEY(clientName) REFERENCES Clients(name)
)

CREATE TABLE Employees(
	name varchar(50) PRIMARY KEY,
	title varchar(50) NOT NULL,
	departmentName varchar(50),
	FOREIGN KEY(departmentName) REFERENCES Departments(name)
)
GO
--Implement a stored procedure that receives a client and returns the name of the company working on his
-- project and all the names and titles of the employees actively working on the project in question.

CREATE OR ALTER PROCEDURE getProjectDetails(@clientName varchar(50))
AS 
BEGIN
	
END