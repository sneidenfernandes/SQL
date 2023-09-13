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


/*
    Increase salaries in the table @Employee according to the table @SalaryIncrease.   
    If the increase Column has a negative value, zero, or a NULL value, do not update the salary.  
*/
DECLARE @Employee TABLE
(
    Id INT IDENTITY(1,1) PRIMARY KEY
   ,FirstName NVARCHAR(100)
   ,Surname NVARCHAR(100)
   ,Salary DECIMAL(19,2)
)
INSERT @Employee (FirstName, Surname, Salary) VALUES 
('Michael', 'Barker', 2750), ('Robert', 'Morton', 1550),
('John', 'Mitchell', 1890), ('William', 'Davison', 1840),
('James', 'Houston', 1800), ('Mark', 'Parsons', 2060),
('David', 'Higgins', 1950), ('Richard', 'Frost', 1470),
('Frank', 'Herbert', 2100), ('Brian', 'Matthews', 1930)

DECLARE @SalaryIncrease TABLE
(
    EmployeeId INT
   ,Increase DECIMAL(19,2)
)
INSERT @SalaryIncrease (EmployeeId, Increase) 
VALUES (2, 200), (6, 200), (4, -300), (10, NULL)


UPDATE e
SET e.Salary  = CASE WHEN (s.Increase < 0) OR (s.Increase = 0) OR (s.Increase IS NULL) THEN e.Salary
				ELSE e.Salary + s.Increase
                END
FROM @Employee e JOIN @SalaryIncrease s ON (e.Id=s.EmployeeId);
SELECT e.FirstName, e.Surname, e.Salary FROM @Employee e ORDER BY e.Salary DESC




/*
    Increase salaries of all employees.
    If the table @SalaryIncrease contains a record for an employee, 
    then increase salary according to the table @SalaryIncrease.
    Otherwise, increase salary by percentage.
    The variable @SalaryIncreaseInPercentage defines the percentage of increase.    
*/
DECLARE @Employee TABLE
(
    Id INT IDENTITY(1,1) PRIMARY KEY
   ,FirstName NVARCHAR(100)
   ,Surname NVARCHAR(100)
   ,Salary DECIMAL(19,2)
)
INSERT @Employee (FirstName, Surname, Salary) VALUES 
('Michael', 'Barker', 2750), ('Robert', 'Morton', 1550),
('John', 'Mitchell', 1890), ('William', 'Davison', 1840),
('James', 'Houston', 1800), ('Mark', 'Parsons', 2060),
('David', 'Higgins', 1950), ('Richard', 'Frost', 1470),
('Frank', 'Herbert', 2100), ('Brian', 'Matthews', 1930)

DECLARE @SalaryIncrease TABLE
(
    EmployeeId INT
   ,Increase DECIMAL(19,2)
) 
INSERT @SalaryIncrease (EmployeeId, Increase) 
VALUES (3, 300), (4, 320), (6, 260), (8, 50)

