

## rman

## prerequests
  * setup rman automatic backups on remote hosts


----------

1. setup backup from inside database
 - export:
    * entire Database file
      * send to where?
    * export schemas only
      * how to transfer backups to HQ* HTTP_UTL?
  * query v$rman_ for information on last backups
    - this can be done with rman and a batch script?
2. setup DB link to retrieve backup information status remotely
3. send backup information directly to Slack channel #backups
* post backup status to slack #backup channel
* make /query (client) - to check current backup status for client
