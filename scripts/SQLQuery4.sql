use datawarehouse;
SELECT * FROM silver.crm_prd_info;
SELECT prd_id, COUNT(*) FROM silver.crm_prd_info
GROUP BY  prd_id
HAVING COUNT(*)<1 OR prd_id IS NULL
--check for unwanted spaces
SELECT * FROM silver.crm_prd_info
WHERE TRIM(prd_nm)!=prd_nm;
--check cost 
SELECT * FROM silver.crm_prd_info
WHERE prd_cost<0 OR prd_cost IS NULL
-- distinct prd_line
SELECT DISTINCT prd_line FROM silver.crm_prd_info
--invalid dates
SELECT * FROM silver.crm_prd_info
where prd_start_dt>prd_end_dt;


-- sales_details
--order num check
SELECT * FROM bronze.crm_sales_details
WHERE TRIM(sls_ord_num)!=sls_ord_num;
SELECT sls_ord_num,COUNT(*) FROM bronze.crm_sales_details
GROUP BY sls_ord_num
HAVING COUNT(*)>1 OR sls_ord_num IS NULL;

-- PRODUCT KEY CHECK
SELECT * FROM bronze.crm_sales_details
WHERE sls_prd_key  NOT IN (SELECT prd_key from silver.crm_prd_info);

SELECT * FROM bronze.crm_sales_details
WHERE TRIM(sls_prd_key)!=sls_prd_key

-- check cutomer id

SELECT * FROM bronze.crm_sales_details
WHERE sls_cust_id NOT IN
(SELECT cst_id FROM silver.crm_cust_info)

--order
SELECT * FROM bronze.crm_sales_details

--checed if all the orders having same ord_num are duplicates
SELECT * FROM silver.crm_sales_details
WHERE sls_ord_num='SO55367';
SELECT * FROM silver.crm_sales_details
WHERE sls_quantity>1;

SELECT * FROM bronze.crm_sales_details
--checking the sls_sales, quantity,price
SELECT sls_sales,sls_quantity,sls_price 
FROM silver.crm_sales_details
WHERE sls_sales!= sls_quantity*sls_price
OR sls_sales <=0 OR sls_quantity<=0 OR sls_price=0
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL;


--check for dates 
select * from silver.crm_sales_details 
where sls_order_dt>sls_due_dt;