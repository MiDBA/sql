set linesize 300
set pagesize 300

col oracle_username format a15 heading 'ORACLE|USERNAME'
col object_owner    format a15
col object_name     format a20
col object_type     format a15
col osuser          format a8 heading 'OS|USERNAME'
col sid_ser         format a12
col status          format a12
col mode_held       format a15
col obj_file_block_row format a30
col module		format a25	heading 'MODULE'
col machine format a15 heading 'MACHINE'

SELECT 
       v.oracle_username USERNAME
     , decode(s.machine,null,s.terminal, s.machine) machine
     , s.osuser
     , s.sid||','||s.serial# sid_ser
     , decode(s.module,null,s.program,s.module) module
     , s.SQL_ID
     , d.owner           OBJECT_OWNER
     , d.object_name
     , d.object_type
     , l.type
     , l.ctime
--     , v.process
     , DECODE(l.block,0, 'Not Blocking'
                     ,1, 'Blocking'
                     ,2, 'Global'
              ) STATUS
     , DECODE(v.locked_mode,0, 'None'
                           ,1, 'Null'
                           ,2, 'Row-S (SS)'
                           ,3, 'Row-X (SX)'
                           ,4, 'Share'
                           ,5, 'S/Row-X (SSX)'
                           ,6, 'Exclusive'
                           , TO_CHAR(lmode)
              ) MODE_HELD
     , s.row_wait_obj#||' - '||s.row_wait_file#||' - '|| s.row_wait_block#||' - '||s.row_wait_row# obj_file_block_row
  FROM gv$lock l
     , gv$locked_object v
     , gv$session s
     , dba_objects d     
 WHERE l.sid        = v.session_id
   AND l.inst_id    = v.inst_id
   AND v.object_id  = d.object_id
   AND v.inst_id    = s.inst_id
   AND v.session_id = s.sid
   --and nvl(v.inst_id, 0) like nvl('&inst_id', '%')
   --and nvl(v.oracle_username,'null') like nvl(upper('&user'),'%')
   --and nvl(d.object_name,'null') like nvl(upper('&object_name'),'%')
--   AND s.ROW_WAIT_OBJ# = d.OBJECT_ID 
--   AND v.object_id  = l.id1
ORDER BY v.oracle_username
       , v.session_id
/
