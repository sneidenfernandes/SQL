/*
    There are two declared variables: @CountryName and @Capital.
    Select values of the variables:
    - CountryName - value of the variable @CountryName
    - Capital - value of the variable @Capital
*/
DECLARE @CountryName NVARCHAR(100) = 'France'
DECLARE @Capital NVARCHAR(100) = 'Paris'

-- Write your code here
SELECT CountryName = @CountryName, Capital = @Capital;


/*
	There are two declared variables: @CountryName and @Capital.
	Set variable @CountryName with the value 'New Zealand'.
	Set variable @Capital with the value 'Wellington'.
*/
DECLARE @CountryName NVARCHAR(100)
DECLARE @Capital NVARCHAR(100)

SELECT @CountryName = 'New Zealand', @Capital = 'Wellington';


/*
	There are four declared country names.
    Set variable @CountryNameCsv with the values of declared countries separated by a comma.
    Format: {Country name 1},{Country name 2},{Country name 3},{Country name 4}
*/
DECLARE @CountryName1 NVARCHAR(100) = 'Germany'
DECLARE @CountryName2 NVARCHAR(100) = 'France'
DECLARE @CountryName3 NVARCHAR(100) = 'Italy'
DECLARE @CountryName4 NVARCHAR(100) = 'Spain'
DECLARE @CountryNameCsv NVARCHAR(100)

SELECT @CountryNameCsv = @CountryName1+','+@CountryName2+','+@CountryName3+','+@CountryName4;



/*
	There is declared the length and width of the rectangle.
    Calculate the area and perimeter of the rectangle
*/
DECLARE @RectangleLength INT = 12 
DECLARE @RectangleWidth INT = 5

DECLARE @RectangleArea INT
DECLARE @RectanglePerimeter INT
  
SELECT @RectangleArea = (@RectangleLength * @RectangleWidth);
SELECT @RectanglePerimeter = 2 * (@RectangleLength + @RectangleWidth);

SELECT
    '@RectangleArea' = @RectangleArea
   ,'@RectanglePerimeter' = @RectanglePerimeter



/*
	There is declared the variable @Capital.
    Select the country in which the capital is @Capital.
*/
DECLARE @Capital NVARCHAR(100) = 'Madrid'
SELECT * FROM Country c WHERE c.Capital = @Capital;


/*
	There are two declared variables: @MinimalPopulation and @MaximumPopulation.
    Select countries that population is between @MinimalPopulation and  @MaximumPopulation.
*/
DECLARE @MinimalPopulation INT = 10000000
DECLARE @MaximumPopulation INT = 30000000

SELECT * FROM Country c WHERE c.Population BETWEEN @MinimalPopulation AND @MaximumPopulation;

/*
	There is declared the variable @CountryId.
	Set other variables with the values of record which Id is @CountryId.
*/
DECLARE @CountryId INT = 9
DECLARE @CountryName NVARCHAR(100)
DECLARE @Capital NVARCHAR(100)
DECLARE @Population INT


/*
	There is declared the variable @CountryId.
	Set other variables with the values of record which Id is @CountryId.
*/
DECLARE @CountryId INT = 9
DECLARE @CountryName NVARCHAR(100)
DECLARE @Capital NVARCHAR(100)
DECLARE @Population INT

SELECT @CountryName = c.Name, @Capital = c.Capital, @Population = c.Population 
FROM Country c WHERE c.Id = @CountryId;

SELECT
    '@CountryId' = @CountryId
   ,'@CountryName' = @CountryName
   ,'@Capital' = @Capital
   ,'@Population' = @Population


/*
	Declare a new variable @Capital of type NVARCHAR(100) and set it with the value 'Wellington'.
    The variable is selected at the end of the script to check if you declare variable correctly.
*/

DECLARE @Capital NVARCHAR(100) = 'Wellington';

SELECT Capital = @Capital

/*
	Declare a new variable @TouristAttraction of type NVARCHAR(100) and set it with the value @Value1.
	Declare a new variable @Description of type NVARCHAR(500) and set it with the value @Value2.
*/
DECLARE @Value1 NVARCHAR(1000) = 'Machu Picchu'
DECLARE @Value2 NVARCHAR(1000) = 'Machu Picchu is an Incan citadel set high in the Andes Mountains in Peru, 
                                  above the Urubamba River valley. Built in the 15th century and later abandoned,
                                  it’s renowned for its sophisticated dry-stone walls that fuse huge blocks without the use of mortar, 
                                  intriguing buildings that play on astronomical alignments and panoramic views. 
                                  Its exact former use remains a mystery.'


DECLARE @TouristAttraction NVARCHAR(100) = @Value1
DECLARE @Description NVARCHAR(500) = @Value2

SELECT
	TouristAttraction = @TouristAttraction
   ,Description = @Description


/*
	The maximal length of the string value is important. 
	There is an example of how you can lose data by choosing an unsuitable maximal string length.

	Declare a new variable @Description500 of type NVARCHAR(500) and set it with the value @Description.
	Declare a new variable @Description100 of type NVARCHAR(100) and set it with the value @Description.
	Declare a new variable @Description20 of type NVARCHAR(20) and set it with the value @Description.
*/
DECLARE @Description NVARCHAR(1000) = 'Machu Picchu is an Incan citadel set high in the Andes Mountains in Peru,
  above the Urubamba River valley. Built in the 15th century and later abandoned, i
  t’s renowned for its sophisticated dry-stone walls that fuse huge blocks without the use of mortar, 
  intriguing buildings that play on astronomical alignments and panoramic views. Its exact former use remains a mystery.'

DECLARE @Description500 NVARCHAR(500) = @Description;
DECLARE @Description100 NVARCHAR(100) = @Description;
DECLARE @Description20 NVARCHAR(20)  = @Description;

PRINT 'Description: 500 characters'
PRINT @Description500
PRINT ''
PRINT 'Description: 100 characters'
PRINT @Description100
PRINT ''
PRINT 'Description: 20 characters'
PRINT @Description20

/*
	Declare a new variable @DecimalScale8 of type DECIMAL(18,8) and set it with the value @DecimalScale16.
	Declare a new variable @DecimalScale4 of type DECIMAL(18,4) and set it with the value @DecimalScale16
	Declare a new variable @DecimalScale2 of type DECIMAL(18,2) and set it with the value @DecimalScale16
*/
DECLARE @DecimalScale16 DECIMAL(18,16) = PI()
DECLARE @DecimalScale8 DECIMAL(18,8) = @DecimalScale16
DECLARE @DecimalScale4 DECIMAL(18,4) = @DecimalScale16
DECLARE @DecimalScale2 DECIMAL(18,2) = @DecimalScale16

PRINT @DecimalScale16
PRINT @DecimalScale8
PRINT @DecimalScale4
PRINT @DecimalScale2


