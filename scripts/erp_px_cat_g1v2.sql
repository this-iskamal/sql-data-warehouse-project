use DataWarehouse

insert into silver.erp_px_cat_g1v2 (
	id,
	cat,
	subcat,
	maintenance
	)
select id,
	cat,
	subcat,
	maintenance
from bronze.erp_px_cat_g1v2;


--check unwanted spaces
select * 
from bronze.erp_px_cat_g1v2
where cat != TRIM(cat) or subcat != TRIM(subcat) or maintenance != TRIM(maintenance)

-- check data standarization
select distinct maintenance
from bronze.erp_px_cat_g1v2



