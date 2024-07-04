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

------------------
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


-----------------
