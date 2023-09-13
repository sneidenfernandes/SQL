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


/*
    Insert the following records into the declared table @Country:
    Id  Name            Capital
    1   China           Beijing
    2   Japan           Tokyo
    3   India           New Delhi
    4   South Korea     Seoul
*/
DECLARE @Country TABLE
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Capital NVARCHAR(100)
)
INSERT INTO @Country(Name, Capital) VALUES('China', 'Beijing');
INSERT INTO @Country(Name, Capital) VALUES('Japan', 'Tokyo');
INSERT INTO @Country(Name, Capital) VALUES('India', 'New Delhi');
INSERT INTO @Country(Name, Capital) VALUES('South Korea', 'Seoul');

SELECT * FROM @Country


/*
    Insert all records from the permanent table Country into the declared table @Country.
*/
DECLARE @Country TABLE
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Capital NVARCHAR(100)
)
INSERT INTO @Country(Name, Capital)  SELECt c.Name,c.Capital FROM Country c;
SELECT * FROM @Country

