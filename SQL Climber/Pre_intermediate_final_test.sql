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

