USE [master]
GO
/****** Object:  Database AdventureWorks2024DW ******/
CREATE DATABASE [AdventureWorks2024DW]
 
GO
USE [AdventureWorks2024DW]
GO

/****** Object:  Table Reseller  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.Customer
(
  CustomerKey BIGINT PRIMARY KEY
, version INT
, date_from DATETIME
, date_to DATETIME
, CustomerID VARCHAR(100)
, Customer VARCHAR(152)
, City VARCHAR(30)
, StateProvince VARCHAR(50)
, CountryRegion VARCHAR(50)
, PostalCode VARCHAR(15)
)
;CREATE INDEX idx_Customer_lookup ON dbo.Customer(CustomerID)
;
CREATE INDEX idx_Customer_tk ON dbo.Customer(CustomerKey)
;
GO
/****** Object:  Table Reseller  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.Reseller
(
  ResellerKey BIGINT PRIMARY KEY
, version INT
, date_from DATETIME
, date_to DATETIME
, ResellerID VARCHAR(100)
, BusinessType VARCHAR(20)
, ResellerName VARCHAR(50)
, City VARCHAR(30)
, StateProvince VARCHAR(50)
, CountryRegion VARCHAR(50)
, PostalCode VARCHAR(15)
)
;CREATE INDEX idx_Reseller_lookup ON dbo.Reseller(ResellerID)
;
CREATE INDEX idx_Reseller_tk ON dbo.Reseller(ResellerKey)
;
GO
/****** Object:  Table Product   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Product
(
  ProductKey BIGINT PRIMARY KEY
, version INT
, date_from DATETIME
, date_to DATETIME
, SKU VARCHAR(25)
, Product VARCHAR(50)
, StandardCost DECIMAL(19,4)
, Color VARCHAR(15)
, ListPrice DECIMAL(19,4)
, ProductSubcategoryCode VARCHAR(50)
, ProductCategory VARCHAR(50)
, ProductModel VARCHAR(50)
)
;CREATE INDEX idx_Product_lookup ON dbo.Product(SKU)
;
CREATE INDEX idx_Product_tk ON dbo.Product(ProductKey)
;
GO
/****** Object:  Table Sales Order   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.SalesOrder
(
  SalesOrderLineKey BIGINT PRIMARY KEY
, version INT
, date_from DATETIME
, date_to DATETIME
, SalesOrderNumber VARCHAR(20)
, Channel VARCHAR(8)
, SalesOrderLine VARCHAR(25)
)
;CREATE INDEX idx_SalesOrder_lookup ON dbo.SalesOrder(SalesOrderNumber)
;
CREATE INDEX idx_SalesOrder_tk ON dbo.SalesOrder(SalesOrderLineKey)
;
GO
/****** Object:  Table Sales Territory   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.SalesTerritory
(
  SalesTerritoryAlternateKey BIGINT PRIMARY KEY
, version INT
, date_from DATETIME
, date_to DATETIME
, SalesTerritoryKey INT
, Region VARCHAR(50)
, Country VARCHAR(50)
, [Group] VARCHAR(50)
)
;CREATE INDEX idx_SalesTerritory_lookup ON dbo.SalesTerritory(SalesTerritoryKey)
;
CREATE INDEX idx_SalesTerritory_tk ON dbo.SalesTerritory(SalesTerritoryAlternateKey)
;
GO
/****** Object:  Table Sales   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE dbo.Sales
(
  SalesOrderLineAlternateKey BIGINT PRIMARY KEY
, version INT
, date_from DATETIME
, date_to DATETIME
, SalesOrderLineKey VARCHAR(23)
, ResellerKey INT
, CustomerKey INT
, ProductKey INT
, SalesTerritoryKey INT
, OrderQuantity INT
, UnitPrice DECIMAL(19,4)
, ExtendedAmount DECIMAL(19,4)
, UnitPriceDiscountPct FLOAT(53)
, ProductStandardCost DECIMAL(19,4)
, TotalProductCost DECIMAL(19,4)
, SalesAmount DECIMAL(19,4)
, OrderDateKey INT
, DueDateKey INT
, ShipDateKey INT
)
;CREATE INDEX idx_Sales_lookup ON dbo.Sales(SalesOrderLineKey)
;
CREATE INDEX idx_Sales_tk ON dbo.Sales(SalesOrderLineAlternateKey)
;
