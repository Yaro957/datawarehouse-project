IF EXISTS(SELECT 1 FROM sys.databases WHERE NAME='DATAWAREHOUSE')
BEGIN
	ALTER DATABASE DATAWAREHOUSE SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DATAWAREHOUSE;
END;
GO
-- CREATE  DATAWAREHOUSE DATABASE
CREATE DATABASE datawarehouse;
GO 
USE datawarehouse;
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO

/* ============================================================================
   Create Bronze Tables
   ============================================================================ */

-- CRM Customer Info
IF OBJECT_ID('bronze.crm_cust_info','U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info (
    cst_id             INT,
    cst_key            NVARCHAR(50),
    cst_firstname      NVARCHAR(50),
    sct_lastname       NVARCHAR(50),
    cst_material_status NVARCHAR(10),
    cst_gndr           NVARCHAR(50),
    cst_create_date    DATE
);
GO

-- CRM Product Info
IF OBJECT_ID('bronze.crm_prd_info','U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id     INT,
    prd_key    NVARCHAR(50),
    prd_nm     NVARCHAR(50),
    prd_cost   INT,
    prd_line   NVARCHAR(10),
    prd_start  DATETIME,
    prd_end    DATETIME
);
GO

-- CRM Sales Details
IF OBJECT_ID('bronze.crm_sales_details','U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num   NVARCHAR(10),
    sls_prd_key   NVARCHAR(20),
    sls_cust_id   INT,
    sls_order_dt  INT,
    sls_ship_dt   INT,
    sls_due_dt    INT,
    sls_sales     INT,
    sls_quantity  INT,
    sls_price     INT
);
GO

-- ERP Customer (AZ12)
IF OBJECT_ID('bronze.erm_cust_az12','U') IS NOT NULL
    DROP TABLE bronze.erm_cust_az12;
GO

CREATE TABLE bronze.erm_cust_az12 (
    cid   NVARCHAR(40),
    bdate DATE,
    gen   NVARCHAR(50)
);
GO

-- ERP Location (A101)
IF OBJECT_ID('bronze.erm_loc_a101','U') IS NOT NULL
    DROP TABLE bronze.erm_loc_a101;
GO

CREATE TABLE bronze.erm_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(100)
);
GO

-- ERP Product Category (G1V2)
IF OBJECT_ID('bronze.erm_px_cat_g1v2','U') IS NOT NULL
    DROP TABLE bronze.erm_px_cat_g1v2;
GO

CREATE TABLE bronze.erm_px_cat_g1v2 (
    id          NVARCHAR(50),
    cat         NVARCHAR(40),
    subcat      NVARCHAR(50),
    maintenance NVARCHAR(50)
);
GO

