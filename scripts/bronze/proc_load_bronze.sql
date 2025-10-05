/*
Stored Procedure: Load Bronze Layer (Source -> Bronze)

Script purpose: This stored procedure loads data into the "bronze" schema from external CSV files.
It performs the following actions:
 - Truncated the bronze tables before loading data.
 - Uses the 'Bulk Insert' command to load data from CSV files to bronze tables.

Parameters: None. 
This stored procedure does not accept any parameters or return any values.

Usage example: EXEC bronze.load_bronze;
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
DECLARE @start_time DATETIME, @end_time DATETIME;

BEGIN TRY
PRINT '====================';
PRINT 'Loading Bronze Layer';
PRINT '====================';

PRINT '---------------------';
PRINT 'Loading CRM Tables';
PRINT '---------------------';

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.crm_cust_info';
TRUNCATE TABLE bronze.crm_cust_info;

PRINT '>> Inserting data into: bronze.crm_cust_info';
BULK INSERT bronze.crm_cust_info
FROM '/var/opt/mssql/data/cust_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
SET @end_time = GETDATE();
PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT '---------------';

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.crm_prd_info';
TRUNCATE TABLE bronze.crm_prd_info;

PRINT '>> Inserting data into: bronze.crm_prd_info';
BULK INSERT bronze.crm_prd_info
FROM '/var/opt/mssql/data/prd_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
SET @end_time = GETDATE();
PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT '-----------------';

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.crm_sales_details';
TRUNCATE TABLE bronze.crm_sales_details;

PRINT '>> Inserting data into: bronze.crm_sales_details';
BULK INSERT bronze.crm_sales_details
FROM '/var/opt/mssql/data/sales_details.csv'
WITH(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
SET @end_time = GETDATE();
PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT '--------------------';

PRINT '---------------------';
PRINT 'Loading ERP Tables';
PRINT '---------------------';

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.erp_cust_az12';
TRUNCATE TABLE bronze.erp_cust_az12;

PRINT '>> Inserting data into: bronze.erp_cust_az12';
BULK INSERT bronze.erp_cust_az12
FROM '/var/opt/mssql/data/CUST_AZ12.csv'
WITH(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
SET @end_time = GETDATE();
PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT '----------------------'

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.erp_loc_a101';
TRUNCATE TABLE bronze.erp_loc_a101;

PRINT '>> Inserting data into: bronze.erp_loc_a101';
BULK INSERT bronze.erp_loc_a101
FROM '/var/opt/mssql/data/LOC_A101.csv'
WITH(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
SET @end_time = GETDATE();
PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT '--------------------';

SET @start_time = GETDATE();
PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
TRUNCATE TABLE bronze.erp_px_cat_g1v2;

PRINT '>> Inserting data into: bronze.erp_px_cat_g1v2';
BULK INSERT bronze.erp_px_cat_g1v2
FROM '/var/opt/mssql/data/PX_CAT_G1V2.csv'
WITH(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
SET @end_time = GETDATE();
PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT '-------------------'

END TRY
BEGIN CATCH
PRINT '=========================';
PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
PRINT 'ERROR MESSAGE' + CAST (ERROR_NUMBER() AS NVARCHAR);
PRINT 'ERROR MESSAGE' + CAST (ERROR_STATE() AS NVARCHAR);
PRINT '========================='
END CATCH 
END
