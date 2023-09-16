/*
    Select all records from the table Customer in schema Eshop.
*/

SELECT * FROM Eshop.Customer;


/*
    There are two tables Country, one in schema dbo, and the other one in schema Eshop.
    Select the first five countries from each table.
*/


SELECT TOP (5) * FROM dbo.Country;

SELECT TOP (5) * FROM Eshop.Country;

/*
    There are two tables Country, one in schema dbo, and the other one in schema Eshop.
    Select all countries from the table Country in schema Eshop 
    that have no records in the table Country in schema dbo.
*/

SELECT Eshop.Country.Name AS Name FROM Eshop.Country 
WHERE Name NOT IN (SELECT c.Name FROM Country c);
