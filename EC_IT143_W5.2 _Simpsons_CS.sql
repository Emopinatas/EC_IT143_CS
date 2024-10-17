/*****************************************************************************************************************
NAME:    5.2 Final Project- Create Answers- Simpsons
PURPOSE: To answer questions about the 2 communities I picked

MODIFICATION LOG:
Ver      Date        Author            Description
-----   ----------   -----------       -------------------------------------------------------------------------------
1.0     10/16/2024   Cameron Shephard  1. Built this script for IT 143


NOTES: 
This is where I talk about what this script is, why I built it, and other stuff...
 
******************************************************************************************************************/


-- Q1: (Question by Eric Roe) Homer and Marge have decided to start budgeting because the FBS_Viza_Costmo card is being used too much. To begin, they need to 
-- know who is spending the most as well as how much money is going to each category. 
-- A1: For this questions, I needed to make 2 queries so that I can show who was spending more and how much and then where the money was being spent in general. 
-- Marge is spending way more than Homer.
USE Simpsons;

SELECT 
    Member_Name,
    SUM(Debit) AS Total_Debit,
    SUM(Credit) AS Total_Credit,
    (SUM(Debit) - SUM(Credit)) AS Net_Spending
FROM 
    dbo.FBS_Viza_Costmo
WHERE 
    Member_Name IN ('Marge Simpson', 'Homer Simpson')
GROUP BY 
    Member_Name
ORDER BY 
    Net_Spending DESC;
-----------------------------------------------------------------
	USE Simpsons;

SELECT 
    Description,
    SUM(Debit) AS Total_Debit,
    SUM(Credit) AS Total_Credit
FROM 
    dbo.FBS_Viza_Costmo
GROUP BY 
    Description
ORDER BY 
    Description;

-- Q2:(Question by me) Homer seems to like to come to Springfield Mall often. Does he go to Springfield Mall more often than Marge? If so, how many times more?
-- A2: Marge actually has gone to Springfield more many more times than Homer. 52 times to be exact. 
USE Simpsons;

SELECT 
    Member_Name,
    COUNT(*) AS Springfield_Mall_Count
FROM (
    SELECT 
        Member_Name,
        Description
    FROM 
        dbo.FBS_Viza_Costmo
    WHERE 
        Description = 'Springfield Mall' 
        AND Member_Name IN ('Homer Simpson', 'Marge Simpson')
    
    UNION ALL

    SELECT 
        Card_Member AS Member_Name,
        Description
    FROM 
        dbo.Planet_Express
    WHERE 
        Description = 'Springfield Mall' 
        AND Card_Member IN ('Homer Simpson', 'Marge Simpson')
) AS Combined
GROUP BY 
    Member_Name;

-- Q3: (Question by me) Of the three years listed in the Simpsons database, 1989, 1990, and 1991, which year did Marge use her debit card the most and
-- how much was purchased with it each year?
-- A3: 1991 had the most purchased in that year with a total of 32722.71. 1990 was 19127.63 and 1989 was 17738.72.
USE Simpsons;

SELECT 
    YEAR(Date) AS Transaction_Year,
    SUM(Amount) AS Total_Amount
FROM 
    dbo.Planet_Express
WHERE 
    Card_Member = 'Marge Simpson' 
    AND YEAR(Date) IN (1989, 1990, 1991)
GROUP BY 
    YEAR(Date)
ORDER BY 
    Transaction_Year;

-- Q4: (Question by me) Marge thinks that Homer is eating out at restaurants too much and needs the data to back her theory. How often is the category 
--  a restaurant when Homer is making purchases with his card?
-- A4:  36 times he has gone to eat using his card
USE Simpsons;

SELECT 
    Description,
    COUNT(*) AS Description_Count
FROM 
    dbo.FBS_Viza_Costmo
WHERE 
    Member_Name = 'Homer Simpson'
GROUP BY 
    Description
ORDER BY 
    Description_Count DESC;