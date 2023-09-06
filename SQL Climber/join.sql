/*
	Join tables Country and City. Select the following columns:
    - Country - country name
    - City - city name
    - Population - city population
	Sort the records in descending order by column Population.
*/

SELECT c.Name AS Country ,ci.Name AS City ,ci.Population 
FROM Country c JOIN City ci ON c.Id = ci.CountryId 
ORDER BY ci.Population DESC; 

/*
	Join tables Country and City. Select the following columns for the declared @Country:
    - Country - country name
    - City - city name
    - Population - city population
	Sort the records in ascending order by column City.
*/
DECLARE @Country NVARCHAR(100) = 'Spain'
SELECT c.Name AS Country, ci.Name AS City, ci.Population 
FROM Country c JOIN City ci ON c.ID = ci.CountryID 
WHERE c.Name = @Country ORDER BY ci.Name; 

/*
	Join tables City and TouristAttraction. 
	Select the following columns for the declared @City:
    - TouristAttraction - tourist attraction name
    - Description - tourist attraction description
	Sort the records in ascending order by column TouristAttraction.
*/
DECLARE @City NVARCHAR(100) = 'Rome'
SELECT t.Name TouristAttraction, t.Description 
FROM City c JOIN TouristAttraction t on t.CityId = c.Id 
WHERE c.Name = @City ORDER BY t.Name ASC;

/*
	Join tables Country and Company.
	Select the following columns for the declared @Country:
    - Country - country name
    - Company - company name
	- Industry - company industry
	Sort the records in ascending order by column Company.
*/
DECLARE @Country NVARCHAR(100) = 'Germany'

SELECT c.Name AS Country, co.Company As Company, co.Industry as Industry 
FROM Country c JOIN Company co ON c.Id = co.CountryId
WHERE c.Name = @Country ORDER BY co.Company;



/*
	Join tables Country and City. Select the following columns:
    - Capital - capital name
    - Population - capital population
	Sort the records in descending order by column Population.
*/

SELECT c.Capital, ci.Population
FROM Country c JOIN City ci
ON c.Capital = ci.Name ORDER BY ci.Population DESC;

/*
    Select all tourist attractions that are in the same city as declared attraction @TouristAttraction.
	Select the following columns:
	- TouristAttraction - tourist attraction name
    - Description - tourist attraction description
    Sort the records in ascending order by column TouristAttraction.
*/
DECLARE @TouristAttraction NVARCHAR(100) = 'Sistine Chapel'
SELECT ta2.Name, ta2.Description FROM TouristAttraction ta1 JOIN TouristAttraction ta2 
ON ta1.cityId = ta2.CityId WHERE ta1.Name = @TouristAttraction; 

/*
    Select other cities that are in the same country as the declared city @City.
	Sort the records in ascending order by column Name.
*/
DECLARE @City NVARCHAR(100) = 'Milan'
SELECT ci1.Id,ci2.CountryId,ci1.Name,ci1.Population 
FROM City ci1 JOIN City ci2 ON (Ci1.CountryId = ci2.CountryId) 
WHERE ci2.Name = @City AND ci1.Name <> @City ORDER BY ci1.Name ;

/*
    Join tables Country, City, and TouristAttraction.
    Select the following columns for declared country:
    - Country - country name
    - City - city name
	- Attraction - tourist attraction name
*/
DECLARE @CountryId INT = 5
SELECT c.Name AS Country, ci.Name AS City, t.Name AS Attraction 
FROM Country c JOIN City ci 
ON (c.ID=ci.CountryId) JOIN TouristAttraction t ON (ci.Id=t.CityId) WHERE c.Id = @CountryId;

/*
    Join tables TouristAttraction, City, and Country.
    Select the following columns for declared tourist attraction:
    - Country - country name
    - City - city name
    - Attraction - tourist attraction name
*/
DECLARE @TouristAttaction NVARCHAR(100) = 'Buckingham Palace'

SELECT c.Name AS 'Country', ci.Name AS 'City', t.Name as 'Attraction' 
FROM Country c JOIN City ci 
ON (c.ID = ci.CountryId) JOIN TouristAttraction t ON (ci.Id = t.CityId)
WHERE t.Name = @TouristAttaction;

/*
    Join tables TouristAttraction, City, Country, and Company.
    Select companies that are in the same country as the declared tourist attraction.
    Select the following columns:
    - Country
    - Company
    - Industry
*/
DECLARE @TouristAttaction NVARCHAR(100) = 'Reichstag building'
SELECT c.Name AS 'Country',co.Company AS 'Company',co.Industry AS 'Industry'
FROM TouristAttraction t JOIN City ci ON (t.CityId=ci.Id)
JOIN Country c  ON (ci.CountryId=c.Id) 
JOIN Company co ON (co.CountryId=c.Id)
WHERE t.Name = @TouristAttaction;

/*
	Join tables Country and City.   
    Select the following columns for all capital cities:
    - Capital - capital city name
    - Population - capital city population
    If table city does not contain a capital city, the population value is NULL.
*/

SELECT c.Capital, ci. Population 
FROM Country c LEFT JOIN City ci on (c.Capital=ci.Name);

/*
	Join tables Company and Country.
    Select the following columns for all companies:
    - Company
	- Industry
    - Country - country name
	If there is no information about the country, the country value is NULL.
*/
SELECT co.Company AS 'Company', co.Industry As 'Industry', c.Name AS 'Country'  
FROM Company co LEFT JOIN Country c ON (co.CountryId=c.Id);

/*
	Join tables Country and City.
    Select all countries that have no records in the table City.
*/

SELECT c.Id,c .Name,c.Capital,c.CurrencyCode,c.Population,c.EuropeUnionMember 
FROM Country c LEFT JOIN City ci ON (c.Id=ci.CountryId) WHERE ci.Id IS NULL;

/*
	Join tables Country and Company.
    Select all countries that have no records in the table Company.
*/

SELECT c.Id, c.Name, c.Capital, c.CurrencyCode, c.Population, c.EuropeUnionMember 
FROM Country c LEFT JOIN Company co ON (c.Id = co.CountryId) 
WHERE co.Id IS NULL;

/*
	Join tables Country and City.
	Select all capitals that have no records in the table City.
*/

SELECT c.Capital FROM Country c LEFT JOIN City ci 
ON (ci.CountryId=c.ID) WHERE ci.ID IS NULL;

/*
	Join tables Country and City.
	Select all city names from table City that are not capitals.

	(I know you can solve it with LEFT JOIN, but please use the RIGHT JOIN)
*/

SELECT ci.Name As 'City' 
FROM Country c LEFT JOIN City ci 
ON (c.Id = ci.CountryId) WHERE c.Capital <> ci.Name;


/*
	Join tables City and Country.
	Select all possible flights from the declared city to all capitals in the table Country. 
	Select the following columns:
    - Flight departure - city name
    - Flight arrival - the capital of a country
	Sort the records in ascending order by flight arrival.
*/
DECLARE @CityId INT = 14

SELECT ci.Name AS 'Flight depature', c.Capital As 'Flight arrival'
FROM City ci CROSS JOIN Country c WHERE ci.Id = @CityId
ORDER BY c.Capital ASC;


