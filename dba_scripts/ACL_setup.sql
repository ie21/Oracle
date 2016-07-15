BEGIN
DBMS_NETWORK_ACL_ADMIN.CREATE_ACL(ACL=>'slack.xml',
  DESCRIPTION=>'Slack Oracle access control list example',
  PRINCIPAL=>'WH',
  is_grant=>TRUE,
   privilege=>'connect');
  commit;
 end;
  /
  
  
  create role slackcomm;
  
  --ž
  
  create role oracleflash;

-- A role is created. Now we grant connect to this role on our ACL.

BEGIN
   DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE (
    acl          => 'slack.xml',                
    principal    => 'WH',
    is_grant     => TRUE, 
    privilege    => 'connect',
    position     => null);
   COMMIT;
END;
/

BEGIN
   DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL (
    ACL          => 'slack.xml',                
    host         => '*.slack.com');
   COMMIT;
END;
/
BEGIN
DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(ACL => 'mikesac1.xml', host => 'www.slack.com');
COMMIT; 
END;
/

-- check ACL records
SELECT ACL , HOST , LOWER_PORT , UPPER_PORT FROM DBA_NETWORK_ACLS;
select acl , principal , privilege , is_grant from DBA_NETWORK_ACL_PRIVILEGES;


-- sqlplus: connect / as sysdba
grant execute on utl_http to wh;