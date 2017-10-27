### Oracle integration with Slack

1. setup webhook inside Slack
2. Setup ACL inside Oracle
3. Setup certificates in 11XE (oracle wallet workaround for https)
 - download OpenSSL https://wiki.openssl.org/index.php/Binaries

  Using openssl what does “unable to write 'random state'” mean? [closed]

## Articles:
------------------------------------------------------------------



**Oracle 11g Access Control List for External Network Services**  
http://www.oracleflash.com/36/Oracle-11g-Access-Control-List-for-External-Network-Services.html  
From Oracle 11g network packages like UTL_TCP, UTL_SMTP, UTL_MAIL, UTL_HTTP, and UTL_INADDR which can be used to access external network resources, are more restricted and secured. Oracle 11g introduced Fine-Grained Access to these packages by creating an Access Control List to use any external network resource through these packages. Before this any user who had an execute privilege on these packages was able to do anything to any network resource like web and local mail servers etc. But now a user needs a little more then just an execute privilege on the network packages.

**OpenSSL workaround for Oracle XE wallet**
https://blog.hazrulnizam.com/openssl-workaround-oracle-xe-wallet/  

**Slack SQL - Execute SQL queries inside of Slack**
https://www.producthunt.com/tech/slack-sql

Oracle PL/SQL integration with Slack -
https://emoracle.wordpress.com/2014/11/14/oracle-plsql-integration-with-slack/  

Oracle Developer Cloud Service: Using WebHooks to Integrate with Slack for Messaging - https://apexapps.oracle.com/pls/apex/f?p=44785:24:::NO::P24_CONTENT_ID,P24_PREV_PAGE:11852,2


slackstack
http://slackstack.io/resources/developers/


Sentry, Airbrake, Raygun and error tracking
