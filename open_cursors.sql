select a.value, s.username, s.sid, s.serial#,s.inst_id,s.logon_time
from 
gv$sesstat a, gv$statname b, gv$session s 
where a.statistic# = b.statistic#  and s.sid=a.sid and b.name = 'opened cursors current' and s.username is not null
order by 2,1;
