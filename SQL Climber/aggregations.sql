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

