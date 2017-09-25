Add the sqlplus login command before your sql commands in your batch file. It executes and writes to logs file where the batch file resides

syntax : sqlplus -s ora_user_name/ora_user_password [as sysdba]@ora_sid@"path_to_sql_file" > output.log

ex. sqlplus -s scott/tiger@xe @"D:\Oralcle\scripts\sql_file.sql" > output.txt
