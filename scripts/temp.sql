use datawarehouse;
SELECT TOP 1000 * FROM bronze.crm_cust_info;
SELECT TOP 1000 * FROM bronze.crm_prd_info;
SELECT TOP 1000 * FROM bronze.crm_sales_details;

SELECT TOP 1000 * FROM bronze.erp_cust_az12;
SELECT TOP 1000 * FROM bronze.erp_loc_a101;
SELECT TOP 1000 * FROM bronze.erp_px_cat_g1v2;


SELECT cst_id,COUNT(*) FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)>1 OR cst_id IS NULL
select * from bronze.crm_cust_info

--check unwanted values for string 
SELECT cst_firstname FROM bronze.crm_cust_info
where cst_firstname !=TRIM(cst_firstname);
SELECT cst_lastname FROM bronze.crm_cust_info
where cst_lastname !=TRIM(cst_lastname);
SELECT  cst_marital_status FROM bronze.crm_cust_info
where cst_marital_status NOT IN ('S','M',NULL);
SELECT  cst_gndr FROM bronze.crm_cust_info 
where cst_gndr NOT IN ('M','F',NULL);