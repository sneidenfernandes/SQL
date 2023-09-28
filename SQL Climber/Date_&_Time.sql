/*
	Set variable @event to 'Independence Day'
	Set variable @date on 4. july 1776
*/
DECLARE @Event NVARCHAR(100)
DECLARE @Date DATE

SET @Event = 'Independence Day'

SET @Date = '1776-07-04'

SELECT
	'@Event' = @Event
   ,'@Date' = @Date


/*
	Set variable @event to 'Independence Day'
	Set variable @date on 4. July 1776 17:43
*/
DECLARE @Event NVARCHAR(100)
DECLARE @Datetime DATETIME


SET @Event = 'Independence Day'

SET @Datetime = '1776-07-04 17:43'

SELECT
	'@Event' = @Event
   ,'@Datetime' = @Datetime  


/*
	There is declared @Datetime2 variable with default precision.
	Declare new variables @MinimalPrecision and @MaximumPrecision.
	Set new variables to the value of @Datetime2.
*/
DECLARE @Datetime2 DATETIME2 = '2020-12-31 23:59:59.1234567'
DECLARE @MinimalPrecision DATETIME2(0) = @Datetime2
DECLARE @MaximumPrecision DATETIME2(7) = @Datetime2


SELECT
    'MinimalPrecision' = @MinimalPrecision
   ,'MaximumPrecision' = @MaximumPrecision 


/*
	Declare a variable @Smalldatetime1 and set it to the value of @Datetime1.
	Declare a variable @Smalldatetime2 and set it to the value of @Datetime2.
*/
DECLARE @Datetime1 DATETIME2(0) = '2019-12-31 23:59:30'
DECLARE @Datetime2 DATETIME2(0) = '2019-12-31 23:59:29'

DECLARE @Smalldatetime1 SMALLDATETIME = @Datetime1
DECLARE @Smalldatetime2 SMALLDATETIME = @Datetime2

SELECT
	'@Smalldatetime1' = @Smalldatetime1
   ,'@Smalldatetime2' = @Smalldatetime2  


/*
    There is declared variable @Time with precision 5.
	Declare a variable @Time0 with precision 0 and set it to the value of @Time.
	Declare a variable @Time7 with precision 7 and set it to the value of @Time.
*/
DECLARE @Time TIME(5) = '23:59:59.12345'

DECLARE @Time0 TIME(0) = @Time
DECLARE @Time7 TIME(7) = @Time


SELECT 
	'@Time' = @Time
   ,'@Time0' = @Time0
   ,'@Time7' = @Time7 


