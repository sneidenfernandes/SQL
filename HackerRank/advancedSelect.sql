/* Type of Triangle */

SELECT 
    CASE
        WHEN
            (A+B>C) AND (B+C>A) AND (A+C>B)
        THEN
            CASE 
                WHEN (A=B) AND (B=C) THEN 'Equilateral'
                WHEN (A=C) OR (B=C) OR (A=B) THEN 'Isosceles'
                ELSE 'Scalene'
            END
        ELSE
            'Not A Triangle'
    END 
FROM 
    TRIANGLES;


/* The PADS */

SELECT CONCAT(NAME, '(',LEFT(OCCUPATION,1), ')') 
    FROM OCCUPATIONS
    ORDER BY NAME;
    
SELECT CONCAT('There are a total of ',COUNT(OCCUPATION),' ',LOWER(OCCUPATION),'s.')
    FROM OCCUPATIONS
    GROUP BY OCCUPATION
    ORDER BY COUNT(OCCUPATION), OCCUPATION;


/* Occupations */
with professor as(
Select 
    name,
    row_number() over (order by name) as rn
from occupations 
where occupation like 'Professor'
)
, doctor  as (
Select 
    name,
    row_number() over (order by name) as rn
from occupations
where occupation like 'doctor'
)
, singer as (
Select 
    name,
    row_number() over (order by name) as rn
from occupations
where occupation like 'Singer'
)
, actor as (
Select 
    name,
    row_number() over (order by name)  as rn
from occupations
where occupation like 'Actor'
)


Select 
    d.name,
    p.name,
    s.name,
    a.name
from professor p
left join doctor d on d.rn = p.rn
left join singer s on s.rn = p.rn
left join actor  a on a.rn = p.rn;

/* Binary Tree Nodes */

SELECT B.N,
    CASE
        WHEN B.P IS NULL THEN 'Root'
        WHEN B.P IS NOT NULL AND B.N IN (SELECT DISTINCT P FROM BST) THEN 'Inner'
        ELSE 'Leaf'
    END AS 'Type'
FROM BST B ORDER BY B.N;



/* New Companies */

SELECT c.company_code, c.founder, COUNT(DISTINCT l.lead_manager_code) ,
        COUNT(DISTINCT s.senior_manager_code), COUNT(DISTINCT m.manager_code),
        COUNT( DISTINCT e.employee_code)
    FROM Company c  
    JOIN  Lead_Manager l ON c.company_code = l.company_code
    JOIN  Senior_Manager s ON c.company_code = s.company_code
    JOIN  Manager m ON c.company_code = m.company_code
    JOIN  Employee e ON c.company_code = e.company_code
GROUP BY c.company_code, c.founder ORDER BY c.company_code;

