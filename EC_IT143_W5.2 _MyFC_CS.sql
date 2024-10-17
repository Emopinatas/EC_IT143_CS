/*****************************************************************************************************************
NAME:    5.2 Final Project- Create Answers- MyFC
PURPOSE: To answer questions about the 2 communities I picked

MODIFICATION LOG:
Ver      Date        Author            Description
-----   ----------   -----------       -------------------------------------------------------------------------------
1.0     10/16/2024   Cameron Shephard  1. Built this script for IT 143


NOTES: 
This is where I talk about what this script is, why I built it, and other stuff...
 
******************************************************************************************************************/


-- Q1: (Question by Eric Roe) Which player is getting paid the most? What is the player's name, position and which team are the playing on?
-- A1: Santiago Flores, 19768, Player position is goalkeeper and his team is U14
USE MyFC;

SELECT 
    pd.pl_name,
    pf.mtd_salary,
    pos.p_name,
    t.t_code
FROM 
    dbo.tblPlayerFact pf
JOIN 
    dbo.tblPlayerDim pd ON pf.pl_id = pd.pl_id
JOIN 
    dbo.tblPositionDim pos ON pd.p_id = pos.p_id
JOIN 
    dbo.tblTeamDim t ON pd.t_id = t.t_id
WHERE 
    pf.mtd_salary = (
        SELECT MAX(mtd_salary) 
        FROM dbo.tblPlayerFact
    );

-- Q2:(Question by me) I think that maybe some of the teams have more players than are allowed. Which team has the most players on it?
-- A2: U14 has the most players on it at 35 players which I think is too many.
USE MyFC;

SELECT 
    t.t_code, 
    COUNT(pd.pl_id) AS Player_Count
FROM 
    dbo.tblPlayerDim pd
JOIN 
    dbo.tblTeamDim t ON pd.t_id = t.t_id
GROUP BY 
    t.t_code
ORDER BY 
    Player_Count DESC

-- Q3: (Question by me) We want to see who the most improved player is. There are 3 dates that it shows the player's salary. Which player has had their salary 
-- increased the most during those 3 periods and which team do they play for?
-- A3: The query i used created me the information I needed but none of the players had a salary change so we cant base who got better off of the a salary change within 3 months. 
USE MyFC;

WITH SalaryChanges AS (
    SELECT 
        pl_id,
        MIN(mtd_salary) AS First_Salary,
        MAX(mtd_salary) AS Last_Salary,
        (MAX(mtd_salary) - MIN(mtd_salary)) AS Salary_Change
    FROM 
        dbo.tblPlayerFact
    GROUP BY 
        pl_id
)

SELECT 
    sc.pl_id,
    pd.pl_name,
    pd.t_id,
    sc.Salary_Change
FROM 
    SalaryChanges sc
JOIN 
    dbo.tblPlayerDim pd ON sc.pl_id = pd.pl_id
ORDER BY 
    sc.Salary_Change DESC

-- Q4: (Question by me) I want to test my theory that each team has a main goalkeeper and then 2 backup goalkeepers. Tell me how many goalkeepers are on each team.
-- A4:  I was wrong. There is a single team with only 1 goalkeeper, but all of the others had 4 or more with the most being 11.
USE MyFC;

SELECT 
    pd.t_id, 
    COUNT(pd.pl_id) AS Goalkeeper_Count
FROM 
    dbo.tblPlayerDim pd
JOIN 
    dbo.tblPositionDim pos ON pd.p_id = pos.p_id
WHERE 
    pos.p_name = 'Goalkeeper'
GROUP BY 
    pd.t_id
ORDER BY 
    pd.t_id;
