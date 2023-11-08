/**
Revising the Select Query I
**/
SELECT * FROM CITY WHERE COUNTRYCODE ='USA'  AND POPULATION > 100000;

/**
Revising the Select Query II
**/
SELECT ROUND(SUM(LAT_N),4) FROM STATION WHERE (LAT_N > 38.7880) AND (LAT_N < 137.2345);

/**
Select All
**/
SELECT * FROM CITY;

/**
Select By ID
**/
SELECT * FROM CITY WHERE ID = 1661;

/**
Japanese Cities' Attributes
**/
SELECT * FROM CITY ci WHERE ci.COUNTRYCODE = 'JPN';

/**
Japanese Cities' Names
**/
SELECT ci.NAME FROM CITY ci WHERE ci.COUNTRYCODE = 'JPN';

/**
Weather Observation Station 1
**/
SELECT s.CITY, s.STATE FROM STATION s;

/**
Weather Observation Station 3
**/
SELECT DISTINCT(CITY) FROM STATION WHERE MOD(ID,2) = 0;

/**
Weather Observation Station 4
**/
SELECT COUNT(s.CITY) - COUNT(DISTINCT(s.CITY)) FROM STATION s;

/**
Weather Observation Station 5
**/
SELECT s.CITY,LENGTH(s.CITY) FROM STATION AS s ORDER BY LENGTH(s.CITY) ASC,s.CITY LIMIT 1;
SELECT s.CITY,LENGTH(s.CITY) FROM STATION AS s ORDER BY LENGTH(s.CITY) DESC, s.CITY LIMIT 1;

/**
Weather Observation Station 6
**/
SELECT DISTINCT(s.CITY) FROM STATION AS s 
WHERE 
    s.CITY LIKE 'A%' 
    OR 
    s.CITY LIKE 'E%' 
    OR
    s.CITY LIKE 'O%' 
    OR 
    s.CITY LIKE 'I%' 
    OR
    s.CITY LIKE 'U%';


/**
Weather Observation Station 7
**/
SELECT DISTINCT(s.CITY) FROM STATION AS s 
WHERE 
    s.CITY LIKE '%a' 
    OR 
    s.CITY LIKE '%e' 
    OR
    s.CITY LIKE '%i' 
    OR 
    s.CITY LIKE '%o' 
    OR
    s.CITY LIKE '%u';

