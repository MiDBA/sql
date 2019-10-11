set serveroutput on
declare
schma           varchar2(30) := 'MIAIMS';
BEGIN
        --EXECUTE IMMEDIATE 'SELECT * from dba_tab_privs where grantee='jeff'';   
        dbms_output.put_line('Prompt User Audit for: '||schma);
        dbms_output.put_line('set lin 400');
        dbms_output.put_line('set pages 800');
        dbms_output.put_line('Prompt System Privs');
        dbms_output.put_line('SELECT PRIVILEGE from dba_sys_privs where grantee='''||schma||''';');
        dbms_output.put_line('Prompt Role Privs');
        dbms_output.put_line('SELECT granted_role from dba_role_privs where grantee='''||schma||''';');
        dbms_output.put_line('Prompt Table Privs');
        dbms_output.put_line('SELECT privilege,owner,table_name from dba_tab_privs where grantee='''||schma||''';');
        dbms_output.put_line('Prompt Users granted proxy to '||schma);
        dbms_output.put_line('SELECT proxy from dba_proxies where client='''||schma||''';');
        dbms_output.put_line('Prompt Users '||schma||' can proxy to');
        dbms_output.put_line('SELECT client from dba_proxies where proxy='''||schma||''';');
        dbms_output.put_line('SELECT * from DBA_NETWORK_ACL_PRIVILEGES where principal='''||schma||''';');
END;
