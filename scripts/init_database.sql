/*

Create databse and schemas

Script purpose: This script creates a new database named 'DataWarehouse' after checking if it already exists. If the database already exists,
it is dropped and recreated. The script set ups three schemas within the database: bronze, silver, and gold. 

WARNING: Running this script will drop the 'WareHouse' database if it already exists. All the data in the database will be permanently
deleted. Proceed with caution and ensure you have proper backups before running this script.
*/

USE master;
GO
-- In order to not have an error saying that database already exists, drop and recriate the databse 'DataWarehouse'
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
  ALTER DATABASE WareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE WareHouse;
END
GO
  
-- Create a database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO
-- Create schemas
CREATE SCHEMA bronze;
GO
  
CREATE SCHEMA silver;
GO
  
CREATE SCHEMA gold;
