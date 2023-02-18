CREATE TABLE Instructure (
	Employee_ID int PRIMARY KEY,
	FirstName varchar(20),
	LastName varchar(20),
	Office varchar(10),
	Phone varchar(20)
);

CREATE TABLE Course (
	Course_Number char(9) PRIMARY KEY,
	Title varchar(15),
	Hours int
);

CREATE TABLE student (
	Student_ID int PRIMARY KEY,
	FirstName varchar(20),
	LastName varchar(20),
	Dorm varchar(10),
	Phone varchar(20)
);

CREATE TABLE Section (
	Call_NO char(5) PRIMARY KEY,
	Employee_ID int,
	Course_Number char(9)
);

CREATE TABLE Enrollment (
	Call_NO char(5),
	Student_ID int
);
