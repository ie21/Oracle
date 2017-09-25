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
