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
