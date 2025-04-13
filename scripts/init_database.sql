/*
==================================================
Create Database and Schemas
==================================================

Script Purpose : 
		This script creates a new database named "DataWarehouse" .
		Additionally, the scritp creates three schemas within the database : "bronze","silver" and "gold".

*/



use master;

-- create the "DataWarehouse" database
create database DataWarehouse;

go

use DataWarehouse;
go

--create schemas
create schema bronze;
go

create schema silver;
go

create schema  gold;
go


