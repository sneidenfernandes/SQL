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
Weather Observation Station 2
**/

SELECT ROUND(SUM(LAT_N), 2), ROUND(SUM(LONG_W), 2) FROM STATION;

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

/**
Weather Observation Station 8
**/

SELECT DISTINCT CITY FROM STATION 
WHERE 
    (CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u') 
AND 
    (CITY LIKE 'a%' OR CITY LIKE 'e%' OR CITY LIKE 'i%' OR CITY LIKE 'o%' OR CITY LIKE 'u%');


/**
Weather Observation Station 9
**/

SELECT DISTINCT CITY FROM STATION 
WHERE NOT (CITY LIKE 'a%' OR CITY LIKE 'e%' OR CITY LIKE 'i%' OR CITY LIKE 'o%' OR CITY LIKE 'u%');

/**
Weather Observation Station 10
**/

SELECT DISTINCT CITY FROM STATION 
WHERE NOT (CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' or city '%o' or  city like '%u');


/**
Weather Observation Station 11
**/

SELECT DISTINCT CITY FROM STATION 
WHERE LEFT(CITY,1)  ('A','E','I','O','U') OR RIGHT(CITY,1) NOT IN ('A','E','I','O','U');


/**
Weather Observation Station 12
**/

SELECT DISTINCT CITY FROM STATION 
WHERE LEFT(CITY,1) NOT IN ('A','E','I','O','U') AND RIGHT(CITY, 1) NOT IN  ('A','E','I','O','U');


/**
Higher Than 75 Marks
**/

SELECT NAME FROM STUDENTS 
WHERE MARKS > 75 ORDER BY SUBSTR(NAME,-3,3), ID;

/**
Employee Names
**/

SELECT NAME FROM EMPLOYEE ORDER BY NAME ASC;

/**
Employee Names
**/

SELECT NAME FROM EMPLOYEE WHERE SALARY > 2000 AND MONTHS < 10;

/*
 The PADS
*/

SELECT CONCAT(NAME, '(',LEFT(OCCUPATION,1), ')') 
    FROM OCCUPATIONS
    ORDER BY NAME;
    
SELECT CONCAT('There are a total of ',COUNT(OCCUPATION),' ',LOWER(OCCUPATION),'s.')
    FROM OCCUPATIONS
    GROUP BY OCCUPATION
    ORDER BY COUNT(OCCUPATION), OCCUPATION;

/*
Binary Tree Nodes
*/

SELECT B.N,
    CASE
        WHEN B.P IS NULL THEN 'Root'
        WHEN B.P IS NOT NULL AND B.N IN (SELECT DISTINCT P FROM BST) THEN 'Inner'
        ELSE 'Leaf'
    END AS 'Type'
FROM BST B ORDER BY B.N;

/* 
Average Populatiohn
*/


SELECT ROUND(AVG(POPULATION), 0) FROM CITY;

/*
Japanese Population
*/

SELECT SUM(POPULATION) FROM CITY WHERE COUNTRYCODE = 'JPN'; 
