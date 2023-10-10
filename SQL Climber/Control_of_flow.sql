/*
    If the @Select is equal to value 'Country', then select data from the table Country,
    otherwise, do nothing.
*/
DECLARE @Select NVARCHAR(100) = 'Country'
IF @Select = 'Country'
	SELECT * FROM Country;

/*
    If the @Select is equal to value 'Country' and @Id is not NULL, 
    then select a country from the table by @Id, otherwise, do nothing.
*/
DECLARE @Select NVARCHAR(100) = 'Country'
DECLARE @Id INT = 2
IF @Select = 'Country' AND @Id IS NOT NULL
	SELECT 
    	*
    FROM
        Country
    WHERE
    	Id = @Id;

/*
    If at least one of the variables is not null, then select countries by variables.
    If both variables are null, then do nothing.
*/
DECLARE @Capital NVARCHAR(100)
DECLARE @Currency NVARCHAR(100) = 'EUR'
IF @Capital IS NOT NULL OR @Currency IS NOT NULL
	SELECT 
    	* 
    FROM 
    	Country c
    WHERE
    	c.CurrencyCode = @Currency OR C.Capital = @Capital;

/*
    If the @Select is equal to value 'YES', then select the top 3 rows from each table,
    otherwise, do nothing.
*/
DECLARE @Select NVARCHAR(100) = 'YES'
IF @Select = 'YES'
BEGIN
	SELECT TOP(3) * FROM Country
    SELECT TOP(3) * FROM City
    SELECT TOP(3) * FROM TouristAttraction
END

/*
	If the table Country contains a country with the name @Country, select the country.
*/
DECLARE @Country VARCHAR(100) = 'Portugal'
IF  EXISTS (SELECT c.Name FROM Country c WHERE c.Name = @Country)
BEGIN
		SELECT * FROM Country c WHERE c.Name = @Country
END


/*
    If the country with the name @Name and @Capital does not exist in the table @Country,
    then insert the country into the table.
*/
DECLARE @Country TABLE 
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Capital NVARCHAR(100)
)
INSERT INTO @Country (Name, Capital) VALUES
('Denmark', 'Copenhagen'), 
('Sweden', 'Stockholm'), 
('Norway', 'Oslo')

DECLARE @Name NVARCHAR(100) = 'Finland'
DECLARE @Capital NVARCHAR(100) = 'Helsinki'
IF NOT EXISTS (SELECT c.Name, c.Capital FROM @Country c WHERE c.Name = @Name AND c.Capital = @Capital )
BEGIN
	
    INSERT INTO @Country(Name, Capital) VALUES (@Name, @Capital)

END
SELECT * FROM @Country

/*
    If the @Select is equal to value 'YES', then select the top 3 rows from tables Country, 
	City, and TouristAttraction. Otherwise, print the message 'No data!'.
*/
DECLARE @Select NVARCHAR(100) = 'YES'
IF @Select = 'YES'

BEGIN
	SELECT TOP(3) * FROM Country
    SELECT TOP(3) * FROM City
    SELECT TOP(3) * FROM TouristAttraction
END

ELSE

BEGIN 
   PRINT 'No data!'
END


/*
	Print the sequence of numbers where the first number is the value of @MinNumber, 
	and the last number is the value of @MaxNumber. 
	Print each number on the new line.
*/
DECLARE @MinNumber INT = 4
DECLARE @MaxNumber INT = 18
WHILE @MinNumber <= @MaxNumber
BEGIN
		PRINT @MinNumber
        SET @MinNumber = @MinNumber + 1
END

/*
	Print the sequence of odd numbers where all numbers are greater then zero and, 
	and the last number is lower or equal than the @MaxNumber. 
	Print each number on the new line.
*/
DECLARE @MaxNumber INT = 22
DECLARE @Number INT = 1

WHILE @Number > 0 AND @Number<= @MaxNumber
BEGIN
		PRINT @Number
        SET @Number = @Number + 2
END

/*
	Select top N countries from the table Country.
	Select each country in a separated result set.
	N is equal to the variable @TopCountries.
*/
DECLARE @TopCountries INT = 3
DECLARE @Id INT = 1

WHILE @Id <= @TopCountries
BEGIN
	SELECT * FROM Country c WHERE c.Id = @Id
    SET @Id = @Id + 1
END

