/*
	Find the index of space in the emperor name and fill it into @SpaceIndex.
*/
DECLARE @Emperor NVARCHAR(100) = 'Julius Caesar'
DECLARE @SpaceIndex INT

SET @SpaceIndex = CHARINDEX(' ', @Emperor);

SELECT
	'@Emperor' = @Emperor
   ,'@SpaceIndex' = @SpaceIndex


/*
    Set the first name of the emperor into the @FirstName.
    Set the last name of the emperor into the @LastName.
*/
DECLARE @Emperor NVARCHAR(100) = 'Julius Caesar'
DECLARE @FirstName NVARCHAR(100)
DECLARE @LastName NVARCHAR(100)


SET @FirstName = SUBSTRING(@Emperor,1 ,CHARINDEX(' ', @Emperor)-1);
SET @LastName = SUBSTRING(@Emperor,CHARINDEX(' ', @Emperor)+1, LEN(@Emperor))

SELECT
    '@Emperor' = @Emperor
   ,'@FirstName' = @FirstName
   ,'@LastName' = @LastName

/*
    Set the first name of the emperor into the @FirstName.
    Set the middle name of the emperor into the @MiddleName.
    Set the last name of the emperor into the @LastName.
*/
DECLARE @Emperor NVARCHAR(100) = 'Marcus Ulpius Trajanus'
DECLARE @FirstName NVARCHAR(100)
DECLARE @MiddleName NVARCHAR(100)
DECLARE @LastName NVARCHAR(100)

DECLARE @FirstSpace INT = CHARINDEX(' ', @Emperor);

DECLARE @LastSpace INT = (LEN(@Emperor) - CHARINDEX(' ', REVERSE(@Emperor))) + 1; 

SET @FirstName = SUBSTRING(@Emperor, 1, @FirstSpace-1);
SET @MiddleName = SUBSTRING(@Emperor, @FirstSpace+1,@LastSpace-@FirstSpace-1);
SET @LastName = SUBSTRING(@Emperor,@LastSpace+1, (LEN(@Emperor)-@LastSpace)+1)

SELECT
    '@Emperor' = @Emperor
   ,'@FirstName' = @FirstName
   ,'@MiddleName' = @MiddleName
   ,'@LastName' = @LastName

/*
	Replace the name 'Augustus' with 'Tiberius' in the @Emperor.
*/
DECLARE @Emperor NVARCHAR(100) = 'Emperor of the Roman Empire is Augustus. (Sep 18, 14 AD)'
SET @Emperor = REPLACE(@Emperor, 'Augustus', 'Tiberius');
SELECT '@Emperor' = @Emperor


