col db_name format a10
col node format a10
col PRIM_ARC_SEQ format a15
col STBY_ARC_SYNCH format a15
col STBY_ARC_LAG format a15
select upper(sys_context('USERENV','DB_NAME')) DB_NAME,
to_char(a.thread#) NODE,
to_char(max(a.sequence#)) "PRIM_ARC_SEQ",
to_char(max(a.NEXT_TIME),'DD-MON-YY - HH24:MI:SS') "PRIM_ARC_DT_TM",
to_char(max(decode(APPLIED,'YES',a.sequence#,0))) "STBY_ARC_SYNCH",
to_char(max(decode(APPLIED,'YES',a.NEXT_TIME,NULL)),'DD-MON-YY - HH24:MI:SS') "STBY ARC SYNCH DT_TM",
to_char((max(a.sequence#) - max(decode(APPLIED,'YES',a.sequence#,0)))) "STBY_ARC_LAG"
from v$archived_log a
where a.RESETLOGS_CHANGE# = (select RESETLOGS_CHANGE# from v$database)
group by a.thread#
order by 2;
