# ProbableOracle
Useful Oracle database commands, scripts, tips &amp; hacks

**Table of Contents**

- [Introduction](#introduction)
- [Asking Questions]
   - [What is the database version?](#unn-dd)
   - [How many users are connected right now?](#tst-tdd)
   - [How much space is free in all tablespaces?](#free-space)
- [Database Administrators tasks](#database-administrators-tasks)
  - [Managing jobs](#jobs)
  - [Export Backups](#backups)
  - [Usefull Views](#usefull-views)
  - [v$views](#vvvv)

## Introduction
This document is being produced for repetition material for Oracle SQL Fundamentals and SQL Expert Exams. 

## Asking Questions

### What is the database version? 

```sql
SELECT *
  FROM v$version;
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
