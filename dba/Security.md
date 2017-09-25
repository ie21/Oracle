



> 3. Data Exfiltration
> Data Exfiltration involves the unauthorized transfer of data or sensitive information from a targeted database. In many cases, Oracle Java’s own tools are used to carry out these exploits. For example, Oracle possesses a package named UTL_TCP that can make connections to additional servers. In data exfiltration, an attacker will use UTL_TCP to send a data stream from a server to a remote host to capture privileged data. Additionally, the DBMS_OBFUSCATION_TOOLKIT and DBMS_CRYPTO package can be used by hackers to hide the contents of a hijacked data stream. To mitigate data exfiltration, mechanisms should be put in place to monitor and analyze incoming/outgoing data packets—this would typically be an IDS/IDPS or similar security solution.
