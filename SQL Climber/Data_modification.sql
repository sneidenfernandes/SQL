/*
    Insert the following record into the declared table @Country:
    Id  Name    Capital
    1   China   Beijing
*/
DECLARE @Country TABLE
(
    Id INT PRIMARY KEY,
    Name NVARCHAR(100),
    Capital NVARCHAR(100)
)

INSERT INTO @Country VAlUES(1, 'China', 'Beijing');

SELECT * FROM @Country
