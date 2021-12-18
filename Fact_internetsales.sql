SELECT ProductKey,
	   OrderDateKey,
	   DueDateKey,
	   ShipDateKey,
	   CustomerKey,
	   SalesOrderNumber,
	   SalesAmount
FROM dbo.FactInternetSales
WHERE LEFT(OrderDateKey, 4) >= CONVERT(varchar, (YEAR(GETDATE()) -2))
ORDER BY OrderDateKey ASC