-- creating the tuning task
set serveroutput on
declare
  l_sql_tune_task_id  varchar2(100);
begin
  l_sql_tune_task_id := dbms_sqltune.create_tuning_task (
                          sql_id      => 'f4z3txbcpwdr4',
                          scope       => dbms_sqltune.scope_comprehensive,
                          time_limit  => 60,
                          task_name   => 'f4z3txbcpwdr4_lowej5',
                          description => 'tuning task for statement f4z3txbcpwdr4');
  dbms_output.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/


-- executing the tuning task
exec dbms_sqltune.execute_tuning_task(task_name => 'f4z3txbcpwdr4_lowej5');


-- displaying the recommendations
set long 100000;
set longchunksize 1000
set pagesize 10000
set linesize 100
select dbms_sqltune.report_tuning_task('f4z3txbcpwdr4_lowej5') as recommendations from dual;
