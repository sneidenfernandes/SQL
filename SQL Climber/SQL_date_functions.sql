/*
    Set variable @Today to the current date.
*/
DECLARE @Today DATE


SET @Today = GETDATE()

SELECT
	'@Today' = @Today

/*
    Set variable @Today to the current date.
*/
DECLARE @Today DATETIME

SET @Today = CONVERT(DATE, GETDATE())

SELECT
	'@Today' = @Today


/*
	Set declared variables to the correct part of the valuer of @Date.
*/
DECLARE @Date DATETIME = '1969-07-20 20:17:40.123' -- UTC
DECLARE @Quarter INT
DECLARE @DayOfYear INT
DECLARE @Week INT
DECLARE @Weekday INT
DECLARE @Millisecond INT

SET @Quarter = DATEPART(QUARTER, @Date);
SET @DayOfYear = DATEPART(DAYOFYEAR, @Date);
SET @Week = DATEPART(WEEK, @Date);
SET @Weekday = DATEPART(WEEKDAY, @Date);
SET @Millisecond = DATEPART(MILLISECOND,@Date)

SELECT
	'@Quarter' = @Quarter
   ,'@DayOfYear' = @DayOfYear
   ,'@Week' = @Week
   ,'@Weekday' = @Weekday
   ,'@Millisecond' = @Millisecond



/*
	Set declared variables to the correct part of the valuer of @Date.
	Please do not use function DATEPART.
*/
DECLARE @Date DATE = GETDATE()
DECLARE @Year INT
DECLARE @Month INT
DECLARE @Day INT

/*
	Set declared variables to the correct part of the valuer of @Date.
	Please do not use function DATEPART.
*/
DECLARE @Date DATE = GETDATE()
DECLARE @Year INT
DECLARE @Month INT
DECLARE @Day INT

SELECT
    '@Year' = @Year
   ,'@Month' = @Month
   ,'@Day' = @Day

/*
	Set the duration variables to the correct value of difference.
*/
DECLARE @War NVARCHAR(100) = 'American Revolutionary War'
DECLARE @Beginning DATE = '1775-04-19'
DECLARE @End DATE = '1783-09-03'
DECLARE @DurationInYears INT
DECLARE @DurationInMonths INT


SET @DurationInYears = DATEDIFF(YEAR, @Beginning, @End);
SET @DurationInMonths = DATEDIFF(MONTH, @Beginning, @End);

SELECT
	'@War' = @War
   ,'@DurationInYears' = @DurationInYears
   ,'@DurationInMonths' = @DurationInMonths


/*
	Select the following columns:
	- Title
	- DurationInWeeks
	- DurationInMilliseconds
*/
DECLARE @War TABLE 
(
	Id INT IDENTITY
   ,Title NVARCHAR(100)
   ,StartDate DATE
   ,EndDate DATE
)
INSERT @War (Title, StartDate, EndDate)
VALUES 
('Dutch War for Independence', '1568-01-01', '1648-01-01'), -- I don't know exact dates :)
('American Revolutionary War', '1775-04-19', '1783-09-03'),
('World War I', '1914-07-28', '1918-11-11')

SELECT 
	w.Title,
    'DurationInWeeks' = DATEDIFF(WEEK, w.StartDate, w.EndDate),
    'DurationInMilliseconds' = DATEDIFF_BIG(MILLISECOND, w.StartDate, w.EndDate)
FROM 
	@War w;

/*
    There is declared the contract length in days and the first day of the contract.
	Calculate the last day of the contract.
*/
DECLARE @ContractLengthInDays INT = 14
DECLARE @FirstDayOfContract DATE = GETDATE()
DECLARE @LastDayOfContract DATE

SET @LastDayOfContract = DATEADD(DAY, @ContractLengthInDays-1, @FirstDayOfContract)

SELECT
    '@FirstDayOfContract' = @FirstDayOfContract
   ,'@LastDayOfContract' = @LastDayOfContract

/*
    There is declared the contract length and the last day of the contract.
	The contract was signed two days before the first day of contract.
	Calculate the first day and the the day of signed.
*/
DECLARE @ContractLengthInDays INT = 90
DECLARE @SignedContract DATE
DECLARE @FirstDayOfContract DATE
DECLARE @LastDayOfContract DATE = GETDATE()

