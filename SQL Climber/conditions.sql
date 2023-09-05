/*
	Select countries where the Capital column has the value "Madrid".
*/

SELECT * FROM Country c WHERE c.Capital = 'Madrid';

/*
	Select countries where the Population column has a value greater than 50 million.
*/
SELECT * FROM Country c WHERE c.Population > 50000000;


/*
	Select countries where the Id column has a value not equal to 2.
*/

SELECT * FROM Country c WHERE c.Id != 2;


/*
    Select countries where the Id column has a value lower than or equal to 3.
*/

SELECT * FROM Country c WHERE c.Id <= 3;

/*
	Select countries where the Population column has a value greater than or equal to 44 million.
*/

SELECT * FROM Country c WHERE c.Population >= 44000000;


/*
    Select countries that are members of the European Union and they don't use Euro.
*/


SELECT * FROM Country c WHERE c.EuropeUnionMember = 1 AND c.CurrencyCode != 'EUR';


/*
    Select countries where the capital is Amsterdam, Paris, or Madrid.
*/

SELECT * FROM Country c WHERE c.Capital IN ('Amsterdam','Paris', 'Madrid')


/*
	Select countries that fulfill one of the following conditions:
	- Population is from 10 million to 20 million.
	- Population is from 44 million to 55 million.
*/

SELECT * FROM Country c WHERE (c.Population BETWEEN 10000000 AND 20000000) OR (c.Population BETWEEN 44000000 AND 55000000);


/*
	Select countries that fulfill one of the following conditions:
	- Population is from 10 million to 20 million.
	- Population is from 44 million to 55 million.

	Please use the keywords BETWEEN.
*/


SELECT * FROM Country c WHERE (c.Population BETWEEN 10000000 AND 20000000) OR (c.Population BETWEEN 44000000 AND 55000000);


/*
	Select countries whose population is not between 15 million and 55 million.
*/


SELECT * FROM Country c WHERE (c.Population NOT BETWEEN 15000000 AND 55000000); 


/*
    Select countries where the capital city starts with the letter 'A'.
*/


SELECT * FROM Country c WHERE c.Capital LIKE 'A%';



/*
    Select countries where the capital city ends with the letter 'e'.
*/

SELECT * FROM Country c WHERE c.Capital LIKE '%e';


/*
    Select countries that capital contains letters 'a' or 'A'.
*/

SELECT * FROM Country c WHERE (c.Capital LIKE '%A%') OR (c.Capital LIKE '%a%'); 


/*
	Select countries that haven't information about their currency.
*/

SELECT * FROM Country c WHERE c.CurrencyCode IS NULL;

/*
	Select countries that have information about their currency.
*/

SELECT * FROM Country c WHERE c.CurrencyCode IS NOT NULL;

/*
	Select countries that currency is not Euro (it could be GBP, CZK ... or NULL). 
*/

SELECT * FROM Country c WHERE (c.CurrencyCode != 'EUR') OR (c.CurrencyCode IS NULL);


/*
    Select countries that match all of the following conditions:
    - They are a member of the Europe Union.
    - Their population is from 25 million to 100 million.
    - Their currency is Euro.
*/

SELECT * FROM COUNTRY c
WHERE (c.EuropeUnionMember=1)
AND (c.Population BETWEEN 25000000 AND 100000000)
AND (c.CurrencyCode = 'EUR');


/*
    Select countries that match at least one of the following conditions:
    - There is no information about currency.
    - They don't use the Euro.
*/

SELECT * FROM COUNTRY c
WHERE (c.CurrencyCode IS NULL) OR (c.CurrencyCode != 'EUR');

/*
    Select countries that match at least one of the following conditions:
    - They are not a member of the Europe Union.
    - The country name contains more than one word.
*/

SELECT * FROM COUNTRY c
WHERE (c.EuropeUnionMember=0) OR (c.Name LIKE '% %');






