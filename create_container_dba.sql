create user c##lowej5 identified by **** container=all;
grant sysdba to c##lowej5 container=all;
grant dba to c##lowej5 container=all;

ALTER USER c##lowej5 SET CONTAINER_DATA = all CONTAINER=CURRENT;
