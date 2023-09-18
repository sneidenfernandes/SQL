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




