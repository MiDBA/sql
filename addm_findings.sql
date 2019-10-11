select 
--trunc(t.begin_time) as RUN_DATE,
t.begin_time,finding_name,impact_type, message, 
f.more_info,f.database_time,
f.active_sessions,
perc_active_sess,
f.task_id
from DBA_ADDM_FINDINGS f, DBA_ADDM_TASKS t
where f.task_id=t.task_id
and f.type='PROBLEM'
--and trunc(t.begin_time) between trunc(sysdate-1) and trunc(sysdate)
order by trunc(t.begin_time) desc;
