set pages 8000
set lines 600
set head off
col tot format 99999999999999999
set colsep ","
select trunc(sysdate)-1,service_name,stat_name,sum(value) as tot
from cdb_hist_service_stat
where snap_id in (select snap_id FROM CDB_HIST_SNAPSHOT where trunc(begin_interval_time)=trunc(sysdate)-1)
and stat_name in ('DB time')
group by service_name,stat_name;
