/*
    Select from the table TouristAttraction the following columns for the declared city:
    - Name - Name of a tourist attraction
    - DescriptionLength - Length of description
*///
DECLARE @CityId INT = 1
SELECT t.Name, LEN(t.Description) AS DescriptionLength
FROM TouristAttraction t WHERE t.CityId = @CityId;


/*
    Select cities that name length is equal to @CityLength.
    Use ascending order by city name.
*/
DECLARE @CityLength INT = 5
SELECT ci.Name AS City FROM City ci WHERE LEN(ci.Name) = @CityLength
ORDER BY City;


/*
    Select from the table City the following columns:
    - City - City name
    - Characters - Number of characters in the city name
    Use descending order by Characters and then ascending order by city name.
*/
SELECT ci.Name AS City, LEN(ci.Name) AS Characters FROM City ci 
ORDER BY Characters DESC, ci.Name ASC;

/*
	Select from the table TouristAttraction the following columns for the declared city:
    - Name - Name of a tourist attraction
    - Description - If there is no description, the value is 'No description.'
*/
DECLARE @CityId INT = 7
SELECT t.Name, COALESCE(t.Description, 'No description.') AS Description FROM TouristAttraction t WHERE t.CityId=@CityId;


/*
    Select from the table City the following columns for the declared country:
    - Name - Name of a city
    - Info - "The population of {city name} is {city population} people." (e.g. "The population of Paris is 2206000 people.")
*/

SELECT
    City.Name AS Name,
    CAST(('The population of ' + Name + ' is ' + CAST(Population AS NVARCHAR(100)) + ' people.') AS NVARCHAR(160)) AS Info 
FROM 
    City
WHERE
    City.CountryId = @CountryId;



/*
    Select from the declared table @TextValue all records 
    where TextValue column can be converted into a number.
*/
DECLARE @TextValues TABLE
(
    Id INT IDENTITY(1, 1)
   ,TextValue NVARCHAR(100)
)

INSERT @TextValues (TextValue) 
VALUES ('100'), ('One million'), ('65536'), ('No value') 


SELECT * FROM @TextValues t WHERE ISNUMERIC(t.TextValue) = 1;

/*
    Select from the table @Rounding the following columns:
    - Original - Value from column Number
    - TwoDecimalDigits - Value number rounded to two decimal digits.
    - NoDecimalDigits - Value number rounded to zero decimal digits.
    - RoundDown - Value number rounded down.
    - RoundUp - Value number rounded up.
*/
DECLARE @Rounding TABLE
(
    Id INT IDENTITY(1, 1)
   ,Number DECIMAL(16,4)
)

INSERT @Rounding (Number) 
VALUES ('12.5976'), ('7.3209'), ('12.5652'), ('19.5946'), ('11.7187')
SELECT Number AS Original, ROUND(Number,2) AS TwoDecimalDigits, ROUND(Number,0) AS NoDecimalDigits, 
FLOOR(Number) AS RoundDown, CEILING(Number) AS RoundUp FROM @Rounding;

