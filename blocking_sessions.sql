select USERNAME, SQL_EXEC_START, OWNERID, BLOCKING_SESSION, sid, SERIAL#, SECONDS_IN_WAIT, EVENT, MACHINE 
FROM gv$session WHERE blocking_session IS NOT NULL order by seconds_in_wait desc;