DECLARE @SalaryIncreaseInPercentage DECIMAL(16, 
UPDATE e
SET e.Salary = CASE WHEN s.Increase IS NOT NULL THEN e.Salary + s.Increase
		            ELSE e.Salary * (100 + @SalaryIncreaseInPercentage) / 100
		       END
FROM @Employee e JOIN @SalaryIncrease s ON (e.Id=s.EmployeeId);
SELECT e.FirstName, e.Surname, e.Salary FROM @Employee e ORDER BY e.Salary DESC




/*
    Delete all records from the table @Employee.
*/
DECLARE @Employee TABLE
(
    Id INT IDENTITY(1,1) PRIMARY KEY
   ,FirstName NVARCHAR(100)
   ,Surname NVARCHAR(100)
   ,Salary DECIMAL(19,2)
)
INSERT @Employee (FirstName, Surname, Salary) VALUES 
('Michael', 'Barker', 2750), ('Robert', 'Morton', 1550),
('John', 'Mitchell', 1890), ('William', 'Davison', 1840),
('James', 'Houston', 1800), ('Mark', 'Parsons', 2060),
('David', 'Higgins', 1950), ('Richard', 'Frost', 1470),
('Frank', 'Herbert', 2100), ('Brian', 'Matthews', 1930)

DELETE FROM @Employee;

SELECT e.FirstName, e.Surname, e.Salary FROM @Employee e ORDER BY e.Salary DESC



/*
    Delete records from the table @Employee where the surname is @Surname1, @Surname2, or @Surname3.
*/
DECLARE @Employee TABLE
(
    Id INT IDENTITY(1,1) PRIMARY KEY
   ,FirstName NVARCHAR(100)
   ,Surname NVARCHAR(100)
   ,Salary DECIMAL(19,2)
)
INSERT @Employee (FirstName, Surname, Salary) VALUES 
('Michael', 'Barker', 2750), ('Robert', 'Morton', 1550),
('John', 'Mitchell', 1890), ('William', 'Davison', 1840),
('James', 'Houston', 1800), ('Mark', 'Parsons', 2060),
('David', 'Higgins', 1950), ('Richard', 'Frost', 1470),
('Frank', 'Herbert', 2100), ('Brian', 'Matthews', 1930)

-- Employees for delete
DECLARE @Surname1 NVARCHAR(100) = 'Mitchell'
DECLARE @Surname2 NVARCHAR(100) = 'Higgins'
DECLARE @Surname3 NVARCHAR(100) = 'Matthews'
DELETE e FROM @Employee e WHERE e.Surname IN (@Surname1, @Surname2, @Surname3);

SELECT e.FirstName, e.Surname, e.Salary FROM @Employee e ORDER BY e.Salary DESC

/*
    Delete employees from the table @Employee who earn more than @MaximumSalary.
*/
DECLARE @Employee TABLE
(
    Id INT IDENTITY(1,1) PRIMARY KEY
   ,FirstName NVARCHAR(100)
   ,Surname NVARCHAR(100)
   ,Salary DECIMAL(19,2)
)
INSERT @Employee (FirstName, Surname, Salary) VALUES 
('Michael', 'Barker', 2750), ('Robert', 'Morton', 1550),
('John', 'Mitchell', 1890), ('William', 'Davison', 1840),
('James', 'Houston', 1800), ('Mark', 'Parsons', 2060),
('David', 'Higgins', 1950), ('Richard', 'Frost', 1470),
('Frank', 'Herbert', 2100), ('Brian', 'Matthews', 1930)

DECLARE @MaximumSalary DECIMAL(19,2) = 2000



/*
    Delete employees from the table @Employee who earn more than @MaximumSalary.
*/
DECLARE @Employee TABLE
(
    Id INT IDENTITY(1,1) PRIMARY KEY
   ,FirstName NVARCHAR(100)
   ,Surname NVARCHAR(100)
   ,Salary DECIMAL(19,2)
)
INSERT @Employee (FirstName, Surname, Salary) VALUES 
('Michael', 'Barker', 2750), ('Robert', 'Morton', 1550),
('John', 'Mitchell', 1890), ('William', 'Davison', 1840),
('James', 'Houston', 1800), ('Mark', 'Parsons', 2060),
('David', 'Higgins', 1950), ('Richard', 'Frost', 1470),
('Frank', 'Herbert', 2100), ('Brian', 'Matthews', 1930)

DECLARE @MaximumSalary DECIMAL(19,2) = 2000
    
DELETE e FROM @Employee e WHERE e.Salary > @MaximumSalary;

SELECT e.FirstName, e.Surname, e.Salary FROM @Employee e ORDER BY e.Salary DESC


/*
    Delete employees from the table @Employee whose surnames are in the table @EmployeeForDelete.
*/
DECLARE @Employee TABLE
(
    Id INT IDENTITY(1,1) PRIMARY KEY
   ,FirstName NVARCHAR(100)
   ,Surname NVARCHAR(100)
   ,Salary DECIMAL(19,2)
)
INSERT @Employee (FirstName, Surname, Salary) VALUES 
('Michael', 'Barker', 2750), ('Robert', 'Morton', 1550),
('John', 'Mitchell', 1890), ('William', 'Davison', 1840),
('James', 'Houston', 1800), ('Mark', 'Parsons', 2060),
('David', 'Higgins', 1950), ('Richard', 'Frost', 1470),
('Frank', 'Herbert', 2100), ('Brian', 'Matthews', 1930)

-- Employees for delete
DECLARE @EmployeeForDelete TABLE (Surname NVARCHAR(100))
INSERT INTO @EmployeeForDelete (Surname) VALUES ('Mitchell'), ('Higgins'), ('Herbert')

DELETE e FROM @Employee e WHERE e.Surname IN (SELECT * FROM @EmployeeForDelete);

SELECT e.FirstName, e.Surname, e.Salary FROM @Employee e ORDER BY e.Salary DESC



/*
    Delete employees from the table @Employee whose surnames are not in the table @EmployeeToSave.
*/
DECLARE @Employee TABLE
(
    Id INT IDENTITY(1,1) PRIMARY KEY
   ,FirstName NVARCHAR(100)
   ,Surname NVARCHAR(100)
   ,Salary DECIMAL(19,2)
)
INSERT @Employee (FirstName, Surname, Salary) VALUES 
('Michael', 'Barker', 2750), ('Robert', 'Morton', 1550),
('John', 'Mitchell', 1890), ('William', 'Davison', 1840),
('James', 'Houston', 1800), ('Mark', 'Parsons', 2060),
('David', 'Higgins', 1950), ('Richard', 'Frost', 1470),
('Frank', 'Herbert', 2100), ('Brian', 'Matthews', 1930)

-- Employees to save
DECLARE @EmployeeToSave TABLE (Surname NVARCHAR(100))
INSERT INTO @EmployeeToSave (Surname) VALUES ('Mitchell'), ('Higgins'), ('Herbert')

DELETE e FROM @Employee e WHERE e.Surname NOT IN (SELECT * FROM @EmployeeToSave);

SELECT e.FirstName, e.Surname, e.Salary FROM @Employee e ORDER BY e.Salary DESC





