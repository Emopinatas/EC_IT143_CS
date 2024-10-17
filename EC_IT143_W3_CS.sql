/*****************************************************************************************************************
NAME:    3.4 AdventureWorks Create Answers
PURPOSE: Answer 8 Complexity Questions

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/23/2024   CSHEPHARD    1. Built this script for IT143


RUNTIME: 
Xm Xs

NOTES: 
This is where I talk about what this script is, why I built it, and other stuff...
 
******************************************************************************************************************/

-- Q1: MARGINAL COMPLEXITY (Question by Justin Hemmert) Can you list the name of the product with the highest List Price?
-- A1: First I would need to find where List Price is, which it is in the Production.ProductListPriceHistory table. Then I just need 
-- to find the highest listed price in that table.  
select 
	Max(ListPrice)
from 
	Production.ProductListPriceHistory

-- Q2: MARGINAL COMPLEXITY (Question by me) How many male employees work at this company?
-- A2: First, I found that gender is in the HumanResources.Employee table. Then I see that in the table, the Males are marked with "M".
SELECT 
	COUNT(*) AS MaleCount
FROM 
	HumanResources.Employee
WHERE 
	Gender = 'M';

-- Q3: Moderate Complexity (Question by Catherin Kivindu) Based on the hire date, which top five employees have been hired for the longest period?
-- A3: First, I looked for where HireDate would be which is in HumanResources.Employee table. Then I get all of the hire dates and order them ascending and limit them to 5.
SELECT *
FROM 
	HumanResources.Employee
ORDER BY 
	HireDate ASC
LIMIT 5;

--Q4: Moderate Complexity (Question by Justin Hemmert) Can you list the First Name, Last Name, and Sales YTD starting from highest to lowest?
--A4: I first found the First and last name in the Person.Person table and then the SalesYTD in the Sales.SalesPerson table. Then I combined that and place them in order of who had the most sales. 
SELECT 
    p.FirstName, 
    p.LastName, 
    sp.SalesYTD
FROM 
    Person.Person p
JOIN 
    Sales.SalesPerson sp ON p.BusinessEntityID = sp.BusinessEntityID
ORDER BY 
    sp.SalesYTD DESC;


--Q5: Increased Complexity (Question by Ariel Silva) Retrieve the first 10 employees' JobTitle and their corresponding PhoneNumber from the HumanResources.Employee and Person.PersonPhone tables, sorted by HireDate
--A5:  I got the first 10 people from their hire date and then got their Job title and Phone number in the HumanResources.Employee and the Person.PersonPhone tables and added them together.
SELECT TOP 
	10 e.JobTitle, pp.PhoneNumber
FROM 
	HumanResources.Employee e
JOIN 
	Person.PersonPhone pp ON e.BusinessEntityID = pp.BusinessEntityID
ORDER BY 
	e.HireDate ASC;

--Q6: Increased Complexity (Question by Justin Hemmert) Can you list the number of employees with their First Name, Last Name, and Vacation hours that are equal to 50 and above? We may be implementing new policies to our vacation roll over limits. 
--A6: First, I got the first and last names and Vacation hours from HumanResources.Employee and Person.Person. Then we had to list them up within anyone that had more vacation hours than 50. 
SELECT 
    p.FirstName, 
    p.LastName, 
    e.VacationHours
FROM 
    Person.Person p
JOIN 
    HumanResources.Employee e ON p.BusinessEntityID = e.BusinessEntityID
WHERE 
    e.VacationHours >= 50;

--Q7: Metadata (Question by me) Can you create a list of tables in AdventureWorks that contain a column with this names: TerritoryID?
--A7: First I need to search "table name" from the Schema "INFORMATION_SCHEMA.COLUMNS" for a column called "TerritoryID"
SELECT
	TABLE_NAME 
FROM 
	INFORMATION_SCHEMA.COLUMNS
WHERE
	COLUMN_NAME = 'TerritoryID';


--Q8:Metadata (Question by Carlos Andres) Which tables in the AdventureWorks database contain the column "SalesOrderID"?
--A8: First I need to search "Table Name" from the Schema "INFORMATION_SCHEMA.COLUMNS" for  a column called "SalesOrderID"
SELECT
	TABLE_NAME
FROM
	INFORMATION_SCHEMA.COLUMNS
WHERE
	COLUMN_NAME = 'SalesOrderID'
