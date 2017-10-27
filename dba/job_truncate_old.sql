/*
Job to truncate old files on the last day of each month. 
*/

BEGIN
dbms_scheduler.create_job (
   job_name             => 'TRUNCATE_OLD',
   job_type             => 'PLSQL_BLOCK',
   job_action           => 'begin execute immediate ''truncate table SCHEME.DOCUMENT_PHOTOS''; end; ',
   start_date           => SYSDATE,
   repeat_interval      => 'FREQ=MONTHLY;BYMONTHDAY=-1;', 
   enabled              =>  TRUE,
   comments             => 'Cleanup of temp files');
END;
 