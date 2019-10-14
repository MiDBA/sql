set serveroutput on
declare
service_name VARCHAR2(500);
dbname VARCHAR2(500);
hostname VARCHAR2(500);
server_vip VARCHAR2(500);
server_vip2 VARCHAR2(500);
server_scan VARCHAR2(500);

cursor my_cursor is 
select s.service_name,
s.dbname, 
d.hostname,
r.server_vip,
r.server_scan
from itri_owner.itri_service s, 
itri_owner.itri_database d,
itri_owner.itri_server r
where s.dbname=d.dbname
and d.hostname=r.hostname
order by s.service_name;

BEGIN

    OPEN my_cursor;
        loop
            FETCH my_cursor INTO service_name,dbname,hostname,server_vip,server_scan;
            EXIT WHEN my_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(service_name||' = ');
            DBMS_OUTPUT.PUT_LINE('  (DESCRIPTION =');
            DBMS_OUTPUT.PUT_LINE('      (ADDRESS = (PROTOCOL = TCP)(HOST = hcv431corecma01.state.mi.us)(PORT = 1521))');
            DBMS_OUTPUT.PUT_LINE('      (ADDRESS = (PROTOCOL = TCP)(HOST = hcv431corecma02.state.mi.us)(PORT = 1521))');
            DBMS_OUTPUT.PUT_LINE('  (CONNECT_DATA =');
            DBMS_OUTPUT.PUT_LINE('      (SERVER = dedicated)');
            DBMS_OUTPUT.PUT_LINE('      (SERVICE_NAME = '||service_name||'.michigan.gov)');
            DBMS_OUTPUT.PUT_LINE('       )');
            DBMS_OUTPUT.PUT_LINE('   )');
            DBMS_OUTPUT.PUT_LINE('');
            
            DBMS_OUTPUT.PUT_LINE(service_name||' = ');
            DBMS_OUTPUT.PUT_LINE('  (DESCRIPTION =');
            DBMS_OUTPUT.PUT_LINE('      (ADDRESS = (PROTOCOL = TCP)(HOST = '||server_vip||')(PORT = 1521))');
                server_vip2:=replace(server_vip, '1','2');
                server_vip2:=replace(server_vip2, '3','4');
                server_vip2:=replace(server_vip2, '7','8');
            DBMS_OUTPUT.PUT_LINE('      (ADDRESS = (PROTOCOL = TCP)(HOST = '||server_vip2||')(PORT = 1521))');
            DBMS_OUTPUT.PUT_LINE('  (CONNECT_DATA =');
            DBMS_OUTPUT.PUT_LINE('      (SERVER = dedicated)');
            DBMS_OUTPUT.PUT_LINE('      (SERVICE_NAME = '||service_name||'.michigan.gov)');
            DBMS_OUTPUT.PUT_LINE('       )');
            DBMS_OUTPUT.PUT_LINE('   )');
            DBMS_OUTPUT.PUT_LINE('');
                                    
            DBMS_OUTPUT.PUT_LINE(service_name||' = ');
            DBMS_OUTPUT.PUT_LINE('  (DESCRIPTION =');
            DBMS_OUTPUT.PUT_LINE('      (ADDRESS = (PROTOCOL = TCP)(HOST = '||server_scan||')(PORT = 1521))');
            DBMS_OUTPUT.PUT_LINE('  (CONNECT_DATA =');
            DBMS_OUTPUT.PUT_LINE('      (SERVER = dedicated)');
            DBMS_OUTPUT.PUT_LINE('      (SERVICE_NAME = '||service_name||'.michigan.gov)');
            DBMS_OUTPUT.PUT_LINE('       )');
            DBMS_OUTPUT.PUT_LINE('   )');
            DBMS_OUTPUT.PUT_LINE('');


        end loop;
    close my_cursor;
    
END;