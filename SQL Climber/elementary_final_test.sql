/*
    Select all orders for the declared customer:
    - Customer 
    - OrderDate
    - ProductTypes - count of product type 
    - TotalProducts - the quantity of all products
    - TotalPrice - the total price of all products
	The newest orders show up first.
*/
DECLARE @CustomerId INT = 1

SELECT 
	C.Customer,
    O.OrderDate,
    ProductTypes = COUNT(DISTINCT(P.CategoryId)),
    TotalProducts = SUM(OL.Quantity),
    TotalPrice = SUM(OL.UnitPrice * OL.Quantity)
    
FROM 
	Eshop.Customer C 
INNER JOIN 
    Eshop.[Order] AS O ON (C.Id=O.CustomerId)
LEFT JOIN 
	Eshop.OrderLine AS OL ON (O.ID=OL.OrderId)
LEFT JOIN 
	Eshop.Product AS P ON (OL.ProductID=P.Id)
LEFT JOIN 
	Eshop.Category AS Cat ON (P.CategoryId=Cat.Id)
WHERE 
	C.Id = @CustomerId
GROUP BY
	C.Customer,O.OrderDate
ORDER BY
	O.OrderDate;


/*
    Select detail of the last customer order:
    - Product - Format: '{product title} ({brand})'
	- Quantity 
	- UnitPrice
    - TotalPrice
    - Currency
*/
DECLARE @CustomerId INT = 11
SELECT TOP 1
    CONCAT(P.Title, ' (', P.Brand, ')') AS Product,
    OL.Quantity,
    P.UnitPrice,
    OL.Quantity * P.UnitPrice AS TotalPrice,
    P.Currency
FROM
    [Eshop].[Customer] AS C
INNER JOIN
    [Eshop].[Order] AS O ON C.Id = O.CustomerId
INNER JOIN
    [Eshop].[OrderLine] AS OL ON O.Id = OL.OrderId
INNER JOIN
    [Eshop].[Product] AS P ON OL.ProductId = P.Id
WHERE
    C.Id = @CustomerId
ORDER BY
    O.OrderDate DESC;


/*
    Filter products by user filter: @Brand, @PriceFrom, @PriceTo
    If some of the filters are not set, don't apply them.
    
    Select the following columns:
    - Category - Format: {parent category} / {category}
    - Brand
    - Product
    - Price
    - Currency
    The most expensive products show up first.
*/
DECLARE @Brand NVARCHAR(100) = 'Apple'
DECLARE @PriceFrom DECIMAL
DECLARE @PriceTo DECIMAL = 1500

SELECT 
	Category = cat2.Title + ' / ' + Cat1.Title,
    P.Brand,
    Product = P.Title,
    Price = P.UnitPrice,
    P.Currency
FROM
	Eshop.Product P 
JOIN 
	Eshop.Category Cat1 ON (P.CategoryId=Cat1.Id)
JOIN 
	Eshop.Category Cat2 ON (Cat1.ParentCategoryId=Cat2.Id)
WHERE
	(@Brand IS NULL OR P.Brand = @Brand)
AND
	(@PriceFrom IS NULL OR P.UnitPrice >= @PriceFrom)
AND
	(@PriceTo IS NULL OR P.UnitPrice <= @PriceTo)
ORDER BY 
	P.UnitPrice DESC;


/*
    Select products by user filter.
    Select the following columns:
    - Category - Format: {parent category} / {category}
    - Brand
    - Product
    - Price
    - Currency
    The most expensive products show up first.
*/

DECLARE @UserFilterCategory TABLE (Title NVARCHAR(100))
INSERT INTO @UserFilterCategory(Title) 
VALUES ('Headphones'), ('Men''s Accessories')
SELECT
	Category = Cat2.Title + ' / ' + Cat1.Title,
    P.Brand,
    Product = P.Title,
    Price = P.UnitPrice,
    P.Currency
FROM 
	Eshop.Product P
JOIN 
	Eshop.Category Cat1 ON (P.CategoryId=Cat1.Id)
JOIN
	Eshop.Category Cat2 ON (Cat1.ParentCategoryId=Cat2.Id)
WHERE
	Cat2.Title IN (SELECT * FROM @UserFilterCategory)
    OR
    Cat1.Title IN (SELECT * FROM @UserFilterCategory)
ORDER BY
	P.UnitPrice DESC;

/*
	E-shop wants to prepare new products.
	Insert new products of the declared category into the table @IncomingProduct.

	New product					Brand	UnitPrice	Currency
	Dell XPS 15 (9570) Touch	Dell	3190		USD
	Dell Precision 7730			Dell	2390		USD
*/

DECLARE @IncomingProduct TABLE
(
    Title NVARCHAR(100)
   ,Description NVARCHAR(1000)
   ,Brand NVARCHAR(100)
   ,CategoryId INT
   ,UnitPrice DECIMAL(18,2)
   ,Currency NVARCHAR(3)
)
DECLARE @Category NVARCHAR(100) = 'Laptops'
DECLARE @CatID INT  SELECT @CatID = cat.Id FROM Eshop.Category cat WHERE cat.Title=@Category;

INSERT INTO @IncomingProduct(Title, Brand, CategoryId, Unitprice, Currency)
SELECT
	'Dell XPS 15 (9570) Touch',
    'Dell',
    cat.Id,
    3190,
    'USD'
FROM Eshop.Category cat
WHERE
	cat.Title = @Category;
    
INSERT INTO @IncomingProduct(Title, Brand, CategoryId, Unitprice, Currency)
SELECT
	'Dell Precision 7730',
    'Dell',
    cat.Id,
    2390,
    'USD'
FROM Eshop.Category cat
WHERE
	cat.Title = @Category;

SELECT * FROM @IncomingProduct


/*
    E-shop wants to prepare new products:
	- There is a script which insert data into the table @IncomingProduct.
	- Declare a suitable table @IncomingProduct.
*/

INSERT INTO @IncomingProduct (CategoryId, Title, Brand, UnitPrice)
VALUES 
(3, 'Dell XPS 15 (9570) Touch', 'Dell', 3199.5),
(3, 'Dell Precision 7730', 'Dell', 2399.95),
(3, 'HP EliteBook 1050 G1', 'HP', 1999),
(3, 'HP EliteBook 1040 G5', 'HP', 1899),
(3, 'Lenovo ThinkPad P72', 'Lenovo', 4500)

SELECT * FROM @IncomingProduct


/*
    E-shop wants to prepare new products:
	- There is a script which insert data into the table @IncomingProduct.
	- Declare a suitable table @IncomingProduct.
*/

DECLARE @IncomingProduct TABLE
(
    Id INT IDENTITY(100,3) PRIMARY KEY,
    Title NVARCHAR(100),
    Brand NVARCHAR(100),
    CategoryId INT,
    UnitPrice DECIMAL(18,1),
    Currency NVARCHAR(3) DEFAULT 'USD'
    
)
INSERT INTO @IncomingProduct (CategoryId, Title, Brand, UnitPrice)
VALUES 
(3, 'Dell XPS 15 (9570) Touch', 'Dell', 3199.5),
(3, 'Dell Precision 7730', 'Dell', 2399.95),
(3, 'HP EliteBook 1050 G1', 'HP', 1999),
(3, 'HP EliteBook 1040 G5', 'HP', 1899),
(3, 'Lenovo ThinkPad P72', 'Lenovo', 4500)

SELECT * FROM @IncomingProduct



