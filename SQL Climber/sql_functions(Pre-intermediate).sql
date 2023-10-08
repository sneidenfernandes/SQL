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


/*
    Convert word @Upper to upper-case and convert all other text to lower-case.
*/
DECLARE @Emperor NVARCHAR(100) = 'Emperor of the Roman Empire is Tiberius.'
DECLARE @Upper NVARCHAR(100) = 'Tiberius'

SET @Emperor = LOWER(@Emperor);
SET @Emperor = REPLACE(@Emperor,@Upper, UPPER(@Upper));

SELECT '@Emperor' = @Emperor

/*
    Remove the spaces before and after the name of the emperors.
*/
DECLARE @Emperors TABLE (Emperor NVARCHAR(100))
INSERT INTO @Emperors (Emperor) 
VALUES
('Augustus '), ('Tiberius'), ('   Caligula   '), ('Claudius '), (' Nero'), 
('  Galba  '), ('Otho    '), ('Vitellius     '), ('Vespasian'), ('Titus')

UPDATE t
SET t.Emperor =
TRIM(t.Emperor)
FROM @Emperors t;

SELECT * FROM @Emperors


/*
    A palindrome is a word, sentence, or number that reads the same from left to right as from right to left.

	Set column IsPalindrome with the correct value in the @Palindrome table.
*/
DECLARE @Palindrome TABLE
(
	String NVARCHAR(100)
   ,IsPalindrome BIT
)
INSERT INTO @Palindrome (String) VALUES
('Level'), ('eye'), ('Eminem'), ('Stab nail at ill Italian bats'), ('Rotor'), ('Stack cats')


UPDATE p
SET p.isPalindrome = CASE WHEN LOWER(REPLACE(p.String,' ','')) = REVERSE(LOWER(REPLACE(p.String,' ',''))) THEN 1
						  ELSE 0
					 END
FROM @Palindrome p;


/*
	Set date in the format yyyy-MM-dd into the @DateString.
	Set time in the format HH:mm into the @TimeString.
*/
DECLARE @Date DATETIME2(0) = '1999-12-31 23:59'
DECLARE @DateString NVARCHAR(100)
DECLARE @TimeString NVARCHAR(100)

SET @DateString = FORMAT(@Date, 'yyyy-MM-dd');

SET @TimeString = FORMAT(@Date, 'HH:mm')

SELECT
	'Date' = @DateString 
   ,'Time' = @TimeString

/*
    Select the column Information from the @History table.
    If the value of the information is longer than 85 characters 
    then show information in the format '{first 80 charaters} ...'
    otherwise, show complete information.
*/
DECLARE @History TABLE (Information NVARCHAR(500))
INSERT INTO @History (Information) VALUES 
('The Roman Empire has built more than 400,000 kilometers of roads.'),
('The Romans constructed 11 aqueducts for Rome.'),
('Construction of Colosseum (also known as the Flavian Amphitheatre) began under the emperor Vespasian in AD 72.'),
('Hadrian''s Wall was built to separate the Romans from the barbarians.')

SELECT 'Information' = CASE
							WHEN LEN(h.Information) > 85 THEN LEFT(h.Information,80) + ' ...'
                            ELSE h.Information
					   END 
FROM @History h;


