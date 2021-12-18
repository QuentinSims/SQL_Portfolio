
--cleansed DIM_Datetable
SELECT DateKey, FullDateAlternateKey AS Date,
		EnglishDayNameOfWeek AS Day,
		EnglishMonthName AS Month,
		left(EnglishMonthName, 3) AS MonthShort,
		MonthNumberOfYear AS MonthNo,
		CalendarQuarter AS Quarter,
		CalendarYear AS Year
FROM dbo.DimDate
WHERE CalendarYear >= 2019