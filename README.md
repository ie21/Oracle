# ProbableOracle
Useful Oracle database commands, scripts, tips hacks




## Introduction
This document is being produced for repetition material for Oracle SQL Fundamentals and SQL Expert Exams.

Also, I work with the database every day and I figured this would be useful to more people.

## Version information
This document is entirely writen in Markdown using MacDown on OX S and Aton on Windows using markdown preview and markdown-pdf plugins.

Tested on Oracle 11XE.  
Tools: Oracle SQL Developer , SQL Plus

Download Oracle 11XE  
Download Oracle SQL Developer

## Contributing

Feel free to join in and contribute interesting Oracle related information.

Looking for contributors.

## Asking Questions

Get to know your surroundings, ask questions and get feedback to understand what is going on.  


### Exploring The Database
-------------------------------------------




#### Is the database open?

```sql
SELECT instance_name,
  instance_role,
  version,
  startup_time,
  status
FROM v$instance;
```

```
INSTANCE_NAME    INSTANCE_ROLE      VERSION           STARTUP_TIME STATUS     
---------------- ------------------ ----------------- ------------ ------------
xe               PRIMARY_INSTANCE   11.2.0.2.0        02-JUL-16    OPEN        
```




#### What is the database name?

```sql
SELECT value
  FROM v$system_parameter
 WHERE name = 'db_name';
```

#### What is the database version?

```sql
SELECT *
  FROM v$version;
```
```
BANNER                                                                         
--------------------------------------------------------------------------------
Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production       
PL/SQL Release 11.2.0.2.0 - Production                                          
CORE	11.2.0.2.0	Production                                                        
TNS for 64-bit Windows: Version 11.2.0.2.0 - Production                         
NLSRTL Version 11.2.0.2.0 - Production            
```

#### What are this Oracle database general parameters?
```sql
SELECT *
  FROM v$system_parameter;
```
```
NAME                                     VALUE           DESCRIPTION                            
---------------------------------------- --------------- ----------------------------------------
lock_name_space                                          lock name space used for generating lock
processes                                100             user processes                          
sessions                                 172             user and system sessions                
timed_statistics                         TRUE            maintain internal timing statistics     
timed_os_statistics                      0               internal os statistic gathering interval
resource_limit                           FALSE           master switch for resource limit        
license_max_sessions                     0               maximum number of non-system user sessio
license_sessions_warning                 0               warning level for number of non-system u

(cut)
```

todo: table - Some brief explanation of database general parameters:



#### What is the Database Character Set Informations:
```sql
SELECT *
  FROM nls_database_parameters;
```
```
NLS_LANGUAGE                   AMERICAN       
NLS_TERRITORY                  AMERICA        
NLS_CURRENCY                   $              
NLS_ISO_CURRENCY               AMERICA        
NLS_NUMERIC_CHARACTERS         .,             
NLS_CHARACTERSET               AL32UTF8       
NLS_CALENDAR                   GREGORIAN      
NLS_DATE_FORMAT                DD-MON-RR      
NLS_DATE_LANGUAGE              AMERICAN       
NLS_SORT                       BINARY         
NLS_TIME_FORMAT                HH.MI.SSXFF AM
NLS_TIMESTAMP_FORMAT           DD-MON-RR HH.MI
NLS_TIME_TZ_FORMAT             HH.MI.SSXFF AM
NLS_TIMESTAMP_TZ_FORMAT        DD-MON-RR HH.MI
NLS_DUAL_CURRENCY              $              
NLS_COMP                       BINARY         
NLS_LENGTH_SEMANTICS           BYTE           
NLS_NCHAR_CONV_EXCP            FALSE          
NLS_NCHAR_CHARACTERSET         AL16UTF16      
NLS_RDBMS_VERSION              11.2.0.2.0     
```


#### What is the database size?
```sql
SELECT SUM(BYTES)/1024/1024 MB
  FROM dba_extents;
```

#### What is the size of the database data file?
```sql
SELECT SUM(bytes)/1024/1024 MB
  FROM dba_data_files;
```



#### What is the current database state?
```sql
SELECT *
  FROM v$instance;
```

#### What tablespaces are available?
```sql
SELECT *
  FROM v$tablespaces;
```

Example output:





### Exploring the user space and schemas
---------------------------------------------

#### What tables are owned by user?
```sql
SELECT table_owner, table_name
  FROM sys.all_synonyms
 WHERE table_owner LIKE 'xxx';
```

#### What are tables of current user?
```sql
SELECT *
  FROM user_tables;
```

#### How to find out all objects connected to current user?
```sql
SELECT *
  FROM user_catalog;
```


#### Does a table exist in current DB schema?

If you quickly need to determine if a table exists in your current DB schema. Consider this you *search*.

