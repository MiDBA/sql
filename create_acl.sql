BEGIN
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL (
    ACL          => 'uat_utl_https.xml',
    description  => 'ACL for SSL between ASCAP and Bridges',
    principal    => 'SYS',
    is_grant     => TRUE,
    privilege    => 'connect',
    start_date   => SYSTIMESTAMP,
    end_date     => NULL);

  COMMIT;
end;
/

BEGIN
  DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => 'uat_utl_https.xml',
    HOST        => 'bridgesuatr1-3.mfia.state.mi.us',
    LOWER_PORT  => 443,
    upper_port  => 443);

  COMMIT;
end;
/

BEGIN
DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE (
   ACL             => 'uat_utl_https.xml',
   principal       => 'ASCAP',
   is_grant        => TRUE,
   privilege       => 'connect',
    start_date   => SYSTIMESTAMP,
    end_date     => NULL);
	
	COMMIT;
END;
/
