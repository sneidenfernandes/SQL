/*
    There are two declared variables: @CountryName and @Capital.
    Print values of variables as messages in format:
	These are printed values:
    {country name}
    {capital}
*/

DECLARE @CountryName NVARCHAR(100) = 'France'
DECLARE @Capital NVARCHAR(100) = 'Paris'


-- Write your code here
PRINT 'These are printed values:'
PRINT @CountryName
PRINT @Capital


/*
	There are two declared variables: @CountryName and @Capital.
    Print values of variables as messages in format:
    Country name: {country name}
    Capital: {capital}
*/
DECLARE @CountryName NVARCHAR(100) = 'France'
DECLARE @Capital NVARCHAR(100) = 'Paris'

-- Write your code here
PRINT 'Country name: ' + @CountryName;
PRINT 'Capital: ' + @Capital;



