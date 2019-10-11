set serveroutput on
declare
schma           varchar2(30) := 'ASCAP_DATA';
grant_to        varchar2(30) := 'miaims_ro';
BEGIN
    FOR t IN (SELECT object_name, object_type FROM dba_objects where owner=schma order by object_type) 
    LOOP   
        --EXECUTE IMMEDIATE 'GRANT SELECT ON '||schma||'.' || t.table_name || ' TO '||grant_to; 
        if t.object_type= 'TABLE' or t.object_type= 'SEQUENCE' or t.object_type= 'VIEW' then
          dbms_output.put_line('GRANT SELECT ON '||schma||'.' || t.object_name || ' TO '||grant_to||';');
        elsif t.object_type= 'FUNCTION' or t.object_type= 'PROCEDURE' or t.object_type= 'PACKAGE' then
          dbms_output.put_line('  GRANT EXECUTE ON '||schma||'.' || t.object_name || ' TO '||grant_to||';');
        end if;
    END LOOP;
END;
