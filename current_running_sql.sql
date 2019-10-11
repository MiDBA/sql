col buffer_gets format 999,999,999
col event format a40
col schemaname format a20
col process format a10
select
ses.inst_id,ses.username,ses.schemaname,ses.process,ses.sql_id,
ses.sid,ses.serial#,ses.event,ses.state,ses.seconds_in_wait,
sql.sorts,
sql.fetches,
sql.disk_reads,
sql.buffer_gets,
sql.optimizer_mode,
sql.optimizer_cost,
sql.parsing_schema_name,
sql.sql_fulltext
FROM gV$SESSION SES, gV$SQLAREA SQL 
 where SES.STATUS = 'ACTIVE'
   and SES.USERNAME is not null
   and SES.SQL_ADDRESS    = SQL.ADDRESS 
   and SES.SQL_HASH_VALUE = SQL.HASH_VALUE 
   and Ses.AUDSID <> userenv('SESSIONID') ;