```sql
SELECT table_name
  FROM user_tables
 WHERE table_name = 'TABLE_NAME';
```

Alternatively you might want to user *WHERE LIKE* to broaden the search if not exactly sure of the table_name.
#### Does a colum exist in a table?
```sql
SELECT column_name AS FOUND
  FROM user_tab_cols
 WHERE table_name = 'TABLE_NAME' AND column_name = 'COLUMN_NAME';
```

#### How much memory is user by a colum in a table?
```sql
SELECT SUM(VSIZE('columnname'))/1024/1024 MB
  FROM 'tablename'
```

#### How to find the schema name and the DB user name from an active session?
```sql
SELECT sys_context('USERENV', 'SESSION_USER') SESSION_USER, sys_context('USERENV', 'CURRENT_SCHEMA') CURRENT_SCHEMA
  FROM dual;
```

**sys_context()** function returns the value of parameter associated with the context namespace. USERENV is an Oracle provided namespace that describes the current session. Check the table Predefined Parameters of Namespace USERENV for the list of parameters and the expected return values.

#### How to find all tables with CLOB, BLOB, RAW, NCLOB columns?
```sql
SELECT DISTINCT('SELECT DBMS_METADATA.GET_DDL(''TABLE'',''' ||table_name|| ''') from DUAL;') a
  FROM user_tab_columns
 WHERE data_type in ('CLOB','BLOB','RAW','NCLOB')
 ORDER BY a;
```

**Example Output:**







#### How to get the DDL for a given object?
```sql
SELECT DBMS_METADATA.get_ddl ('TABLE', 'TABLE_NAME', 'USER_NAME')
  FROM DUAL;
```


**Example output:**

```
CREATE TABLE "PUBS"."BOOK"
( "BOOK_KEY" VARCHAR2(6),
  "PUB_KEY" VARCHAR2(4),
  "BOOK_TITLE" VARCHAR2(80),

  "BOOK_TYPE" VARCHAR2(30),
  "BOOK_RETAIL_PRICE" VARCHAR2(30),
  "BOOK_ADVANCES" VARCHAR2(30),

  "BOOK_ROYALTIES" NUMBER(10,0),
  "BOOK_YTD_SALES" NUMBER(10,0),
  "BOOK_COMMENTS" VARCHAR2(200),

"BOOK_DATE_PUBLISHED" DATE a
) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "USERS";

```

**Pro Tip:**
> Use SQL Developer to export object DDLs with point n click.

