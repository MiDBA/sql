set head off
set verify off
set lines 600
set feedback off
set pages 8000

--script off profiles
set serveroutput on
declare
prfile      varchar2(30);
res      varchar2(30);
lim      varchar2(30);
CURSOR prfiles IS select distinct(profile) from sys.dba_profiles where profile not in ('DBA','DEFAULT'); 
cursor rc is select resource_name,limit from sys.dba_profiles where profile=prfile;
BEGIN
open prfiles;
loop
    FETCH prfiles into prfile; 
    dbms_output.put_line('create profile "'||prfile||'" limit ');
    open rc;
    loop
        fetch rc into res,lim;
        EXIT WHEN rc%notfound;
        dbms_output.put_line(res||' '||lim);
    end loop;
    dbms_output.put_line(';');
    close rc;
    EXIT WHEN prfiles%notfound; 
end loop;
close prfiles;
END;
/

--Set all Role privs
select 'create role '||role ||';'
from dba_roles
where oracle_maintained <> 'Y'
order by role;

select 'grant '||privilege||' to '||grantee||';' 
from dba_sys_privs
where grantee in
(select role
from dba_roles
where oracle_maintained <> 'Y')
order by 1;

select 'grant '||granted_role||' to '||grantee||';' 
from dba_role_privs
where grantee in
(select role
from dba_roles
where oracle_maintained <> 'Y')
order by 1;


select 'grant '||privilege||' on '||owner||'.'||table_name||' to '||grantee||';'
from dba_tab_privs
where grantee in
(select role
from dba_roles
where oracle_maintained <> 'Y')


