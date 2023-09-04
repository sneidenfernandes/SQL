/*
	Take a look at the DB diagram to see database tables and relations.
	Select all columns from the Country table.
*/
SELECT * FROM Country;


/*
	Select the Name and Capital columns from the Country.
*/
SELECT Name,Capital FROM Country;

/*
	Select the Name and Description columns from the TouristAttraction.
*/
SELECT Name,Description from TouristAttraction;

/*
	Select the Name and Capital columns from the Country.
	Please use an alias, then you could use IntelliSense for columns.
*/
SELECT c.Name, c.Capital FROM COUNTRY c;

/*
	Select the following columns from the Country:
	- CountryName - Name of the Country
	- Capital - Capital of the Country
	- Currency - Currency code of the Country

	There are more ways how to create an alias. 
	Look at the hint.
*/
SELECT Name AS CountryName, Capital AS Capital, CurrencyCode AS Currency FROM  Country;


/*
	Select the following columns from the Country:
	- Country name - Name of the Country
	- Capital - Capital of the Country
	- Currency code - Currency code of the Country

	There are more ways how to create an alias with spaces or special characters. 
	Look at the hint.
*/
SELECT Name AS 'Country name', Capital, CurrencyCode AS 'Currency code' FROM Country;


/*
    Select the Name column from the Country.
    Sort the records in ascending order.
*/
SELECT c.Name FROM Country c ORDER BY c.Name;


/*
	Select the Name and Capital columns from the Country.
    Sort the records in descending order by the Capital.
*/
SELECT c.Name,c.Capital FROM Country c ORDER BY c.Capital DESC;


/*
    Select the following columns from the Country:
    - Name
    - EuropeUnionMember
    - Population
    Sort the records in descending order by column EuropeUnionMember, and then in descending order by column Population.
*/

SELECT c.Name, c.EuropeUnionMember, c.Population FROM Country c ORDER BY c.EuropeUnionMember DESC, c.Population DESC;

/*
    Select the first five countries with the smallest population from the Country.
*/
SELECT TOP 5 * FROM Country ORDER BY Population ASC;




