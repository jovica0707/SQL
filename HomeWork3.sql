/*
Declare scalar variable for storing FirstName values
	Assign value ‘Antonio’ to the FirstName variable
	Find all Students having FirstName same as the variable
*/
DECLARE @FirstName
	NVARCHAR (100)
	SET @FirstName = 'Antonio'
SELECT * FROM Students where FirstName = @FirstName

/*
Declare table variable that will contain StudentId, Student Name and DateOfBirth
	Fill the table variable with all Female students
*/

DECLARE @StudentId
	TABLE (StudentId int not null, FirstName NVARCHAR(100) null, DateOfBirth date )
	INSERT INTO @StudentId
	SELECT ID, FirstName, DateOfBirth
	FROM dbo.Student
	WHERE Gender 'F'

	select * from @StudentId
	GO

/*
Declare temp table that will contain LastName and EnrolledDate columns
	Fill the temp table with all Male students having First Name starting with ‘A’
	Retrieve the students from the table which last name is with 7 characters
*/

Create table #table 	(LastName nvarchar(100), EnrolledDate date )	insert into #table  select FirstName, EnrolledDate From Student 	where Gender = 'М' and FirstName like 'А%'  	select * from #table
	SELECT * FROM dbo.Student WHERE LEN(LastName) = 7

/*
Find all teachers whose FirstName length is less than 5
	, and the first 3 characters of their FirstName and LastName are the same
*/

SELECT * FROM Teacher where LEN(FirstName) > 5,


/*
Declare scalar function (fn_FormatStudentName) for retrieving the Student description for specific StudentId in the following format:
	- StudentCardNumber without “sc-”
	- “ – “
	- First character of student FirstName
	- “.”
	- Student LastName
	
	example:
	sc-77712 => 77712-K.Spasevska

*/

ALTER FUNCTION dbo.fn_FormatStudentName
    (@StudentId AS INT)
RETURNS NVARCHAR(150)
AS
BEGIN
DECLARE @formatedString NVARCHAR(150)
SELECT @formatedString = 
    SUBSTRING(StudentCardNumber, 4, LEN(StudentCardNumber)) +
    '-'+
    SUBSTRING(FirstName, 1, 1) +
    '.' +
    LastName
    FROM dbo.Student WHERE ID = @StudentId
    RETURN @formatedString
END
GO