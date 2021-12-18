--cleaning Dim_Products
SELECT P.ProductKey, 
	   P.ProductAlternateKey AS [Product ItemCode],
	   P.EnglishProductName AS [Product Name],
	   PS.EnglishProductSubcategoryName AS [Sub Category],
	   PC.EnglishProductCategoryName AS [Product Category],
	   P.Color AS [Product Colour],
	   P.Size AS [Product Size],
	   P.ProductLine AS [Product Line],
	   P.ModelName AS [Product Model Name],
	   P.EnglishDescription AS [Product Description],
	   ISNULL (p.Status, 'Outdated') AS [Product Status]
FROM dbo.DimProduct AS P
	LEFT JOIN dbo.DimProductSubcategory AS PS 
		ON PS.ProductSubcategoryKey = P.ProductSubcategoryKey
	LEFT JOIN dbo.DimProductCategory AS PC
		ON PS.ProductCategoryKey = PC.ProductCategoryKey
ORDER BY P.ProductKey ASC