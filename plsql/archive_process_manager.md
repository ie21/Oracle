-- FIRST: create local folder c:\batch_job

-- as SYSDBA: 
-- review security reasons to later REVOKE CREATE ANY DIRECTORY FROM WH;

GRANT CREATE ANY DIRECTORY TO wh;
GRANT EXECUTE ON sys.utl_file TO wh;
CREATE OR REPLACE DIRECTORY batch_folder AS 'c:\batch_job';
GRANT READ ON DIRECTORY batch_folder TO wh;


-- create table containing parameters 
-- as WH:

CREATE TABLE DOCUMENT_MANAGEMENT (
    "ID"            VARCHAR2(20 BYTE) NOT NULL ENABLE,
    "DOCUMENT"      VARCHAR2(200 BYTE),
    "FOLDER_NAME"   VARCHAR2(200 BYTE),
    "CONFIG"        VARCHAR2(2000 BYTE),
    CONSTRAINT "PK_ID_DOCUMENT_MANAGEMENT" PRIMARY KEY ( "ID" )
        
);


-- inserting parameters
-- we insert into batch file a check if network share exists, if not we map it
-- all documents (*.txt) will be moved to folder 'project01'

Insert into DOCUMENT_MANAGEMENT (ID,DOCUMENT,FOLDER_NAME,CONFIG) values ('1','*.txt','project01','@echo off
if exist \\192.168.1.1\drive1 (set shareExists=1) else (set shareExists=0)
if exist y:\ (set driveExists=1) else (set driveExists=0)
if %shareExists%==1 if not %driveExists%==1 (net use y: \\192.168.1.1\drive1)
if %shareExists%==0 if %driveExists%==1 (net use /delete y:)
set driveExists=
set shareExists=
');


## Procedure 

-- create a procedure that pulls data from the config table DOCUMENT_MANAGEMNT 
-- and puts commands into the batch file 'process.bat'

CREATE OR REPLACE PROCEDURE p_create_batch IS
~~sql
    out_file   utl_file.file_type;
    v_file     VARCHAR2(200);
    v_folder   VARCHAR2(200);
    v_buff     VARCHAR2(2000);
    v_pre      VARCHAR2(1000);
BEGIN
    out_file   := utl_file.fopen('BATCH_FOLDER', 'process.bat', 'W');
    SELECT
        document,
        folder_name,
        config
    INTO
        v_file, v_folder, v_pre
    FROM document_management;

    v_buff     := v_pre ||'move' ||' ' ||v_file ||' ' ||v_folder;

    utl_file.put_line(out_file, v_buff);
    utl_file.fclose(out_file);
END;
/


BEGIN
    p_create_batch ();
END;


-- create daily database job to get fresh data from DOCUMENT_MANAGEMENT table and fill batch file 

BEGIN
dbms_scheduler.create_job (
   job_name             => 'CREATE_BATCH',
   job_type             => 'PLSQL_BLOCK',
   job_action           => 'BEGIN p_create_batch() END;',
   start_date           => SYSDATE,
   repeat_interval      => 'FREQ=DAILY', 
   enabled              =>  TRUE,
   comments             => 'making a batch file');
END;
/

-- Create Windows tash scheduller job to daily trigger the 'process.bat'


/*
	
René Nyffenegger's Utl file
http://www.adp-gmbh.ch/ora/plsql/utl_file.html

Oracle write to file
https://stackoverflow.com/questions/27562/oracle-write-to-file

How to write to a text file from Pl/SQL, PLS error 00363
https://stackoverflow.com/questions/23950850/how-to-write-to-a-text-file-from-pl-sql-pls-error-00363

Granting “Create Directory” Privileges in Oracle
https://stackoverflow.com/questions/1058756/granting-create-directory-privileges-in-oracle

Examples of Using the Scheduler
http://www.orafaq.com/wiki/DBMS_SCHEDULER
https://docs.oracle.com/cd/B28359_01/server.111/b28310/schedadmin006.htm#ADMIN12062

*/