SET @SignedContract = DATEADD(DAY, -(@ContractLengthInDays)-1, @LastDayOfContract);
SET @FirstDayOfContract = DATEADD(DAY, -(@ContractLengthInDays)+1,@LastDayOfContract);

SELECT
    '@SignedContract' = @SignedContract
   ,'@FirstDayOfContract' = @FirstDayOfContract
   ,'@LastDayOfContract' = @LastDayOfContract

/*
    There is declared variable @Datetime with date and time.
	Set the variable to the next day to 8:00 pm.
*/
DECLARE @Today DATETIME2(0) = CONVERT(DATE, GETDATE())
DECLARE @Datetime DATETIME2(0) = DATEADD(MINUTE, 2000, @Today)
  
SET @Datetime = CONVERT(DATE, @Datetime);
SET @Datetime = DATEADD(DAY, 1, @Datetime);
SET @DATETIME = DATEADD(HOUR, 20, @Datetime);

SELECT 
	'@Datetime' = @Datetime

/*
	Set the variable to the date with the correct year, month, and day. 
*/
DECLARE @Year INT = 1776
DECLARE @Month INT = 7
DECLARE @Day INT = 4
DECLARE @Date DATE

SET @Date = CONCAT(CAST(@Year AS NVARCHAR(4)), '-', CAST(@Month AS NVARCHAR(2)), '-', CAST(@Day AS NVARCHAR(2)))

SELECT
	'@Year' = @Year
   ,'@Month' = @Month
   ,'@Day' = @Day
   ,'@Date' = @Date

/*
	Set the variables @Datetime and @Datetime2 to the dates with correct date parts.
*/
DECLARE @Year INT = 1776
DECLARE @Month INT = 7
DECLARE @Day INT = 4
DECLARE @Hour INT = 8
DECLARE @Minute INT = 16
DECLARE @Second INT = 30
DECLARE @Milliseconds  INT = 60  
DECLARE @Datetime DATETIME
DECLARE @Datetime2 DATETIME2(5)

SET @Datetime = DATETIMEFROMPARTS(@Year, @Month, @Day, @Hour, @Minute, @Second, @Milliseconds);
SET @Datetime2 = DATETIME2FROMPARTS(@Year,@Month, @Day, @Hour, @Minute, @Second, @Milliseconds,3);

SELECT
    '@Datetime' = @Datetime
   ,'@Datetime2' = @Datetime2


/*
	Select the following columns from the table @Dates:
    - DateString - value from table
    - Date - DateString value converted to DATE.
    If DateString value cannot convert to DATE, it is NULL.
*/
DECLARE @Dates TABLE (DateString NVARCHAR(100))
INSERT INTO @Dates (DateString)
VALUES 
('1776-07-04'),
('There is no date'),
('2020-01-01'),
('null')

SELECT 
	d.DateString,
    'Date' = CASE 
    				WHEN ISDATE(d.DateString) = 1 THEN CAST(d.DateString AS DATE)
                    ELSE NULL
    		 END
FROM 
	@Dates d;

/*
    Calculate the first day of the month for the declared date.
*/
DECLARE @Date DATE = '2028-02-23'
DECLARE @FirstDayOfTheMonth DATE

SET @FirstDayOfTheMonth = DATEADD(DAY, -DATEPART(DAY, @Date)+1, @Date)

SELECT
	'@Date' = @Date
   ,'@FirstDayOfTheMonth' = @FirstDayOfTheMonth 

/*
    Calculate the last day of the month for the declared date.
*/
DECLARE @Date DATE = '2028-02-23'
DECLARE @LastDayOfTheMonth DATE


SET @LastDayOfTheMonth = EOMONTH(@Date)

SELECT
	'@Date' = @Date
   ,'@LastDayOfTheMonth' = @LastDayOfTheMonth 

/*
    Fill weekday name and month name by declared date. 
*/
DECLARE @Date DATE = GETDATE()
DECLARE @WeekdayName NVARCHAR(100)
DECLARE @MonthName NVARCHAR(100)

/*
    Fill weekday name and month name by declared date. 
*/
DECLARE @Date DATE = GETDATE()
DECLARE @WeekdayName NVARCHAR(100)
DECLARE @MonthName NVARCHAR(100)

SET @WeekdayName = DATENAME(WEEKDAY, @Date)
SET @MonthName = DATENAME(MONTH, @Date)




