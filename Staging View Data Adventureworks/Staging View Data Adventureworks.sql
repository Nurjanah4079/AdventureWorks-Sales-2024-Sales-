USE [AdventureWorksDW2022]
GO

------------------------------------------------
/****** Object:  View [dbo].[Stg_vw_Erp_Customer]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE VIEW [dbo].[Stg_View_Customer]
  AS

	SELECT 
		c.[CustomerKey],
		CONCAT(c.[FirstName], ' ', COALESCE(c.[MiddleName] + ' ', ''), c.[LastName]) AS Customer,
		g.[City],
		g.[StateProvinceName] AS StateProvince,
		g.[EnglishCountryRegionName] AS CountryRegion,
		g.[PostalCode] AS PostalCode
	FROM 
		[dbo].[DimCustomer] c
	LEFT OUTER JOIN 
		[dbo].[DimGeography] g ON c.[GeographyKey] = g.[GeographyKey]

GO


/****** Object:  View [dbo].[Stg_View_Reseller]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE VIEW [dbo].[Stg_View_Reseller]
  AS

	SELECT 
        r.[ResellerKey],
        r.[BusinessType],
		r.[ResellerName],
        g.[City],
        g.[StateProvinceName] AS StateProvince,
        g.[EnglishCountryRegionName] AS CountryRegion,
        g.[PostalCode] AS PostalCode
    FROM 
        [dbo].[DimReseller] r
    LEFT OUTER JOIN 
        [dbo].[DimGeography] g ON r.[GeographyKey] = g.[GeographyKey]

GO


/****** Object:  View [dbo].[Stg_View_Product]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE VIEW [dbo].[Stg_View_Product]
  AS

	SELECT 
		p.[ProductKey],
		p.[ProductAlternateKey] AS SKU,
		p.[EnglishProductName] AS Product,
		p.[StandardCost],
		p.[Color],
		p.[ListPrice],
		s.[EnglishProductSubcategoryName] AS [ProductSubcategoryCode],
		c.[EnglishProductCategoryName] AS [ProductCategory],
		p.ModelName AS [ProductModel]
	FROM 
		[dbo].[DimProduct] p
	INNER JOIN 
		[dbo].[DimProductSubcategory] s ON p.[ProductSubcategoryKey] = s.[ProductSubcategoryKey]
	INNER JOIN 
		[dbo].[DimProductCategory] c ON s.[ProductCategoryKey] = c.[ProductCategoryKey]

GO


/****** Object:  View [dbo].[Stg_View_SalesTerritory]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE VIEW [dbo].[Stg_View_SalesTerritory]
  AS

	SELECT
		t.[SalesTerritoryKey],
		t.[SalesTerritoryRegion] AS Region,
		t.[SalesTerritoryCountry] AS Country,
		t.[SalesTerritoryGroup] AS [Group]
	FROM 
		[dbo].[DimSalesTerritory] t

GO


/****** Object:  View [dbo].[Stg_View_SalesOrder]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE VIEW [dbo].[Stg_View_SalesOrder]
  AS

	SELECT 
		'Internet' AS Channel,
		CONCAT(
			RIGHT(fs.[SalesOrderNumber], LEN(fs.[SalesOrderNumber]) - 2),
			RIGHT('000' + CAST(ROW_NUMBER() OVER(PARTITION BY fs.[SalesOrderNumber] ORDER BY fs.[SalesOrderLineNumber]) AS VARCHAR(3)), 3)
		) AS SalesOrderLineKey,
		fs.[SalesOrderNumber],
		CONCAT(fs.[SalesOrderNumber], '-', fs.[SalesOrderLineNumber]) AS SalesOrderLine
	FROM 
		[dbo].[FactInternetSales] fs
	UNION ALL
	SELECT 
		'Reseller' AS Channel,
		CONCAT(
			RIGHT(fr.[SalesOrderNumber], LEN(fr.[SalesOrderNumber]) - 2),
			RIGHT('000' + CAST(ROW_NUMBER() OVER(PARTITION BY fr.[SalesOrderNumber] ORDER BY fr.[SalesOrderLineNumber]) AS VARCHAR(3)), 3)
		) AS SalesOrderLineKey,
		fr.[SalesOrderNumber],
		CONCAT(fr.[SalesOrderNumber], '-', fr.[SalesOrderLineNumber]) AS SalesOrderLine
	FROM 
		[dbo].[FactResellerSales] fr

GO


/****** Object:  View [dbo].[Stg_View_SalesHelper]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE VIEW [dbo].[Stg_View_SalesHelper]
  AS

	SELECT 
		CONCAT(
			RIGHT(fs.[SalesOrderNumber], LEN(fs.[SalesOrderNumber]) - 2),
			RIGHT('000' + CAST(ROW_NUMBER() OVER(PARTITION BY fs.[SalesOrderNumber] ORDER BY fs.[SalesOrderLineNumber]) AS VARCHAR(3)), 3)
		) AS SalesOrderLineKey,
		-1 AS ResellerKey,
		fs.[CustomerKey],
		fs.[ProductKey],
		fs.[SalesTerritoryKey],
		fs.[OrderQuantity],
		fs.[UnitPrice],
		fs.[ExtendedAmount],
		fs.[UnitPriceDiscountPct],
		fs.[ProductStandardCost],
		fs.[TotalProductCost],
		fs.[SalesAmount]
	FROM 
		[dbo].[FactInternetSales] fs
	UNION ALL
	SELECT 
		CONCAT(
			RIGHT(fr.[SalesOrderNumber], LEN(fr.[SalesOrderNumber]) - 2),
			RIGHT('000' + CAST(ROW_NUMBER() OVER(PARTITION BY fr.[SalesOrderNumber] ORDER BY fr.[SalesOrderLineNumber]) AS VARCHAR(3)), 3)
		) AS SalesOrderLineKey,
		fr.[ResellerKey],
		-1 AS CustomerKey,
		fr.[ProductKey],
		fr.[SalesTerritoryKey],
		fr.[OrderQuantity],
		fr.[UnitPrice],
		fr.[ExtendedAmount],
		fr.[UnitPriceDiscountPct],
		fr.[ProductStandardCost],
		fr.[TotalProductCost],
		fr.[SalesAmount]
	FROM 
		[dbo].[FactResellerSales] fr

GO


/****** Object:  View [dbo].[Stg_View_Sales]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE VIEW [dbo].[Stg_View_Sales]
  AS

	SELECT 
		sh.*,
		df.[OrderDateKey],
		df.[DueDateKey],
		df.[ShipDateKey]
	FROM 
		[dbo].[Stg_View_SalesHelper] sh
	JOIN
		[dbo].[DateReferences] df ON sh.[SalesOrderLineKey] = df.[SalesOrderLineKey]

GO

