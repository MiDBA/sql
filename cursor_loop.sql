set serveroutput on
declare
ln NUMBER;
ib NUMBER;
seqowner VARCHAR2(500) := 'MRS_OWNER';
seqname VARCHAR2(500);
newvalue NUMBER;
--cursor my_cursor is SELECT last_number, increment_by,sequence_owner,sequence_name from dba_sequences where sequence_owner='MRS_TEMP';
cursor my_cursor is SELECT last_number, increment_by,sequence_name from dba_sequences where sequence_owner='MRS_TEMP';
BEGIN
OPEN my_cursor;
loop
FETCH my_cursor INTO ln, ib, seqname;
EXIT WHEN my_cursor%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('ALTER SEQUENCE ' || seqowner || '.' || seqname ||' INCREMENT BY ' || (ln));
DBMS_OUTPUT.PUT_LINE('SELECT ' || seqowner || '.' || seqname ||'.NEXTVAL FROM DUAL;');
DBMS_OUTPUT.PUT_LINE('ALTER SEQUENCE ' || seqowner || '.' || seqname || ' INCREMENT BY ' || ib);
end loop;
close my_cursor;
END;
