-- as SYSDBA: 
-- review security reasons to later REVOKE CREATE ANY DIRECTORY FROM WH;
GRANT CREATE ANY DIRECTORY TO wh;
GRANT EXECUTE ON sys.utl_file TO wh;
CREATE OR REPLACE DIRECTORY batch_folder AS 'c:\batch_job';
GRANT READ ON DIRECTORY batch_folder TO wh;

-- create table with parameters 
-- as WH:
CREATE TABLE document_management (
    "ID"            VARCHAR2(20 BYTE),
    "DOCUMENT"      VARCHAR2(20 BYTE),
    "FOLDER_NAME"   VARCHAR2(20 BYTE)
);

-- all documents (*.txt) will be moved to folder 'project01'
INSERT INTO document_management ( id, document, folder_name ) VALUES ( '1', '*.txt', 'project01' );

-- create a procedure that pulls data from the config table DOCUMENT_MANAGEMNT 
-- and puts commands into the batch file 'process.bat'
CREATE OR REPLACE PROCEDURE d_create_batch IS
    out_file   utl_file.file_type;
    v_file     VARCHAR2(200);
    v_folder   VARCHAR2(200);
    t_buff     VARCHAR2(200);
BEGIN
    out_file   := utl_file.fopen('BATCH_FOLDER', 'process.bat', 'W');

    SELECT
        document,
        folder_name
    INTO
        v_file, v_folder
    FROM document_management;

    t_buff     := 'move' ||' ' ||v_file ||' ' ||v_folder;
    utl_file.put_line(out_file, t_buff);
    utl_file.fclose(out_file);
END;
/

BEGIN
    d_create_batch ();
END;


-- create daily database job to get fresh data from DOCUMENT_MANAGEMENT table and fill batch file 
BEGIN
dbms_scheduler.create_job (
   job_name             => 'CREATE_BATCH',
   job_type             => 'PLSQL_BLOCK',
   job_action           => 'BEGIN D_CREATE_BATCH() END;',
   start_date           => SYSDATE,
   repeat_interval      => 'FREQ=DAILY', 
   enabled              =>  TRUE,
   comments             => 'making a batch file');
END;
/

BEGIN 
  DBMS_SCHEDULER.ENABLE('myjob');
END;

/*
	
René Nyffenegger's Utl file
http://www.adp-gmbh.ch/ora/plsql/utl_file.html

Oracle write to file
https://stackoverflow.com/questions/27562/oracle-write-to-file

How to write to a text file from Pl/SQL, PLS error 00363
https://stackoverflow.com/questions/23950850/how-to-write-to-a-text-file-from-pl-sql-pls-error-00363

Granting “Create Directory” Privileges in Oracle
https://stackoverflow.com/questions/1058756/granting-create-directory-privileges-in-oracle

*/