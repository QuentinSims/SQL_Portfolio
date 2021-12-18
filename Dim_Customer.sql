SELECT C.CustomerKey AS CustomerKey,
	   C.FirstName AS FirstName,
	   C.LastName AS LastName,
	   C.FirstName + ' ' + LastName AS FullName,
CASE C.Gender 
	WHEN 'M'THEN 'Male'
	WHEN 'F'THEN 'Female'
	END AS Gender,
	C.DateFirstPurchase AS DateFirstPurchase,
	G.City AS CustomerCity
FROM dbo.DimCustomer AS C
	LEFT JOIN dbo.DimGeography AS G 
	ON G.GeographyKey = C.GeographyKey
ORDER BY CustomerAlternateKey ASC