### NETWORKING
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
