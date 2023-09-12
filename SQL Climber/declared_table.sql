/*
	Info:
	Declared tables as variables are not necessary for the elementary level, 
	but I am going to use them as part of the assignments, so I want to show them first.

	Assignment's instructions:
    There is declared table @Country with a few records.
    Select all records from table @Country.
*/

DECLARE @Country TABLE
(
    Id INT,
    Name NVARCHAR(100),
    Capital NVARCHAR(100)
)
INSERT INTO @Country (Id, Name, Capital) VALUES
(1, 'China', 'Beijing'),
(2, 'Japan', 'Tokyo'),
(3, 'India', 'New Delhi'),
(4, 'South Korea', 'Seoul'),
(5, 'Indonesia', 'Jakarta')

SELECT * FROM @Country;


/*
	There is declared table @Country and declared letter @Letter.
    Select capitals that contain declared letter.
    Sort the capitals in ascending order.
*/


DECLARE @Letter NVARCHAR(1) = 'e'
  
SELECT c.Capital FROM @Country c WHERE CHARINDEX(@Letter, c.Capital) > 0 ORDER BY c.Capital;

/*
    Select all countries from the declared table @Country 
    that are not in the permanent table Country. 
    Select the following columns:
    - Country - country name
	- Capital - capital name
	Sort the records in ascending order by country name.
*/

  
SELECT t.Name, t.Capital 
FROM @Country t LEFT JOIN Country c 
ON (t.Name=c.Name) WHERE c.Id IS NULL ORDER BY t.Name;




