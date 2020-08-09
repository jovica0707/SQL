-- <Filtering Data> -- 
/*
> Find all Students with FirstName = Antonio
> Find all Students with DateOfBirth greater than ‘01.01.1999’
> Find all Male students
> Find all Students with LastName starting With ‘T’
> Find all Students Enrolled in January/1998
> Find all Students with LastName starting With ‘J’ enrolled in January/1998
*/

SELECT * FROM dbo.Student WHERE FirstName = 'Antonio'

SELECT * FROM dbo.Student WHERE DateOfBirth > '1999.01.01'

SELECT * FROM dbo.Student WHERE Gender = 'M'

SELECT * FROM dbo.Student WHERE LastName LIKE 'T%'

SELECT * FROM dbo.Student WHERE EnrolledDate >= '1998-01-01' AND EnrolledDate <= '1998-01-31'

SELECT * FROM dbo.Student WHERE LastName LIKE 'J%' AND EnrolledDate >= '1998-01-01' AND EnrolledDate <= '1998-01-31'
-- </Filtering Data> -- 

-- <Sorting Data> --
/*
> Find all Students with FirstName = Antonio ordered by Last Name
> List all Students ordered by FirstName
> Find all Male students ordered by EnrolledDate, starting from the last enrolled
*/

SELECT * FROM dbo.Student WHERE FirstName = 'Antonio'  ORDER BY LastName 

SELECT * FROM dbo.Student ORDER BY FirstName

SELECT * FROM dbo.Student WHERE Gender = 'M' ORDER BY EnrolledDate DESC

-- </Sorting Data> --

-- <Combining Sets> --
/*
List all Teacher First Names and Student First Names in single result set with duplicates
List all Teacher Last Names and Student Last Names in single result set. Remove duplicates
List all common First Names for Teachers and Students
*/

SELECT FirstName FROM dbo.Teacher
UNION ALL
SELECT FirstName FROM dbo.Student

SELECT FirstName FROM dbo.Teacher
UNION
SELECT FirstName FROM dbo.Student

SELECT t.* FROM dbo.Teacher g
 INNER JOIN dbo.Student t ON g.FirstName = t.FirstName

-- </Combining Sets> --


-- <Table Constraints> --
/*
Change GradeDetails table always to insert value 100 in AchievementMaxPoints column if no value is provided on insert
Change GradeDetails table to prevent inserting AchievementPoints that will more than AchievementMaxPoints
Change AchievementType table to guarantee unique names across the Achievement types
*/

ALTER TABLE dbo.GradeDetails
ADD CONSTRAINT df_AchievementMaxPoints
DEFAULT 100 FOR AchievementMaxPoints

ALTER TABLE dbo.GradeDetails
ADD CONSTRAINT mx_AchievementPoints
CHECK (AchievementPoints  BETWEEN 0 AND AchievementMaxPoints)

ALTER TABLE AchievementType
ADD CONSTRAINT un_Name
UNIQUE (Name)

/*
Create Foreign key constraints from diagram or with script
*/
ALTER TABLE dbo.GradeDetails
ADD FOREIGN KEY (GradeID)
REFERENCES dbo.Grade (ID)

ALTER TABLE dbo.Grade
ADD FOREIGN KEY (StudentID)
REFERENCES dbo.Student(ID)

ALTER TABLE dbo.Grade 
ADD FOREIGN KEY (TeacherID)
REFERENCES dbo.Teacher (ID)

-- </Table Constraints> --

-- <Join Types> --
/*
List all possible combinations of Courses names and AchievementType names that can be passed by student
List all Teachers that has any exam Grade
List all Teachers without exam Grade
List all Students without exam Grade (using Right Join)
*/

SELECT c.Name, ac.Name FROM dbo.Course c
CROSS JOIN dbo.AchievementType ac

SELECT DISTINCT t. * FROM dbo.Grade g 
		INNER JOIN dbo.Teacher t ON g.TeacherID = t.ID

SELECT * FROM dbo.Teacher t
		LEFT JOIN dbo.Grade g ON t.ID = g.TeacherID
		WHERE g.ID IS NULL

SELECT * FROM dbo.Grade g
		RIGHT JOIN dbo.Student s ON g.StudentID = s.ID
		WHERE g.ID IS NULL

-- </Join Types> --

