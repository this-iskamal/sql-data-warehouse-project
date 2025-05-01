
use DataWarehouse;

select * from silver.crm_prd_info;


insert into silver.crm_prd_info(
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)
SELECT  prd_id
      ,
	  REPLACE( SUBSTRING(prd_key,1,5),'-','_')as cat_id,
	  SUBSTRING(prd_key,7,len(prd_key))as prd_key
      ,prd_nm
      ,isnull(prd_cost,0) as prd_cost
      ,
	  case when upper(trim(prd_line))='M' then 'Mountain'
		   when upper(trim(prd_line))='R' then 'Road'
		   when upper(trim(prd_line))='S' then 'Other Sales'
		   when upper(trim(prd_line))='T' then 'Touring'
		   else 'n/a'
		end as prd_line

      ,cast(prd_start_dt as date) as prd_start_dt
      ,cast(lead(prd_start_dt) over(partition by prd_key order by prd_start_dt)-1 as date) as prd_end_dt
  FROM bronze.crm_prd_info;
 
