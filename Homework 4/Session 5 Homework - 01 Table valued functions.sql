/*
Create multi-statement table value function that for specific
Teacher and Course will return list of students (FirstName, LastName) 
who passed the exam, together with Grade and CreatedDate

*/
	CREATE FUNCTION dbo.fn_TeacherAndCourse
(
    @TeacherID INT,
    @CourseID INT
)
RETURNS TABLE
AS
RETURN SELECT s.FirstName,
              s.LastName,
              g.Grade,
              g.CreatedDate
       FROM dbo.Grade g
           INNER JOIN [dbo].[Student] s
               ON g.StudentID = s.ID
       WHERE g.TeacherID = @TeacherID
             AND g.CourseID = @CourseID;

		SELECT * FROM dbo.fn_TeacherAndCourse (10, 10)




			 
	
	