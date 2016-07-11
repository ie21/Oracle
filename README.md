# ProbableOracle
Useful Oracle database commands, scripts, tips &amp; hacks

**Table of Contents**

[TOC]

## Introduction
This document is being produced for repetition material for Oracle SQL Fundamentals and SQL Expert Exams. 

## Asking Questions

### What is the database version? 

```sql
SELECT *
  FROM v$version;
```
 
### What is the Database name? 
```sql
SELECT value 
  FROM v$system_parameter 
 WHERE name = 'db_name';
```

### What are Oracle database general parameters?
```sql
SELECT * 
  FROM v$system_parameter;
  ```


### How many users are connected? 
### How much free space is there in all tablespaces? 
### Who is blocking who? 
### Does a table exist in current DB schema? 
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
  
### How much memory is user by a colum in a table? 
```sql
SELECT SUM(VSIZE('columnname'))/1024/1024 MB 
  FROM 'tablename'
  ```



### How to show all oracle users and their files? 
```sql
SELECT * 
  FROM dba_users
```
### What tablespaces are available?
```sql
select * from V$TABLESPACE
```

### What tables are owned by user?
```sql
SELECT table_owner, table_name from sys.all_synonyms where table_owner like 'xxx'
```

### What is the database size?
```sql
select sum(BYTES)/1024/1024 MB from DBA_EXTENTS
```

### What is the size of the database data file? 
```sql
SELECT sum(bytes)/1024/1024 MB 
  FROM dba_data_files;
```

### What are table of current user? 
```sql
SELECT * 
  FROM user_tables;
```

### How to find out all objects connected to current user? 
```sql
SELECT * 
  FROM user_catalog;
```

## Database Admin
### Managing Users
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
