# COMPILE_SCHEMA Procedure

## DBMS_UTILITY.compile_schema

This procedure compiles all procedures, functions, packages, and triggers in the specified schema. After calling this procedure, you should select from view ALL_OBJECTS for items with status of INVALID to see if all objects were successfully compiled.

To see the errors associated with INVALID objects, you may use the Enterprise Manager command:

SHOW ERRORS <type> <schema>.<name>
Syntax
~~~sql
DBMS_UTILITY.COMPILE_SCHEMA (
   schema      VARCHAR2,
   compile_all BOOLEAN DEFAULT TRUE);
~~~

The example below shows how it is called from SQL*Plus.

~~~sql
EXEC DBMS_UTILITY.compile_schema(schema => 'SCOTT');
~~~
