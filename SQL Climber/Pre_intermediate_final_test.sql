/*
	If @Airplane contains more than one space in a row, reduce them to the one.
*/
DECLARE @Airplane NVARCHAR(1000) = 'The  first          airplane was  invented in 1903        by                             brothers Wright.'
WHILE CHARINDEX('  ', @Airplane) > 0
BEGIN
	SET @Airplane = REPLACE(@Airplane, '  ', ' ')
END
SELECT [Airplane] = @Airplane

/*
    There is declared @FlightTime.
	Convert quoted words to the upper-case and remove quotation marks.
	The variable value could contain N quoted words.
*/
DECLARE @FlightTime NVARCHAR(1000) = 'The flight from "London" to "New York" takes 7 hours and 45 minutes.'
DECLARE @Start INT
DECLARE @End INT
DECLARE @Word NVARCHAR(100)
WHILE CHARINDEX('"', @FlightTime) > 0
BEGIN
	SET @Start = CHARINDEX('"', @FlightTime)
    
    SET @END = CHARINDEX('"', @FlightTime, @Start+1)
    
    
    SET @Word = SUBSTRING(@FlightTime, @Start+1, @End-@Start-1)
    
    SET @Word = UPPER(@Word)
    
    SET @FlightTime = REPLACE(@FlightTime, '"' + @Word + '"', @Word)
END
SELECT [FlightTime] = @FlightTime

/*
    There is declared the flight date.
    Calculate how many years, months, and days have passed since this date till today.
*/
DECLARE @Flight DATE = '1927-12-31'
DECLARE @Today DATE = GETDATE()
DECLARE @Years INT = DATEDIFF(YEAR, @Flight, @Today)
DECLARE @endMonth INT = DATEPART(MONTH, @Today)
DECLARE @startMonth INT = DATEPART(MONTH, @Flight)
DECLARE @startDays INT = DATEPART(DAY, @Flight)
DECLARE @endDays INT = DATEPART(DAY, @Today)
DECLARE @Months INT = @endMonth - @startMonth
DECLARE @Days INT =  @endDays - @startDays

IF @days < 0
BEGIN
    SET @months = @months - 1
    SET @days = DATEDIFF(DAY, DATEADD(MONTH, @months, DATEADD(YEAR, @years, @Flight)), @Today)
END
   	
IF @months < 0
BEGIN
    SET @years = @years - 1
    SET @months = 12 + @months
END

DECLARE @Result NVARCHAR(169) = 'The first solo nonstop transatlantic flight was '+CAST(@Years AS NVARCHAR(169))+
		' years, '+CAST(@Months AS NVARCHAR(169))+' months, and '+CAST(@days AS NVARCHAR(169))+' days ago.'
        
SELECT 'Spirit of St. Louis' = @Result;

