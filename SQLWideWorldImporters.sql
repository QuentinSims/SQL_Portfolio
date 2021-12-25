--select all data from purchasing order
SELECT *
FROM Purchasing.PurchaseOrders 

--select date information
SELECT SupplierID, OrderDate, ExpectedDeliveryDate, DATEDIFF(day, OrderDate, ExpectedDeliveryDate) AS [Time Between Order & Delivery]
FROM Purchasing.PurchaseOrders
ORDER BY [Time Between Order & Delivery] ASC

--select data about purchasing from suppliers
SELECT DISTINCT(SupplierReference), COUNT(*) AS TotalPurchases
FROM Purchasing.PurchaseOrders
GROUP BY SupplierReference

--select all data from Supplier transaction 
SELECT *
FROM Purchasing.SupplierTransactions

--JOIN purchaseorder and supplier transaction
SELECT ST.SupplierTransactionID AS [Supplier Transaction ID],
		ST.SupplierID AS [Supplier ID],
		ST.TransactionAmount AS [Transaction Amount],
		PO.OrderDate AS [Order Date]
FROM Purchasing.SupplierTransactions AS ST
	FULL JOIN Purchasing.PurchaseOrders AS PO
	ON ST.PurchaseOrderID = PO.PurchaseOrderID
ORDER BY ST.SupplierID ASC

--select data regarding transaction amount
SElECT SupplierID, AmountExcludingTax, TaxAmount, TransactionAmount, OutstandingBalance
FROM Purchasing.SupplierTransactions
ORDER BY TransactionAmount DESC

--sum all amounts columns
SELECT SupplierID, SUM(AmountExcludingTax) AS [Amount Excluding Tax], SUM(TaxAmount) AS [Tax Amount],
		SUM(TransactionAmount) AS [Transaction Amount], SUM(OutstandingBalance) AS [Outstanding Balance]
FROM Purchasing.SupplierTransactions
GROUP BY SupplierID
ORDER BY SupplierID DESC

--select all data from customer transaction
SELECT *
FROM Sales.CustomerTransactions

--group supplier and customer information 
SELECT DISTINCT(CustomerID) AS [Customer ID],
	SUM(TransactionAmount) AS [Total Amount]
FROM Sales.CustomerTransactions
GROUP BY CustomerID
HAVING SUM(TransactionAmount) > 0

--select all data in warehouse
SELECT StockItemID, QuantityOnHand, LastStocktakeQuantity, LastCostPrice, ReorderLevel
FROM Warehouse.StockItemHoldings

--select difference between quantity on hand and last stock take quantity
SELECT StockItemId, QuantityOnHand AS [Quantity on Hand], LastStocktakeQuantity AS [Last stock take quantity], SUM(QuantityOnHand - LastStocktakeQuantity)
FROM Warehouse.StockItemHoldings

