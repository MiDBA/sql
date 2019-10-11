set serveroutput on
declare
val1 v$parameter.VALUE%TYPE;

begin

SELECT VALUE into val1 from V$OPTION WHERE PARAMETER = 'Unified Auditing';

if val1 is null then

DBMS_OUTPUT.PUT_LINE('null=' || val1);

else
    
DBMS_OUTPUT.PUT_LINE('not null=' || val1);
end if;

EXCEPTION 
    when  NO_DATA_FOUND then
    DBMS_OUTPUT.PUT_LINE('no data found');
   WHEN OTHERS THEN  
     DBMS_OUTPUT.PUT_LINE('Unhandled Exception');

end;
/
