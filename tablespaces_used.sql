--check resources needed
DEFINE schma = "MDOS_DMS";
set verify off
set pages 8000
set trims on
set echo off
set feedback off
col table_name format a30
col tablespace_name format a30
col column_name format a30
col segment_name format a30

--prompt Check LOBs
select distinct(tablespace_name) as LOB_Tablespaces
from dba_lobs
where owner in ('&schma');

--prompt Check Tables
select  distinct(tablespace_name) as Table_tablespaces
from dba_tables
where owner in ('&schma');

--prompt Check Indexes
select distinct(tablespace_name) as Index_tablespaces
from dba_indexes
where owner in ('&schma');

--prompt Check Partitioned Tables
select distinct(tablespace_name) as tab_part_tablespaces
from dba_tab_partitions
where table_owner in ('&schma');

--prompt Check partitioned Indexes
select distinct(tablespace_name) as Index_part_tablespaces
from DBA_IND_PARTITIONS
where index_owner in ('&schma');

prompt Check User Quota
select tablespace_name from DBA_TS_QUOTAS
where username='&schma';

--prompt Check Default tablespaces
select default_tablespace,
temporary_tablespace,
profile
from dba_users
where username='&schma';

prompt Check SYS Privs
select 'grant '||privilege|| ' to '||grantee||';' as schema_grants
from dba_sys_privs
where grantee='&schma';

prompt check # of datafiles needed
col file_name format a50
col MAXBYTES format 999,999,999,999
col autoextensible format a15
select file_name,maxbytes/1024/1024 MAX_MB,
autoextensible
from dba_data_files
where tablespace_name in (select  distinct(tablespace_name)
from dba_tables
where owner in ('&schma'));

