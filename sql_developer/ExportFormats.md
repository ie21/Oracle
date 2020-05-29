Needs to run as script 

SELECT /*json*/ * from scott.emp;
SELECT /*csv*/ * FROM scott.emp;  
SELECT /*xml*/ * FROM scott.emp;  
SELECT /*html*/ * FROM scott.emp;  
SELECT /*delimited*/ * FROM scott.emp;  
SELECT /*insert*/ * FROM scott.emp;  
SELECT /*loader*/ * FROM scott.emp;  
SELECT /*fixed*/ * FROM scott.emp;  
SELECT /*text*/ * FROM scott.emp;  


OR 

spool 'Path where you'd like to store the exported file\your_file_name.csv';
SELECT * FROM schema.table WHERE condition;
spool off;
