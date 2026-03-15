/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
DECLARE @batch_start_time datetime, 
          @batch_end_time datetime,
            @start_time datetime, 
            @end_time datetime;
Begin try

SET @batch_start_time = GETDATE();
print 'loading broze lyer';
print '----------------------------------------';
print'loadding CRM table data';
print'-----------------------------------------';

set @start_time =getdate();
print 'Truncate table :bronze.crm_prd_info';
Truncate table bronze.crm_prd_info;
print 'insert data in :bronze.crm_prd_info';
Bulk insert bronze.crm_prd_info
from 'D:\Data Warehouse\data\warehouse\datasets\source_crm\prd_info.csv'
with (
FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
set @end_time=getdate();
print 'loading duration : ' + cast(datediff(second,@start_time,@end_time)as nvarchar) + 'seconds';
print'-----------------------------------------';

set @start_time =getdate();
print 'Truncate table :bronze.crm_sales_details';
Truncate table bronze.crm_sales_details;
print 'insert data in :bronze.crm_sales_details';
Bulk insert bronze.crm_sales_details
from 'D:\Data Warehouse\data\warehouse\datasets\source_crm\sales_details.csv'
with (
FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
set @end_time=getdate();
print 'loading duration : ' + cast(datediff(second,@start_time,@end_time)as nvarchar) + 'seconds';

print'-----------------------------------------';
set @start_time =getdate();
print 'Truncate table :bronze.crm_cust_info';
Truncate table bronze.crm_cust_info;
print 'insert data in :bronze.crm_cust_info';
Bulk insert bronze.crm_cust_info
from 'D:\Data Warehouse\data\warehouse\datasets\source_crm\cust_info.csv'
with (
FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n', 
    TABLOCK               
);
set @end_time=getdate();
print 'loading duration : ' + cast(datediff(second,@start_time,@end_time)as nvarchar) + 'seconds';
print'-------------------------------------------------------------------------------------------------------------------------';
print'loadding ERP table data';
print'-----------------------------------------';
set @start_time =getdate();
print 'Truncate table :bronze.erp_CUST_AZ12';
Truncate table bronze.erp_CUST_AZ12;
print 'insert data in :bronze.erp_CUST_AZ12';
Bulk insert bronze.erp_CUST_AZ12
from 'D:\Data Warehouse\data\warehouse\datasets\source_erp\CUST_AZ12.csv'
with (
FIRSTROW =2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
set @end_time=getdate();
print 'loading duration : ' + cast(datediff(second,@start_time,@end_time)as nvarchar) + 'seconds';


print'-----------------------------------------';
set @start_time =getdate();
print 'Truncate table :bronze.erp_LOC_A101';
Truncate table bronze.erp_LOC_A101;
print 'insert data in :bronze.erp_LOC_A101';
Bulk insert bronze.erp_LOC_A101
from 'D:\Data Warehouse\data\warehouse\datasets\source_erp\LOC_A101.csv'
with (
FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
set @end_time=getdate();
print 'loading duration : ' + cast(datediff(second,@start_time,@end_time)as nvarchar) + 'seconds';


print'-----------------------------------------';
set @start_time =getdate();
print 'Truncate table :bronze.erp_PX_CAT_G1V2';
Truncate table bronze.erp_PX_CAT_G1V2;
print 'insert data in :bronze.erp_PX_CAT_G1V2';
Bulk insert bronze.erp_PX_CAT_G1V2
from 'D:\Data Warehouse\data\warehouse\datasets\source_erp\PX_CAT_G1V2.csv'
with (
FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
set @end_time=getdate();
print 'loading duration : ' + cast(datediff(second,@start_time,@end_time)as nvarchar) + 'seconds';

print'-----------------------------------------';


end try 
begin catch 
print'-----------------------------------------';
print'Error in broze layer';
print 'error messsge' + error_message();
print 'error message' + cast(error_number()as nvarchar);
print 'error massege' + cast (error_state()as nvarchar);
print'-----------------------------------------';
THROW;
end catch 
set @batch_end_time =GETDATE();
print 'loading durationa all bronze layer ' + cast(datediff(ms,@batch_start_time, @batch_end_time) AS NVARCHAR) + 'millisecond';

END;


exec bronze.load_bronze  /*messsge to show all bonze layer hapend*/
