--BRONZE LAYER
 --before instering & quality check--
select cst_id from bronze.crm_cust_info 
where cst_id is null;

select cst_id ,
count(*)  from bronze.crm_cust_info
group by cst_id
Having count(*)>1 and cst_id is  null;

select cst_firstname from bronze.crm_cust_info
where cst_firstname!=trim(cst_firstname);

select cst_lastname from bronze.crm_cust_info
where cst_lastname!=trim(cst_lastname);

select cst_gndr from bronze.crm_cust_info
where cst_gndr!=trim(cst_gndr);

select distinct cst_marital_status
from bronze.crm_cust_info;



--SILVER LAYER
--after instering & quality check
select cst_id from silver.crm_cust_info 
where cst_id is null;

select cst_id ,
count(*)  from silver.crm_cust_info
group by cst_id
Having count(*)>1 and cst_id is  null;

select cst_firstname from silver.crm_cust_info
where cst_firstname!=trim(cst_firstname);

select cst_lastname from silver.crm_cust_info
where cst_lastname!=trim(cst_lastname);

select cst_gndr from silver.crm_cust_info
where cst_gndr!=trim(cst_gndr);

select distinct cst_marital_status
from silver.crm_cust_info;

--Gold Layer
-- Checking 'gold.dim_customers'
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- Checking 'gold.dim_products'
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

--Checking gold.fact_sales
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL

select distinct cst_gndr
from silver.crm_cust_info;

select distinct cst_gndr
from bronze.crm_cust_info;
