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

/*
	E-shop wants to expand to new markets:
	- Insert products of the declared category into the table @ExpandingProduct with new currency and recalculated price.
    - All new prices should contain 95 cents/penny, so fix it after recalculation.
*/
DECLARE @ExpandingProduct TABLE
(
	Title NVARCHAR(100)
   ,Description NVARCHAR(1000)
   ,Brand NVARCHAR(100)
   ,CategoryId INT
   ,UnitPrice DECIMAL(18,2)
   ,Currency NVARCHAR(3)
)

DECLARE @Category NVARCHAR(100) = 'Headphones'
DECLARE @NewCurrency TABLE (Currency NVARCHAR(3), ExchangeRate DECIMAL(18, 2))
INSERT INTO @NewCurrency (Currency, ExchangeRate) VALUES ('EUR', 0.89), ('GBP', 0.80)

-- Insert products into @ExpandingProduct with new currency and recalculated price
INSERT INTO @ExpandingProduct( Title, Description, Brand, CategoryId, UnitPrice,Currency)

SELECT
	P.Title,
    P.Description,
    P.Brand,
    P.CategoryId,
    UnitPrice = CAST((P.UnitPrice * NC.ExchangeRate) AS INT) + 0.95,
    NC.Currency
FROM 
    Eshop.Product P
CROSS JOIN 
	@NewCurrency NC
WHERE P.CategoryId = (SELECT Ca.Id FROM Eshop.Category Ca WHERE Ca.Title=@Category)
ORDER BY 
	UnitPrice;


/*
    E-shop wants to change prices:
    - Calculate new unit prices at table @PreparePrice for the declared category.
    - All new prices higher than 100 dollars should be without cents. Round them up. 
*/
DECLARE @PreparePrice TABLE
(
	ProductId INT
   ,Title NVARCHAR(100)
   ,UnitPrice DECIMAL(18,2)
   ,NewUnitPrice DECIMAL(18,2)
)
INSERT INTO @PreparePrice (ProductId, Title, UnitPrice)
SELECT 
	p.Id
   ,p.Title
   ,p.UnitPrice
FROM Eshop.Product p

DECLARE @ParentCategory NVARCHAR(100) = 'Men''s Accessories'
DECLARE @PriceIncreaseInPercentage INT = 5

SELECT 
	P.Id,
    P.Title,
    P.UnitPrice,
	NewUnitPrice = CASE
    					WHEN UnitPrice * (1 + @PriceIncreaseInPercentage / 100.0) > 100 
       				    THEN CEILING(UnitPrice * (1 + @PriceIncreaseInPercentage / 100.0))
                        WHEN UnitPrice <= 100 
                        THEN  UnitPrice * (1 + @PriceIncreaseInPercentage / 100.00) 
    			   END
FROM Eshop.Product P
JOIN Eshop.Category C ON (P.CategoryId=C.Id)
WHERE C.ParentCategoryId = (SELECT cat.Id From Eshop.Category cat WHERE cat.Title=@ParentCategory);

SELECT * FROM @PreparePrice pp WHERE pp.NewUnitPrice IS NOT NULL


/*
    E-shop wants to change prices:
    - Calculate new unit prices at table @PreparePrice for the declared @PriceChange.
    - Calculate the difference between the new price and the old price.
    - If the new price does not contain 95 cents then round the price. 
*/
DECLARE @PreparePrice TABLE
(
	ProductId INT
   ,Title NVARCHAR(100)
   ,UnitPrice DECIMAL(18,2)
   ,NewUnitPrice DECIMAL(18,2)
   ,PriceDifference DECIMAL(18,2)
)
INSERT INTO @PreparePrice (ProductId, Title, UnitPrice)
SELECT 
	p.Id
   ,p.Title
   ,p.UnitPrice
FROM Eshop.Product p

DECLARE @PriceChange TABLE (Category NVARCHAR(100), PriceChangeInPercentage INT)
INSERT INTO @PriceChange (Category, PriceChangeInPercentage)
VALUES ('Sunglasses', 5), ('Headphones', -5)

UPDATE @PreparePrice
SET NewUnitPrice = 
    CASE 
        WHEN PP.UnitPrice * (1 + PC.PriceChangeInPercentage / 100.0) * 100 % 95 = 0
        THEN PP.UnitPrice * (1 + PC.PriceChangeInPercentage / 100.0)
        ELSE ROUND(PP.UnitPrice * (1 + PC.PriceChangeInPercentage / 100.0) * 100 / 95, 2) * 95 / 100
    END,
    PriceDifference = PP.UnitPrice * (1 + PC.PriceChangeInPercentage / 100.0) - PP.UnitPrice
FROM @PreparePrice PP
INNER JOIN @PriceChange PC ON PP.Title = PC.Category;

SELECT * FROM @PreparePrice pp WHERE pp.NewUnitPrice IS NOT NULL ORDER BY pp.PriceDifference DESC


/*
    Select top N customers:
	- Customer - customer name
	- Email - customer email
	- TotalProducts - number of products which customer have bought 
    - TotalPrice - total price of all bought products
	Use descending order by TotalPrice.
*/
DECLARE @NumberOfTopCustomers INT = 10
SELECT 
	TOP(@NumberOfTopCustomers)
    C.Customer,
    C.Email,
    TotalProducts=SUM(OL.Quantity),
    TotalPrice = SUM(OL.UnitPrice*OL.Quantity)
FROM 
	Eshop.Customer C
JOIN
	Eshop.[Order] O ON (C.Id=O.CustomerId)
JOIN
	Eshop.OrderLine OL ON (O.Id=Ol.OrderId)
GROUP BY 
	C.Customer,C.Email
ORDER BY
	TotalPrice DESC;
	

/*
    Select orders which total price is more then @MinimalTotalPrice:
	- OrderDate - order date
	- TotalProducts - the quantity of all products
	- TotalPrice - the total price of all products
    - Customer
	Use descending order by TotalPrice and then by customer.
*/
DECLARE @MinimalTotalPrice DECIMAL(18,2) = 1000

SELECT
	CAST(O.OrderDate AS DATE) AS OrderDate,
    SUM(OL.Quantity) AS TotalProducts,
    SUM(OL.Quantity*OL.UnitPrice) AS TotalPrice,
    C.Customer
FROM
	Eshop.Customer C
JOIN
	Eshop.[Order] O ON (C.Id=O.CustomerId)
JOIN
	Eshop.OrderLine OL ON (O.Id=OL.OrderId)
GROUP BY 
	C.Customer,O.OrderDate
HAVING SUM(OL.Quantity*OL.UnitPrice) > @MinimalTotalPrice
ORDER BY
	TotalPrice DESC, C.Customer;


