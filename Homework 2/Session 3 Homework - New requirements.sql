/*
--  List all student First Name that are duplicated more than 3 time

--  List the First Name for all the student's that their Last Name is duplicated and they are born in 1985  (Hint use View)

--  Find how many courses each student (using Name and Last Name) has attended

--  Find the students (using Name and Last Name) that have attended less than 20 courses and get their Min, Max and Average grade ordered by the Average Grade ascending

--  For all the students (using First Name and Last Name) get their Min, Max and Average grade (Create view vv_StudentSuccess)

--  Find all the students that have achieved less than 25% from the AchievementMaxPoints for the AchievementType  'Domasni'

--  For the Students from the above list check what is their Success (Min, Max and Average grade) and order them by the AVG grade
 */

 ---------------------------||-------------------------------

 select FirstName, count(FirstName) AS NumDuplicated
 FROM Student
 GRoUP BY FirstName
 HAVING (COUNT (FirstName) > 3)


 ---------------------------||-------------------------------

 SELECT FirstName
 FROM Student
 WHERE DateOfBirth > '1985.01.01' and DateOfBirth < '1986.01.01'
 GROUP BY FirstName
 HAVING COUNT(LastName) > 1
 GO

 ---------------------------||-------------------------------

 SELECT s.FirstName, s.LastName, COUNT(g.CourseID) as TotalCourses
 FROM Grade as g
 INNER JOIN Student as s on g.StudentID = s.ID
 GROUP BY s.FirstName, s.LastName
 GO

 ---------------------------||-------------------------------
 

 SELECT s.FirstName, s.LastName,  min(Grade) as MinGrade, max(Grade) as MaxGrade, avg(Cast(Grade as decimal(4,2))) as AvgGrade
 FROM Grade as g
 INNER JOIN Student as s on g.StudentID = s.ID
 GROUP BY s.FirstName, s.LastName
 HAVING COUNT(g.CourseID) < 20
 ORDER BY AvgGrade asc
 GO

 ---------------------------||-------------------------------
 

CREATE VIEW vv_StudentSuccess
AS
SELECT s.FirstName, s.LastName, min(Grade) as MinGrade, max(Grade) as MaxGrade, avg(Cast(Grade as decimal(4,2))) as AvgGrade
FROM Grade as g
INNER JOIN Student as s on g.StudentID = s.ID
GROUP BY s.FirstName, s.LastName
GO

---------------------------||-------------------------------

ALTER VIEW vv_StudentSuccess
AS
SELECT s.FirstName, s.LastName, min(Grade) as MinGrade, max(Grade) as MaxGrade, avg(Cast(Grade as decimal(4,2))) as AvgGrade, a.Name as AchievmentType, gd.AchievementPoints
FROM Grade as g
INNER JOIN Student as s on g.StudentID = s.ID
INNER JOIN GradeDetails as gd ON g.ID = gd.GradeID
INNER JOIN AchievementType as a on gd.AchievementTypeID = a.ID
WHERE  a.Name = 'Domasni' and gd.AchievementPoints < gd.AchievementMaxPoints * 0.25
GROUP BY s.FirstName, s.LastName, a.Name, gd.AchievementPoints
GO

---------------------------||-------------------------------

SELECT * FROM vv_StudentSuccess
ORDER BY AvgGrade
GO



