set lines 600
set pages 8000
set feed off
set trims on
set verify off
set head off

--Count Datafiles
select count(file_name),tablespace_name
from dba_data_files
group by tablespace_name
having count(*) > 1;


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

--get role info
set pages 8000
select 'create role '||role ||';'
from dba_roles
where role not like ('OLAP%')
and role not like ('XDB%')
and role not like ('JAVA%')
and role not like ('%CATALOG%')
and role not like ('%DATABASE%')
and role not like ('%OEM%')
and role not like ('OWB%')
and role not in ('RESOURCE','DBA','CONNECT','ADM_PARALLEL_EXECUTE_TASK','JMXSERVER','GATHER_SYSTEM_STATISTICS','INFO_CHARGE_BACK_FULL','AQ_ADMINISTRATOR_ROLE','SCHEDULER_ADMIN')
order by role;

select 'grant '||privilege||' to '||grantee||';' 
from dba_sys_privs
where grantee in
(select role
from dba_roles
where role not like ('OLAP%')
and role not like ('XDB%')
and role not like ('JAVA%')
and role not like ('%CATALOG%')
and role not like ('%DATABASE%')
and role not like ('%OEM%')
and role not like ('OWB%')
and role not in ('RESOURCE','DBA','CONNECT','ADM_PARALLEL_EXECUTE_TASK','JMXSERVER','GATHER_SYSTEM_STATISTICS','INFO_CHARGE_BACK_FULL','AQ_ADMINISTRATOR_ROLE','SCHEDULER_ADMIN'))
order by 1;

select 'grant '||granted_role||' to '||grantee||';' 
from dba_role_privs
where grantee in
(select role
from dba_roles
where role not like ('OLAP%')
and role not like ('XDB%')
and role not like ('JAVA%')
and role not like ('%CATALOG%')
and role not like ('%DATABASE%')
and role not like ('%OEM%')
and role not like ('OWB%')
and role not in ('RESOURCE','DBA','CONNECT','ADM_PARALLEL_EXECUTE_TASK','JMXSERVER','GATHER_SYSTEM_STATISTICS','INFO_CHARGE_BACK_FULL','AQ_ADMINISTRATOR_ROLE','SCHEDULER_ADMIN'))
order by 1;


set pages 8000
select 'create tablespace '||tablespace_name||' DATAFILE ''+DATA'' SIZE 1G autoextend on maxsize unlimited DEFAULT COMPRESS FOR OLTP;'
from dba_tablespaces
where tablespace_name not in ('SYSTEM','SYSAUX','EXAMPLE','TEMP','SYSTEM_AUDIT')
and tablespace_name not like 'UNDO%'
order by 1;
