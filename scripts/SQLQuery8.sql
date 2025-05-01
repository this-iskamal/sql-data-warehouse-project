use DataWarehouse;

select prd_id ,
count(*) from
bronze.crm_prd_info
group by prd_id
having count(*)>1 or prd_id is null;