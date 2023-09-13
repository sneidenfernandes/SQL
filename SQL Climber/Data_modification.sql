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

/*
    Insert the following records into the declared table @Country:
    Id  Name            Capital
    2   Japan           Tokyo
    3   India           New Delhi
    4   South Korea     Seoul
*/
DECLARE @Country TABLE
(
    Id INT PRIMARY KEY,
    Name NVARCHAR(100),
    Capital NVARCHAR(100)
)
INSERT INTO @Country (Id, Name, Capital) VALUES (1, 'China', 'Beijing')
INSERT INTO @Country(Id, Name, Capital) VALUES(2, 'Japan', 'Tokyo');
INSERT INTO @Country(Id, Name, Capital) VALUES(3, 'India', 'New Delhi');
INSERT INTO @Country(Id, Name, Capital) VALUES(4, 'South Korea', 'Seoul');
SELECT * FROM @Country
