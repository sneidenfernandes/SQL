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

/* wrote this to maintain my streak
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


/*
    Select all tourist attractions that are in the same country as the declared tourist attraction.
    Select the following columns:
	- City - city name
    - Attraction - attraction name 
	- Description - attraction description
    Use ascending order by city name and attraction name.
*/

DECLARE @TouristAttractionId INT = 8

SELECT ci.Name AS City, t.Name AS t, t.Description AS Description FROM City ci JOIN TouristAttraction t ON (ci.Id=t.CityId)
WHERE ci.CountryId=(SELECT DISTINCT(ci1.CountryId) FROM City ci1 JOIN TouristAttraction t1 ON (ci1.Id=t1.CityId) WHERE t1.Id = @TouristAttractionId )
ORDER BY ci.Name, t.Name;

/*
    Select cities that match at least one of the following conditions:
    - City population is larger than @MinPopulation
    - City is capital
    Select the following columns:
    - Country
    - City
    - Population
    Use descending order by city population.
*/
DECLARE @MinPopulation INT = 1000000
SELECT c.Name AS Country, ci.Name AS City, ci.Population FROM City ci JOIN Country c ON (c.ID = ci.CountryId)
WHERE ci.Population > @MinPopulation AND ci.Name = c.Capital; 


/* 
    Set variables @CityName, @CityPopulation for the declared city @CityId.
    Set variables @SmallerCityId, @SmallerCityName, @SmallerCityPopulation for a smaller city.
    The smaller city is the city with the largest population of the cities 
    which has a lower population than the declared city.
*/
DECLARE @CityId INT = 7
DECLARE @CityName NVARCHAR(100)
DECLARE @CityPopulation INT
DECLARE @SmallerCityId INT
DECLARE @SmallerCityName NVARCHAR(100)
DECLARE @SmallerCityPopulation INT

SELECT @CityName = ci.Name, @CityPopulation= ci.Population FROM City ci WHERE ci.Id = @CityId;

SELECT TOP 1 @SmallerCityId = ci.Id, @SmallerCityName = ci.Name, @SmallerCityPopulation = ci.Population 
FROM City ci WHERE ci.Population < @CityPopulation ORDER BY ci.Population DESC;

SELECT 
    '@CityId' = @CityId
   ,'@CityName'= @CityName 
   ,'@CityPopulation' = @CityPopulation
SELECT 
    '@SmallerCityId' = @SmallerCityId
   ,'@SmallerCityName' = @SmallerCityName
   ,'@SmallerCityPopulation' = @SmallerCityPopulation


/*
    Select cities whose population difference is not higher than half a million from the declared city.
    Select the following columns:
    - Name - city name
    - Population - city population
    - PopulationDifference - formula: city population - declared city population
    Use descending order by city population.
*/
DECLARE @CityId INT = 12
DECLARE @CityPopulation INT;

SELECT @CityPopulation = ci.Population FROM City ci WHERE ci.Id = @CityId;

SELECT ci.Name AS Name, ci.Population As Population, (ci.Population-@CityPopulation) As PopulationDifference 
FROM City ci WHERE (ci.Population-@CityPopulation) < 500000
ORDER BY ci.Population DESC;


/*
	E-shop wants to expand to new markets:
	- Insert products of the declared category into the table @ExpandingProduct with new currency and recalculated price.
    - All new prices should contain 95 cents/penny, so fix it after recalculation.
*/
DECLARE @ExpandingProduct TABLE
(
	Title NVARCHAR(100)
   ,Description NVARCHAR(1000)
   ,Brand NVARCHAR(100)
   ,CategoryId INT
   ,UnitPrice DECIMAL(18,2)
   ,Currency NVARCHAR(3)
)

DECLARE @Category NVARCHAR(100) = 'Headphones'
DECLARE @NewCurrency TABLE (Currency NVARCHAR(3), ExchangeRate DECIMAL(18, 2))
INSERT INTO @NewCurrency (Currency, ExchangeRate) VALUES ('EUR', 0.89), ('GBP', 0.80)
-- Insert products into @ExpandingProduct with new currency and recalculated price
INSERT INTO @ExpandingProduct( Title, Description, Brand, CategoryId, UnitPrice,Currency)

SELECT
	P.Title,
    P.Description,
    P.Brand,
    P.CategoryId,
    UnitPrice = CAST((P.UnitPrice * NC.ExchangeRate) AS INT) + 0.95,
    NC.Currency
FROM 
    Eshop.Product P
CROSS JOIN 
	@NewCurrency NC
WHERE P.CategoryId = (SELECT Ca.Id FROM Eshop.Category Ca WHERE Ca.Title=@Category)
ORDER BY 
	UnitPrice;


/*
    E-shop wants to change prices:
    - Calculate new unit prices at table @PreparePrice for the declared category.
    - All new prices higher than 100 dollars should be without cents. Round them up. 
*/
DECLARE @PreparePrice TABLE
(
	ProductId INT
   ,Title NVARCHAR(100)
   ,UnitPrice DECIMAL(18,2)
   ,NewUnitPrice DECIMAL(18,2)
)
INSERT INTO @PreparePrice (ProductId, Title, UnitPrice)
SELECT 
	p.Id
   ,p.Title
   ,p.UnitPrice
FROM Eshop.Product p

DECLARE @ParentCategory NVARCHAR(100) = 'Men''s Accessories'
DECLARE @PriceIncreaseInPercentage INT = 7


INSERT INTO @PreparePrice (ProductId, Title, UnitPrice, NewUnitPrice)

SELECT 
	P.Id,
    P.Title,
    P.UnitPrice,
	NewUnitPrice = CASE
    					WHEN UnitPrice * (1 + @PriceIncreaseInPercentage / 100.0) > 100 
       				    THEN CEILING(UnitPrice * (1 + @PriceIncreaseInPercentage / 100.0))
                        WHEN UnitPrice * (1 + @PriceIncreaseInPercentage / 100.0) <= 100 
                        THEN (UnitPrice * (1+@PriceIncreaseInPercentage/100))
    			   END
FROM Eshop.Product P
JOIN Eshop.Category C ON (P.CategoryId=C.Id)
WHERE C.ParentCategoryId = (SELECT cat.Id From Eshop.Category cat WHERE cat.Title=@ParentCategory);

SELECT * FROM @PreparePrice pp WHERE pp.NewUnitPrice IS NOT NULL







