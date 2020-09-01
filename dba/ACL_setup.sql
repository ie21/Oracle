BEGIN
DBMS_NETWORK_ACL_ADMIN.CREATE_ACL(ACL=>'slack.xml',
  DESCRIPTION=>'Slack Oracle access control list example',
  PRINCIPAL=>'SCHEMETEST',
  is_grant=>TRUE,
   privilege=>'connect');
  commit;
 end;
  /
  
  
  create role slackcomm;
  
  --�
  
  create role oracleflash;

-- A role is created. Now we grant connect to this role on our ACL.

BEGIN
   DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE (
    acl          => 'slack.xml',                
    principal    => 'SCHEMETEST',
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
grant execute on utl_http to SCHEMETEST;
/



//
//
/

//

BEGIN
  BEGIN
    dbms_network_acl_admin.drop_acl (acl => 'all-network-PUBLIC.xml');
  EXCEPTION
    WHEN OTHERS
    THEN
      NULL;
  END;
  dbms_network_acl_admin.create_acl (acl           => 'all-network-PUBLIC.xml',
                                     description   => 'Network connects for all',
                                     principal     => 'PUBLIC',
                                     is_grant      => TRUE,
                                     privilege     => 'connect');
  dbms_network_acl_admin.add_privilege (acl         => 'all-network-PUBLIC.xml',
                                        principal   => 'PUBLIC',
                                        is_grant    => TRUE,
                                        privilege   => 'resolve');
  dbms_network_acl_admin.assign_acl (acl => 'all-network-PUBLIC.xml', HOST => '*');
END;
/
COMMIT;
/
SELECT PRINCIPAL, HOST, lower_port, upper_port, acl, 'connect' AS PRIVILEGE, 
    DECODE(DBMS_NETWORK_ACL_ADMIN.CHECK_PRIVILEGE_ACLID(aclid, PRINCIPAL, 'connect'), 1,'GRANTED', 0,'DENIED', NULL) PRIVILEGE_STATUS
FROM DBA_NETWORK_ACLS
    JOIN DBA_NETWORK_ACL_PRIVILEGES USING (ACL, ACLID)  
UNION ALL
SELECT PRINCIPAL, HOST, NULL lower_port, NULL upper_port, acl, 'resolve' AS PRIVILEGE, 
    DECODE(DBMS_NETWORK_ACL_ADMIN.CHECK_PRIVILEGE_ACLID(aclid, PRINCIPAL, 'resolve'), 1,'GRANTED', 0,'DENIED', NULL) PRIVILEGE_STATUS
FROM DBA_NETWORK_ACLS
    JOIN DBA_NETWORK_ACL_PRIVILEGES USING (ACL, ACLID);
    select * from DBA_NETWORK_ACL_PRIVILEGES;
    select * from all_users;