/*
	Select all countries from the table Country in which the capital is Madrid, Paris, or Rome.
*/

SELECT * FROM Country c WHERE c.Capital IN ('Madrid','Paris','Rome');



/*
	Select all countries for the declared country IDs.
*/
DECLARE @CountryId1 INT = 3
DECLARE @CountryId2 INT = 9
DECLARE @CountryId3 INT = 13

SELECT * FROM Country c WHERE c.Id IN (@CountryId1,@CountryId2,@CountryId3);

/*
	Select all countries that IDs are contained in the declared table @Filter.
*/
DECLARE @Filter TABLE 
(
	CountryId INT
)
INSERT INTO @Filter (CountryId) VALUES (13), (3), (11), (5)

SELECT * FROM Country c WHERE c.ID IN (SELECT * FROM @Filter);


/*
	Select all countries that IDs are not contained in the declared table @NegativeFilter.
*/
DECLARE @NegativeFilter TABLE 
(
	CountryId INT
)
INSERT INTO @NegativeFilter (CountryId) VALUES (2), (7), (9), (10), (11)

/*
	Select all countries that IDs are not contained in the declared table @NegativeFilter.
*/
DECLARE @NegativeFilter TABLE 
(
	CountryId INT
)
INSERT INTO @NegativeFilter (CountryId) VALUES (2), (7), (9), (10), (11)

SELECT * FROM Country c WHERE c.ID NOT IN (SELECT * FROM @NegativeFilter);


	Select all countries that currencies are not contained in the declared table @NegativeFilter.
*/
DECLARE @NegativeFilter TABLE 
(
	CurrencyCode VARCHAR(3)
)
INSERT INTO @NegativeFilter (CurrencyCode) VALUES ('EUR'), ('UAH')

SELECT * FROM Country c 
WHERE c.CurrencyCode NOT IN 
(SELECT * FROM @NegativeFilter) OR c.CurrencyCode IS NULL;


SELECT 
c.Name AS Country,'Is a memeber of the OECD' = CASE WHEN c.OecdMember = 0 THEN 'NO'
										        WHEN c.OecdMember = 1 THEN 'YES'
                                           ELSE '-'
										   END

 FROM @Country c;


/*
    Select the following columns from the declared table @Math:
    - Number1
    - Number2
    - MathOperation
    - Result - contain the result of math operation
*/
DECLARE @Math TABLE
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Number1 DECIMAL(16,2),
    Number2 DECIMAL(16,2),
    MathOperation NVARCHAR(100)
)
INSERT INTO @Math (Number1, Number2, MathOperation)
VALUES
(128, 48, 'Addition'),
(128, 48, 'Subtraction'),
(128, 48, 'Multiplication'),
(128, 48, 'Division')

SELECT
m.Number1,
m.Number2,
m.MathOperation,
'Result' = CASE WHEN m.MathOperation = 'Addition' THEN Number1 + Number2
		        WHEN m.MathOperation = 'Subtraction' THEN Number1 - Number2
                WHEN m.MathOperation = 'Multiplication' THEN Number1 * Number2
                WHEN m.MathOperation = 'Division' THEN Number1/Number2
           END
FROM @Math m;

/*
    Calculate the result of the math operation and set it into the variable @Result.
    @MathOperation could contain values Addition, Subtraction, Multiplication, or Division.
*/
DECLARE @Number1 DECIMAL(16,2) = 128
DECLARE @Number2 DECIMAL(16,2) = 48
DECLARE @MathOperation NVARCHAR(100) = 'Subtraction'
DECLARE @Result DECIMAL(16,2)

SET @Result = CASE WHEN @MathOperation = 'Addition' THEN @Number1 + @Number2
				      WHEN @MathOperation = 'Subtraction' THEN @Number1 - @Number2
                      WHEN @MathOperation = 'Multiplication' THEN  @Number1 * @Number2
                      WHEN @MathOperation = 'Division'       THEN @Number1/@Number2
                 END


/*
	Select all countries from the table Country
    If the value of @OrderBy is 'Country', then use ascending order by country name.
	If the value of @OrderBy is 'Capital', then use ascending order by capital.
*/
DECLARE @OrderBy NVARCHAR(100) = 'Country'

SELECT * FROM Country c ORDER BY CASE WHEN @OrderBy = 'Country' THEN c.Name
									  WHEN @OrderBY =  'Capital' THEN c.Capital
								 END

/*
	There are declared @Dividend and @Divisor.
    Calculate @Result and @Remainder with correct values.
*/
DECLARE @Dividend INT = 21
DECLARE @Divisor INT = 8
DECLARE @Result INT
DECLARE @Remainder INT
SELECT @Result = @Dividend/@Divisor,
	   @Remainder = @Dividend % @Divisor
SELECT
	'@Result' = @Result
   ,'@Remainder' = @Remainder


/*
    There are declared @Number and @NumberType. 
    Calculate @NumberType with value 'Even number' or 'Odd number'.
*/
DECLARE @Number INT = 20
DECLARE @NumberType NVARCHAR(100)


/*
    There are declared @Number and @NumberType. 
    Calculate @NumberType with value 'Even number' or 'Odd number'.
*/
DECLARE @Number INT = 20
DECLARE @NumberType NVARCHAR(100)
SELECT @NumberType = CASE WHEN (@Number%2) = 0 THEN  'Even number'
					  WHEN (@Number%2) = 1 THEN  'Odd number'
				 END
SELECT
	'@Number' = @Number
   ,'@NumberType' = @NumberType


/*
    Select two groups of countries from the table @Country:
    - The first group where Id is an odd number
    - The second group where Id is even number
*/
DECLARE @Country TABLE 
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Capital NVARCHAR(100)
)
INSERT INTO @Country (Name, Capital) VALUES
('China', 'Beijing'), 
('Japan', 'Osaka'),
('India', 'New Delhi'), 
('South Korea', 'Seoul'),
('Indonesia', 'Jakarta'),
('Saudi Arabia', 'Riyadh'),
('Taiwan', 'Taipei'),
('Thailand', 'Bangkok')

/*
    Select two groups of countries from the table @Country:
    - The first group where Id is an odd number
    - The second group where Id is even number
*/
DECLARE @Country TABLE 
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Capital NVARCHAR(100)
)
INSERT INTO @Country (Name, Capital) VALUES
('China', 'Beijing'), 
('Japan', 'Osaka'),
('India', 'New Delhi'), 
('South Korea', 'Seoul'),
('Indonesia', 'Jakarta'),
('Saudi Arabia', 'Riyadh'),
('Taiwan', 'Taipei'),
('Thailand', 'Bangkok')

SELECT * FROM @Country c WHERE c.ID%2 = 1;
SELECT * FROM @Country c WHERE c.ID%2 = 0;
