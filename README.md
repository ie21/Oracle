# ProbableOracle
Useful Oracle database commands, scripts, tips &amp; hacks


[TOC]






## Introduction
This document is being produced for repetition material for Oracle SQL Fundamentals and SQL Expert Exams. 

Also, I work with the database every day and I figured this would be useful to more people. 

## Version information 
This document is entirely writen in Markdown using MacDown.


## Asking Questions

### Exploring The Database



#### Is the database open?
-----------------------------------------------------
How to find out if the database instance is opened?  
What does it meen that a database instance is opened? 

```sql
SELECT status 
  FROM v$instance;
```

**Example output:**
>
 SQL>  SELECT INSTANCE_NAME, DATABASE_STATUS, INSTANCE_ROLE from v$instance; 

> INSTANCE_NAME    DATABASE_STATUS   INSTANCE_ROLE
> 
> RGR01            ACTIVE            PRIMARY_INSTANCE

#### What is the database name? 
-----------------------------------------------------

```sql
SELECT value 
  FROM v$system_parameter 
 WHERE name = 'db_name';
```

#### What is the database version? 
-----------------------------------------------------

```sql
SELECT *
  FROM v$version;
```



#### What are this Oracle database general parameters?
-----------------------------------------------------
```sql
SELECT * 
  FROM v$system_parameter;
```

#### What is the database size?
-----------------------------------------------------
```sql
SELECT SUM(BYTES)/1024/1024 MB
  FROM dba_extents;
```

#### What is the size of the database data file? 
-----------------------------------------------------
```sql
SELECT SUM(bytes)/1024/1024 MB 
  FROM dba_data_files;
```



#### What is the current database state?
-----------------------------------------------------
```sql
SELECT * 
  FROM v$instance;
```

#### What tablespaces are available?
-----------------------------------------------------
```sql
SELECT * 
  FROM v$tablespaces;
```

Example output:



### Exploring the user space and schemas

#### What tables are owned by user?
-----------------------------------------------------
```sql
SELECT table_owner, table_name 
  FROM sys.all_synonyms 
 WHERE table_owner LIKE 'xxx';
```

#### What are tables of current user? 
-----------------------------------------------------
```sql
SELECT * 
  FROM user_tables;
```

#### How to find out all objects connected to current user? 
-----------------------------------------------------
```sql
SELECT * 
  FROM user_catalog;
```


#### Does a table exist in current DB schema?
---------------------------------------------------
 
If you quickly need to determine if a table exists in your current DB schema. Consider this you *search*.

```sql
SELECT table_name
  FROM user_tables
 WHERE table_name = 'TABLE_NAME';
```

Alternatively you might want to user *WHERE LIKE* to broaden the search if not exactly sure of the table_name. 
#### Does a colum exist in a table?
---------------------------------------------------
```sql
SELECT column_name AS FOUND
  FROM user_tab_cols
 WHERE table_name = 'TABLE_NAME' AND column_name = 'COLUMN_NAME';
```
  
#### How much memory is user by a colum in a table? 
---------------------------------------------------
```sql
SELECT SUM(VSIZE('columnname'))/1024/1024 MB 
  FROM 'tablename'
```



#### How to get the DDL for a given object? 
---------------------------------------------------
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

"BOOK_DATE_PUBLISHED" DATE 
) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 LOGGING 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "USERS";

```

### How many users are connected? 
---------------------------------------------------

### How much free space is there in all tablespaces?
---------------------------------------------------
 

### Who is blocking who?
---------------------------------------------------










## Database Admin
### Managing Users
#### How to show all Oracle users and their files? 
-----------------------------------------------------
```sql
SELECT * 
  FROM dba_users;
```

##### Add new user
##### Grant Permissions 
##### 
### Managing Jobs
### Export & Backups 

## Resources 

Ask Tom - 
StackOverflow Oracle - 

Ask questions, get anwsers: 


## Usefull Views
