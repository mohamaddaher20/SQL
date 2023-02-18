--Mohamad Taha Daher
--Exercise 5
--Feb 5, 2023

-- #1
--In T-SQL, create a new VIEW called PersonsByCountry that displays a list of all Persons’ names and the
--country they live in.
USE AdventureWorks;

CREATE OR ALTER VIEW PersonsByCountry AS
SELECT FirstName, MiddleName, LastName, countryRegion.Name
FROM Person.person
	INNER JOIN Person.BusinessEntity ON BusinessEntity.BusinessEntityID = person.BusinessEntityID
	INNER JOIN Person.BusinessEntityAddress ON BusinessEntityAddress.BusinessEntityID = person.BusinessEntityID
	INNER JOIN Person.Address ON Address.AddressID = BusinessEntityAddress.AddressID
	INNER JOIN Person.StateProvince ON Address.StateProvinceID = StateProvince.StateProvinceID
	INNER JOIN Person.CountryRegion ON CountryRegion.CountryRegionCode = StateProvince.CountryRegionCode;
GO

-- #2
--Write a SELECT query to display all the data from the PersonsByCountry view, sorted by country name,
--person’s last name, then first name.
SELECT *
FROM PersonsByCountry
ORDER BY Name, LastName, FirstName ASC;

-- #3
--In the SSMS GUI Editor, create a second VIEW, called PersonAndEmailsByCountry, based on the view from part 1,
--that displays all data and includes each person’s email address. Note: This isn’t a copy-paste-SQL job! 
--Reference the other view in the new view, which may require you to make some changes to the original 
--PersonsByCountry view.	--NOT SURE*********
CREATE OR ALTER VIEW PersonAndEmailsByCountry AS
SELECT dbo.PersonsByCountry.FirstName, dbo.PersonsByCountry.LastName, dbo.PersonsByCountry.Name, Person.EmailAddress.EmailAddress, Person.EmailAddress.BusinessEntityID, Person.EmailAddress.EmailAddressID, person.MiddleName
FROM     Person.Person INNER JOIN
                  Person.EmailAddress ON Person.Person.BusinessEntityID = Person.EmailAddress.BusinessEntityID CROSS JOIN
                  Person.CountryRegion CROSS JOIN
                  dbo.PersonsByCountry

--# 4
--Script your GUI-created VIEW and add the CREATE VIEW part to the T-SQL script you’re writing for the other
--steps. (Right-click the PersonAndEmailsByCountry view, choose Script View AS… Create…)

--#5
--Write a SELECT query to display data from the PersonAndEmailsByCountry view, for persons residing in the USA,
--and whose email addresses start with ‘P’, sorted by person’s last name, then first name, 
--and hiding any non-user-friendly columns of data.
SELECT FirstName, MiddleName, LastName, Name, EmailAddress
FROM PersonAndEmailsByCountry
WHERE Name ='United States' and EmailAddress like 'p%';

--#6
--In T-SQL, create a new view called PersonEmployees, based on the view from part 3, that displays all the 
--person data for anyone who is an employee of the AdventureWorks company, and includes their job title and 
--hire date.
CREATE OR ALTER VIEW PersonEmployees AS
SELECT FirstName, LastName, EmailAddress, Name, JobTitle, HireDate
FROM PersonAndEmailsByCountry pec
	INNER JOIN HumanResources.Employee he ON Pec.BusinessEntityID = he.BusinessEntityID
GO

--#7
--Write a SELECT query to display data from the PersonEmployees view, showing the employee’s full name
--(in a single field), their job title, hire date, email address and country, for any employee hired in 2012
--or later. Sort the data from most recent hire date, then by job title, then employee name. 
--(Note: Remember that in AdventureWorks, you have to include the schema in the table name. 
--The Employee table is in a schema called HumanResources).

SELECT CONCAT( FirstName,' ',LastName) AS FullName, JobTitle, HireDate, EmailAddress, Name
FROM PersonEmployees
WHERE HireDate >= '20120101'
