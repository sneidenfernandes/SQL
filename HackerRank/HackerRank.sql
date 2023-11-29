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


/*
Revising Aggreagations - Count Function 
*/

SELECT COUNT(*) FROM CITY WHERE POPULATION > 100000;

/*
Revising Aggregations - Sum Function
*/

SELECT SUM(POPULATION) FROM CITY WHERE DISTRICT = 'CALIFORNIA';

/*
Revising Aggregations - Averages
*/

SELECT AVG(POPULATION) FROM CITY WHERE DISTRICT = 'CALIFORNIA';


/*
Average Population 
*/

SELECT ROUND(AVG(POPULATION), 0) FROM CITY;


/*
Japan Population 
*/

SELECT SUM(POPULATION) FROM CITY WHERE COUNTRYCODE = 'JPN'; 

/*
Population Denisty Difference
*/
SELECT MAX(POPULATION) - MIN(POPULATION) FROM CITY;

/*
The Blunder
*/

SELECT ROUND(AVG(SALARY)) - ROUND(AVG(REPLACE(SALARY,0,''))) FROM EMPLOYEES;

/*
Top Earners
*/

SELECT SALARY*MONTHS, COUNT(*) FROM EMPLOYEE
WHERE SALARY*MONTHS = (SELECT MAX(SALARY*MONTHS) FROM EMPLOYEE)
GROUP BY SALARY*MONTHS;


/*
Draw A Triangle 1
*/
DELIMITER //
CREATE PROCEDURE printStars( value int)
BEGIN
    WHILE value > 0 DO
        SELECT repeat('* ', value) as '';
        SET value = value - 1;
    END WHILE;
END  //
DELIMITER ;

CALL printStars(20);

/*
Draw A Triangle 2
*/

DELIMITER //

CREATE PROCEDURE PrintPattern(i INT)
BEGIN 
    DECLARE counter INT; 
    SET counter = 1;
    WHILE counter <= i  DO
        SELECT REPEAT('* ', counter) AS '';
        SET counter = counter + 1;
    END WHILE;
    
END //

DELIMITER ;

CALL PrintPattern(20);

/*
New Companies
*/

SELECT c.company_code, c.founder, COUNT(DISTINCT l.lead_manager_code) ,
        COUNT(DISTINCT s.senior_manager_code), COUNT(DISTINCT m.manager_code),
        COUNT( DISTINCT e.employee_code)
    FROM Company c  
    JOIN  Lead_Manager l ON c.company_code = l.company_code
    JOIN  Senior_Manager s ON c.company_code = s.company_code
    JOIN  Manager m ON c.company_code = m.company_code
    JOIN  Employee e ON c.company_code = e.company_code
GROUP BY c.company_code, c.founder ORDER BY c.company_code;

/*
Weather Observation 18
*/

SELECT ROUND(ABS(MAX(LAT_N)-MIN(LAT_N))+ABS(MAX(LONG_W)-MIN(LONG_W)),4) FROM STATION;

/*
Weather Observatiom 19
*/

SELECT ROUND(
            SQRT(POWER(P.b-P.a,2) + POWER(P.d-P.c,2))
            ,4) 
FROM 
(SELECT MIN(LAT_N) a, MAX(LAT_N) b, MIN(LONG_W) c, MAX(LONG_W) d FROM STATION) AS P;


/*
Weather Observation 20
*/
SET @row_count = (SELECT CAST(FLOOR(COUNT(*)/2) AS SIGNED) FROM STATION);

PREPARE stmt FROM 'SELECT ROUND(LAT_N,4) FROM STATION ORDER BY LAT_N LIMIT 1 OFFSET ?';

EXECUTE stmt USING @row_count;

