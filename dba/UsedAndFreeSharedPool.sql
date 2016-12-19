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
