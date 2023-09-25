/*
    Select from the table Country the following columns:
    - Records - Count of all records in the table. 
*/
SELECT count(c.ID) AS Records FROM Country c;


/*
    Select from the table Country the following columns:
    - Records - Count of all records in the table.
    - CurrencyCodes - Count of values in the CurrencyCode column.
*/

SELECT COUNT(c.ID) AS Records,COUNT(c.CurrencyCode) AS CurrencyCodes FROM Country c;

/*
    Select from the table Country the following columns:
    - Records - Count of all records in the table.
    - CurrencyCodes - Count of values in the CurrencyCode column.
    - UniqueCurrencyCodes - Count of unique values in the CurrencyCode column.
*/

SELECT COUNT(c.ID) AS Records, COUNT(c.CurrencyCode) AS CurrencyCodes, COUNT(DISTINCT(c.CurrencyCode)) AS UniqueCurrencyCodes FROM Country c; 

/*
    Select from the table Country the following columns:
    - LowestPopulation - Value of the lowest population.
    - HighestPopulation - Value of the highest population
*/

SELECT MIN(c.Population) AS LowestPopulation, MAX(c.Population) AS HighestPopulation FROM Country c;

/*
    Select from the table Country the following columns:
    - TotalPopulation - Sum of all countries population.
    - AveragePopulation - Value of average population.
*/

SELECT SUM(c.Population) AS TotalPopulation, AVG(c.Population) AS AveragePopulation FROM Country c;

/*
    Select all unique currency codes (excluding NULL) from the table Country.
*/

SELECT DISTINCT(c.CurrencyCode) FROM Country c WHERE c.CurrencyCode IS NOT NULL;


/*
    Select from the table Country the following columns:
    - CurrencyCode - Currency code (excluding NULL)
    - Countries - Count of the countries which use this currency
*/

SELECT DISTINCT(c.CurrencyCode) AS CurrencyCode, COUNT(c.ID) AS Countries FROM Country c WHERE c.CurrencyCode IS NOT NULL GROUP BY CurrencyCode;

/*
    Join tables Country and City. Select the following columns:
    - Country - Name of the country.
    - Cities - Count of the cities in the table City for the country.
    Use descending order by Cities, then ascending order by country name. 
*/


SELECT c.Name AS Country, COUNT(ci.Name) AS Cities FROM Country c LEFT JOIN City ci ON (c.Id=ci.CountryId) 
GROUP BY c.Name ORDER BY Cities DESC, Country ASC;

/*
    Join tables Country and Company. Exclude countries with no companies.
    Select the following columns:
    - Country - Name of the country
    - Companies - Count of the companies in the table Company for the country.
    Use ascending order by country name.
*/

SELECT c.Name AS Country, COUNT(co.Id) AS Companies FROM Country c JOIN Company co ON (c.Id=co.CountryId) 
GROUP BY c.Name ORDER BY c.Name;

/*
    Select from the table Company the following columns:
    - Industry - Name of the industry
    - Companies - Count of the companies in the industry.
*/

SELECT co.Industry, COUNT(co.ID) AS Companies FROM company co
GROUP BY co.Industry; 


/*
    Join tables Country and City. Exclude countries with no cities.
    Select the following columns:
    - Country - Name of the country.
    - Cities - Count of the cities in the table City for the country.
    - AveragePopulation - Average population in cities.
    Use descending order by AveragePopulation.
*/

SELECT c.Name AS Country, COUNT(ci.ID) AS Cities, AVG(ci.Population) AS AveragePopulation
FROM Country c JOIN City ci  ON (c.Id=ci.CountryId) GROUP BY c.Name ORDER BY AveragePopulation DESC;
 
/*
    Select from the table Company the following columns:
    - Industry - Name of industry.
    - Companies - Count of the companies in the industry.
    Select only those industries that contain more than one company.
*/
SELECT co.Industry, COUNT(co.Company) AS Companies FROM Company co GROUP BY co.Industry HAVING COUNT(co.Company) > 1;

/*
    Select from the table Company the following columns:
    - Industry
    - Companies - Count of the companies in the industry.
    Select only those industries that contain at least @MinCompanies companies.
    Use descending order by the count of companies, then ascending order by industry.
*/
DECLARE @MinCompanies INT = 1
SELECT co.Industry, COUNT(co.Company) AS Companies FROM Company co 
GROUP BY co.Industry HAVING COUNT(co.Company) >= @MinCompanies
ORDER BY Companies DESC, co.Industry ASC;


/*
    Join tables Country and City. Select the following columns:
    - Name - Name of the country.
    - Cities - Count of the cities in the country.
    - Population - Sum of the population of the cities in the country.
    Select only those countries that sum of the population is at least @MinPopulation.
    Use descending order by Population.
*/
DECLARE @MinPopulation INT = 3000000

SELECT c.Name, COUNT(ci.Name) AS Cities, SUM(ci.Population) AS Population  FROM Country c LEFT JOIN City ci ON (c.Id=ci.CountryId)
GROUP BY c.Name HAVING SUM(ci.Population) >= @MinPopulation
ORDER BY SUM(ci.Population) DESC;


/*
    Join tables City and TouristAttraction. Select the following columns:
    - City - Name of the city.
    - TouristAttractions - Count of the tourist attractions in table TouristAttraction for the city.
    Select only those cities which has more attractions than the value of @TouristAttractions.
    Use descending order by TouristAttractions, then ascending order by city name.
*/
DECLARE @TouristAttractions INT = 2
SELECT ci.Name AS City, COUNT(t.Name) AS TouristAttractions FROM City ci JOIN TouristAttraction t ON (ci.Id=t.CityId)
GROUP BY ci.Name HAVING COUNT(t.Name) > @TouristAttractions  ORDER BY COUNT(t.Name) DESC, ci.Name;

/*
    Join tables Country, City and TouristAttraction. Select the following columns:
    - Country - Name of the country.
    - Attractions - Count of the tourist attractions in the table TouristAttraction for the country.
    Select only those countries that number of attraction is at least @MinimumAttractions and at most @MaximumAttractions
    Use descending order by Attractions, then ascending order by country name.
*/
SELECT
    C.Name AS Country,
    COUNT(TA.Id) AS Attractions
FROM
    Country C
LEFT JOIN
    City CI ON C.Id = CI.CountryId
LEFT JOIN
    TouristAttraction TA ON CI.Id = TA.CityId
GROUP BY
    C.Name
HAVING
    COUNT(TA.Id) BETWEEN @MinimumAttractions AND @MaximumAttractions
ORDER BY
    Attractions DESC, Country ASC;

