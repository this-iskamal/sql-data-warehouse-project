use DataWarehouse;

--check null and dublicate cst_id
SELECT cst_id, COUNT(*) 
FROM     silver.crm_cst_info
GROUP BY cst_id
HAVING (COUNT(*) > 1) or cst_id	is null;


select prd_id, count(*) 
from silver.crm_prd_info
group by prd_id
having count(*) > 1 or prd_id is null;

-- check unwanted spaces
select cst_firstname 
from silver.crm_cst_info
where cst_firstname !=  trim(cst_firstname);

select prd_nm
from silver.crm_prd_info
where prd_nm != TRIM(prd_nm);

--data standarization and consistency
select distinct cst_gndr
from silver.crm_cst_info;

select distinct cst_material_status
from silver.crm_cst_info;

select distinct prd_line
from bronze.crm_prd_info;

select distinct prd_line
from silver.crm_prd_info;


--check null or negative values

select prd_cost 
from silver.crm_prd_info	
where prd_cost < 0 or prd_cost is null;


--check invalid date orders
select * 
from bronze.crm_prd_info
where prd_end_dt < prd_start_dt;

select * 
from silver.crm_prd_info
where prd_end_dt < prd_start_dt;



--check invalid date in crm_sales_details
select 
nullif(sls_order_dt,0) as sls_order_dt
from bronze.crm_sales_details
where sls_order_dt <= 0 or LEN(sls_order_dt) != 8

select 
nullif(sls_ship_dt,0) as sls_ship_dt
from bronze.crm_sales_details
where sls_ship_dt <= 0 or LEN(sls_ship_dt) != 8

select 
nullif(sls_due_dt,0) as sls_due_dt
from bronze.crm_sales_details
where sls_due_dt <= 0 or LEN(sls_due_dt) != 8


--check invalid date order in crm_sales_details
select * 
from bronze.crm_sales_details
where sls_order_dt > sls_ship_dt or sls_order_dt > sls_due_dt


--check data consistency : between sales , quantity and price
-- sales = quantity * price
-- values must not be null , zero or negative

select distinct
sls_sales as old_sales,sls_quantity,sls_price as old_price,
case when sls_sales is null or sls_sales <= 0 or sls_sales != sls_quantity * abs(sls_price)
	then sls_quantity * abs(sls_price)
	else sls_sales
end as sls_sales,

case when sls_price is null or sls_price<=0
	 then sls_sales / nullif(sls_quantity,0)
	 else sls_price
end as sls_price
from bronze.crm_sales_details
where sls_sales != sls_quantity * sls_price
or sls_sales is null or sls_quantity is null or sls_price is null
or sls_sales <=0 or sls_quantity <=0 or sls_price <=0
order by sls_sales, sls_quantity, sls_price;



select distinct 
	case when upper(trim(gen)) in ('F','FEMALE') then 'Female'
		when upper(trim(gen)) in ('M','MALE') then 'Male'
		else 'n/a'
	end as gen
from bronze.erp_cst_az12


select distinct cntry
from bronze.erp_loc_a101



--check out of range birth dates

select  bdate
from bronze.erp_cst_az12
where bdate < '1924-01-01' or bdate > GETDATE()