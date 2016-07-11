### MANAGE SPACE & MEMORY
#### How much free space is there in all tablespaces?

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

#### How to shows tablespaces, disk used, free space and datafiles?

```sql
SELECT t.tablespace_name "Tablespace",
       t.status "Status",
       ROUND(MAX(d.bytes)/1024/1024,2) "MB Size",
       round((MAX(d.bytes)/1024/1024) -
       (SUM(DECODE(f.bytes, NULL,0, f.bytes))/1024/1024),2) "MB Used",
       ROUND(sum(DECODE(f.bytes, NULL,0, f.bytes))/1024/1024,2) "MB Free",
       SUBSTR(d.file_name,1,80) "Datafile"
  FROM DBA_FREE_SPACE f,
       DBA_DATA_FILES d,
       DBA_TABLESPACES t
 WHERE t.tablespace_name = d.tablespace_name AND
       f.tablespace_name(+) = d.tablespace_name
       AND f.file_id(+) = d.file_id
       GROUP BY t.tablespace_name, d.file_name, t.status
       ORDER BY 1,3 DESC;
```
```
Tablespace                     Status       MB Size    MB Used    MB Free Datafile
------------------------------ --------- ---------- ---------- ---------- --------------------------------------------------------------------------------
APEX_1655289364460851          ONLINE         50.06      15.38      34.69 G:\ORACLE\APP\ORACLE\ORADATA\XE\APEX_1655289364460851.DBF
SYSAUX                         ONLINE          1340    1271.38      68.63 G:\ORACLE\APP\ORACLE\ORADATA\XE\SYSAUX.DBF
SYSTEM                         ONLINE           570     560.56       9.44 G:\ORACLE\APP\ORACLE\ORADATA\XE\SYSTEM.DBF
UNDOTBS1                       ONLINE           430       6.63     423.38 G:\ORACLE\APP\ORACLE\ORADATA\XE\UNDOTBS1.DBF
USERS                          ONLINE           100       7.38      92.63 G:\ORACLE\APP\ORACLE\ORADATA\XE\USERS.DBF
USER_DATA                      ONLINE            32       9.19      22.81 G:\ORACLE\APP\ORACLE\PRODUCT\11.2.0\SERVER\DATABASE\WH_DATA.DBF
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
