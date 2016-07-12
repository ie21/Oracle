
### Exploring The Database
-------------------------------------------




#### Is the database open?

 I collect useful columns like instance_name and version, as well as the database startup_time and current status.

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






### List Database version information

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

### List installed Oracle products and version number.
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


### List the installed database components
```sql
select * from all_registry_banners;
```
```
BANNER                                                                         
--------------------------------------------------------------------------------
Oracle Database Catalog Views Release 11.2.0.2.0 - 64bit Production             
Oracle Database Packages and Types Release 11.2.0.2.0 - Development             
Oracle Text Release 11.2.0.2.0 - Development                                    
Oracle XML Database Version 11.2.0.2.0 - Development                            
Oracle Application Express Release 5.0.3.00.03 - Development
```


#### List Oracle database general parameters
```sql
SELECT name, value, description
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

Todo: Explain system parameters


### Database Character Set Informations
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


#### What is the current database state?
```sql
SELECT *
  FROM v$instance;
```

#### What tablespace are available?
```sql
SELECT *
  FROM v$tablespace;
```

```
TS# NAME                           INC BIG FLA ENC
---------- ------------------------------ --- --- --- ---
  0 SYSTEM                         YES NO  YES
  2 UNDOTBS1                       YES NO  YES
  1 SYSAUX                         YES NO  YES
  4 USERS                          YES NO  YES
  3 TEMP                           NO  NO  YES
  5 APEX_1655289364460851          YES NO  YES
  6 USER_DATA                      YES NO  YES
```



### Exploring the user space and schemas
---------------------------------------------

#### What tables are avaiable to the current user*?
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

### Does a colum exist in a table?
```sql
SELECT column_name AS FOUND
  FROM user_tab_cols
 WHERE table_name = 'TABLE_NAME' AND column_name = 'COLUMN_NAME';
```



### How to find the schema name and the DB user name from an active session?
```sql
SELECT sys_context('USERENV', 'SESSION_USER') SESSION_USER, sys_context('USERENV', 'CURRENT_SCHEMA') CURRENT_SCHEMA
  FROM dual;
```

**sys_context()** function returns the value of parameter associated with the context namespace. USERENV is an Oracle provided namespace that describes the current session. Check the table Predefined Parameters of Namespace USERENV for the list of parameters and the expected return values.

### How to find all tables with CLOB, BLOB, RAW, NCLOB columns?
```sql
SELECT DISTINCT('SELECT DBMS_METADATA.GET_DDL(''TABLE'',''' ||table_name|| ''') from DUAL;') a
  FROM user_tab_columns
 WHERE data_type in ('CLOB','BLOB','RAW','NCLOB')
 ORDER BY a;
```

**Example Output:**







### How to get the DDL for a given object?
```sql
SELECT DBMS_METADATA.get_ddl ('TABLE', 'TABLE_NAME', 'USER_NAME')
  FROM DUAL;
```

**Pro Tip:**
> Use SQL Developer to export object DDLs with point n click.

**Aditional reading:**
> [Oracle documentation: DBMS_METADATA](http://docs.oracle.com/database/121/ARPLS/d_metada.htm#ARPLS026)
> [Burleson on DBMS_METADATA](http://www.dba-oracle.com/t_1_dbms_metadata.htm)








#### How many users are connected?
#### How to show all Oracle users and their files?
```sql
SELECT *
  FROM dba_users;
```


### Oracle SQL query that shows definition data from a specific table
•• (in this case, all tables with string "XXX")
select * from ALL_ALL_TABLES where upper(table_name) like '%XXX%'


### Oracle SQL query to know roles and roles privileges
```sql
select * from role_sys_privs
```

### Oracle SQL query to know integrity rules
```sql
select constraint_name, column_name from sys.all_cons_columns
```





### How to find out if Java is installed and enabled?





## Resources

Ask Tom -
StackOverflow Oracle -

Ask questions, get anwsers:


## Usefull Views
