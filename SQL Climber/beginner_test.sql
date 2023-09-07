/* 
    There is defined a circle by radius.
    Calculate area and perimeter.
*/
DECLARE @Radius INT = 7
DECLARE @Perimeter DECIMAL(18, 4)
DECLARE @Area DECIMAL(18, 4)
 SELECT @Perimeter = 2 * (pi() * @Radius);
 SELECT  @Area = pi() * Power(@Radius,2);
SELECT 
    '@Perimeter' = @Perimeter
   ,'@Area' = @Area;


/*
    There is declared variable @CountryId.
	Print a sentence in the format: {capital} is the capital of {country}.
*/
DECLARE @CountryId INT = 14
DECLARE @Country NVARCHAR(30);
DECLARE @Capital NVARCHAR(30);

SELECT @Capital = c.Capital, @Country = c.Name FROM Country c WHERE c.ID = @CountryId;

PRINT CONCAT(@Capital,' is the capital of ',@Country);

/*
    Select all tourist attractions in the declared country which has a one-word name.
	Select the following columns:
	- City - city name
	- Attraction - tourist attraction name
	- Description - tourist attraction description
	Use ascending order by city and attraction.
*/
DECLARE @CountryId INT = 3

SELECT ci.Name AS City, t.Name AS Attraction, t.Description AS Description FROM City ci JOIN TouristAttraction t 
ON (ci.Id=t.CityId) JOIN Country c ON (ci.CountryId=c.ID)
WHERE (LEN(t.Name) - LEN(REPLACE(t.Name,' ','')) = 0) AND (c.Id = @CountryId)
ORDER BY City, Attraction;


/*
    Select all tourist attractions in declared countries which has a two-words name.
	Select the following columns:
	- City - city name
	- Attraction - tourist attraction name
	- Description - tourist attraction description
	Use ascending order by city and attraction.
*/
DECLARE @CountryId1 INT = 1
DECLARE @CountryId2 INT = 4
DECLARE @CountryId3 INT = 12
SELECT ci.Name AS 'City', t.Name AS 'Attraction', t.Description AS 'Description'
FROM City ci JOIN TouristAttraction t on (ci.Id=t.CityId) JOIN Country c ON (c.id=ci.CountryId) 
WHERE (LEN(t.Name)-LEN(REPLACE(t.Name,' ',''))=1) AND c.Id IN (@CountryId1,@CountryId2,@CountryId3) 
ORDER BY 'CITY','Attraction';



/*
    Select all possible flights from cities in the departure country to cities in the arrival country:
    Select the following columns:
    - Departure - Name of the city
    - Arrival - Name of the city
    Use ascending order by departure city and arrival city.
*/
DECLARE @DepartureCountryId INT = 2
DECLARE @ArrivalCountryId INT = 4
SELECT ci1.Name AS 'Departure', ci2.Name AS 'Arrival' FROM City ci1 CROSS JOIN City ci2 
WHERE (ci1.CountryId=@DepartureCountryId) AND (ci2.CountryId=@ArrivalCountryId)
ORDER BY ci1.Name,ci2.Name;

/*
	Select all possible flights from cities in the departure country to cities in the arrival country 
	with a stopover in a city in the stopover country.
	Select the following columns:
    - Departure - departure city name
    - Stopover - stopover city name
    - Arrival - arrival city name
    Use ascending order by departure city, stopover city, and arrival city.
*/
DECLARE @DepartureCountryId INT = 5
DECLARE @StopoverCountryId INT = 2
DECLARE @ArrivalCountryId INT = 7
SELECT ci1.Name AS Departure, ci2.Name AS Stopover, ci3.Name AS Arrival 
FROM City ci1 CROSS JOIN City ci2 CROSS JOIN City ci3
WHERE (ci1.CountryId=@DepartureCountryId)AND(ci2.CountryId=@StopoverCountryId)AND(ci3.CountryId=@ArrivalCountryId)
ORDER BY Departure, Stopover, Arrival;

/*
    Select all possible international flights from the capital of the declared country 
    to cities with a population of at least one million people.
    Select the following columns:
	- Departure - departure city name
    - Arrival - format: {arrival city} ({arrival country})
    Use descending order by arrival city population.
*/
DECLARE @CountryId INT = 4
SELECT c.Capital AS Departure, 
CONCAT(ci.Name,' (',(SELECT Name FROM Country WHERE Country.id = ci.CountryId),')') AS Arrival
FROM Country c CROSS JOIN City ci 
WHERE c.Id = @CountryId AND ci.Population >= 1000000 AND ci.CountryId <> c.Id
ORDER BY ci.Population DESC;


/*
    Select all cities which have no tourist attractions, and their population fits declared variables.
	Select the following columns:
    - City - city name
    - Population - city population
    Use descending order by population.
*/
DECLARE @MinPopulation INT = 1000000
DECLARE @MaxPopulation INT = 2000000
SELECT ci.Name AS City, ci.Population AS Population FROM City ci LEFT JOIN TouristAttraction t 
ON (ci.ID=t.CityId) 
WHERE (t.Name IS NULL) AND (ci.Population < @MaxPopulation AND ci.Population > @MinPopulation)
ORDER BY Population DESC;




