select u.name,
d.profile,
d.default_tablespace,
d.temporary_tablespace,
u.spare4,
u.user#
from sys.user$ u, sys.dba_users d
where u.name=d.username
and type#=1
and u.name='USERNAME'

select 'create user '||u.name||' identified by values '''||spare4||''' DEFAULT TABLESPACE '||d.default_tablespace||' quota unlimited on '
||d.default_tablespace ||' TEMPORARY TABLESPACE '||d.temporary_tablespace||' profile '||d.profile||';'
from sys.user$ u, sys.dba_users d
where u.name=d.username
and type#=1
and d.username ='USERNAME'
and spare4 not like 'S:                                                            ;T:%';

set head off
select 'alter user '||u.name||' identified by values '''||spare4||'''; '
from sys.user$ u, sys.dba_users d
where u.name=d.username
and type#=1
and d.username ='USERNAME'
and spare4 not like 'S:                                                            ;T:%';