**Aditional reading:**  
[Oracle documentation: DBMS_METADATA](http://docs.oracle.com/database/121/ARPLS/d_metada.htm#ARPLS026)  
[Burleson on DBMS_METADATA](http://www.dba-oracle.com/t_1_dbms_metadata.htm)
















## Database Admin
### MANAGE USERS
--------------------------------------------
#### How many users are connected?
#### How to show all Oracle users and their files?
```sql
SELECT *
  FROM dba_users;
```


### MANAGE SPACE & MEMORY
#### How much free space is there in all tablespaces?


#### How to shows tablespaces, disk used, free space and datafiles?

```sql
SELECT t.tablespace_name "Tablespace",
       t.status "Estado",
       ROUND(MAX(d.bytes)/1024/1024,2) "MB Tamaño",
       ROUND((MAX(d.bytes)/1024/1024) -
       (SUM(DECODE(f.bytes, NULL,0, f.bytes))/1024/1024),2) "MB Usados",
       ROUND(SUM(DECODE(f.bytes, NULL,0, f.bytes))/1024/1024,2) "MB Libres",
       t.pct_increase "% incremento",
       SUBSTR(d.file_name,1,80) "Fichero de datos"
  FROM DBA_FREE_SPACE f,
       DBA_DATA_FILES d,
       DBA_TABLESPACES t
 WHERE t.tablespace_name = d.tablespace_name AND
       f.tablespace_name(+) = d.tablespace_name
       AND f.file_id(+) = d.file_id
       GROUP BY t.tablespace_name, d.file_name, t.pct_increase, t.status
       ORDER BY 1,3 DESC
```




### MANAGE NETWORKING
#### How to get the Oracle server IP address?
#### How to show actual Oracle conections?  
To use it the user need administrator privileges.

```sql
SELECT osuser, username, machine, program
  FROM v$session
  ORDER BY osuser;
```

#### How to show opened conections group by the program that opens the connection?

```sql
SELECT program Aplicacion, COUNT(program) Numero_Sesiones
  FROM v$session
  GROUP BY program
  ORDER BY Numero_Sesiones DESC;
```
### How to find out if Java is installed and enabled?


### How to find top 10 SQL?

```sql
SELECT *
  FROM (SELECT rownum SUBSTR(a.sql_text 1 200) sql_text TRUNC(a.disk_reads/DECODE(a.executions 0 1 a.executions)) reads_per_execution a.buffer_gets a.disk_reads a.executions a.sorts a.address
  FROM v$sqlarea a
  ORDER BY 3 DESC)
  WHERE rownum < 10;
```


### Last SQL queries executed on Oracle and user:
```sql
SELECT distinct vs.sql_text, vs.sharable_mem, vs.persistent_mem, vs.runtime_mem, vs.sorts, vs.executions, vs.parse_calls, vs.module, vs.buffer_gets, vs.disk_reads, vs.version_count, vs.users_opening, vs.loads, to_char(to_date(vs.first_load_time, 'YYYY-MM-DD/HH24:MI:SS'),'MM/DD HH24:MI:SS') first_load_time, rawtohex(vs.address) address, vs.hash_value hash_value , rows_processed , vs.command_type, vs.parsing_user_id , OPTIMIZER_MODE , au.USERNAME parseuser
  FROM v$sqlarea vs , all_users au
 WHERE (parsing_user_id != 0)
   AND (au.user_id(+)=vs.parsing_user_id)
   AND (executions >= 1)
   ORDER BY buffer_gets/executions DESC;
```






### Oracle SQL query to know free and used Shared_Pool
```sql
SELECT name,to_number(value) bytes
  FROM v$parameter
 WHERE name ='shared_pool_size'
 UNION ALL
SELECT name,bytes
  FROM v$sgastat
 WHERE pool = 'shared pool'
   AND name = 'free memory'
Cursores abiertos por usuario
SELECT b.sid, a.username, b.value Cursores_Abiertos
  FROM v$session a,
       v$sesstat b,
       v$statname c
WHERE c.name in ('opened cursors current')
AND b.statistic# = c.statistic#
AND a.sid = b.sid
AND a.username is not null
AND b.value >0
ORDER BY 3;
```





### Oracle SQL query that shows definition data from a specific table
•• (in this case, all tables with string "XXX")  
select * from ALL_ALL_TABLES where upper(table_name) like '%XXX%'



### Oracle SQL query to know Oracle products installed and version number.
```sql
select * from product_component_version
```
```
PRODUCT                                  VERSION                        STATUS             
---------------------------------------- ------------------------------ --------------------
NLSRTL                                   11.2.0.2.0                     Production          
Oracle Database 11g Express Edition      11.2.0.2.0                     64bit Production    
PL/SQL                                   11.2.0.2.0                     Production          
TNS for 64-bit Windows:                  11.2.0.2.0                     Production        
```

### Oracle SQL query to know roles and roles privileges
```sql
select * from role_sys_privs
```

### Oracle SQL query to know integrity rules
```sql
select constraint_name, column_name from sys.all_cons_columns
```

### How to find CPU usage by User?
```sql
SELECT ss.username,
	   se.SID,
		VALUE/100 cpu_usage_seconds
  FROM v$session ss,
  		v$sesstat se,
  		v$statname sn
 WHERE se.STATISTIC# = sn.STATISTIC#
   AND NAME like '%CPU used by this session%'
   AND se.SID = ss.SID
   AND ss.status='ACTIVE'
   AND ss.username is not null
ORDER BY value DESC;
```

**Output:**



### Who is blocking who? Find Locks.

### How to work with DB links?
List All DB Links  
Add new DB Link  
Sending queries over DB Links  
### Add new user
### Grant Permissions  
### Managing Jobs
### Export & Backups

exp userid=system/password@XE schemas=SCHEMA_NAME dumpfile=DUMP_NAME.dmp logfile=LOG_FILE_NAME.log

or

exp userid=system/password@XE owner=SCHEMA_NAME file=DUMP_NAME.dmp

To import you can use below commands.

impdp system/root@XE schemas=SCHEMA_NAME dumpfile=SCHEMA_NAME_DMP.dmp logfile=client.log

or

imp userid=system/root@XE full=N IGNORE=Y FILE=C:/Users/SCHEMA_NAME_DMP.dmp

To know difference between exp/imp and expdp/impdp please follow below link.

Original Export and Import Versus Data Pump Export and Import


#### How to display database Recovery status:
```sql
SELECT *
  FROM v$backup;
```
```sql
SELECT *
  FROM v$recovery_status;
```
```sql
SELECT *
  FROM v$recover_file;
```
```sql
SELECT *
  FROM v$recovery_file_status;
```
```sql
SELECT *
  FROM v$recovery_log;
```
#### expdp & impdp

## Resources

Ask Tom -
StackOverflow Oracle -

Ask questions, get anwsers:


## Usefull Views
