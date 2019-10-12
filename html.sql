set termout off

set markup HTML ON HEAD " -
 -
  body {width:400px,font:10pt Arial,Helvetica,sans-serif; color:black; background:White;} -
  p {   font:10pt Arial,Helvetica,sans-serif; color:black; background:White;} -
        table,tr,td {font:10pt Arial,Helvetica,sans-serif; color:Black; background:#f7f7e7; -
        padding:0px 0px 0px 0px; margin:0px 0px 0px 0px; white-space:nowrap;} -
  th {  font:bold 10pt Arial,Helvetica,sans-serif; color:#336699; background:#cccc99; -
        padding:0px 0px 0px 0px;} -
  h1 {  font:16pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White; -
        border-bottom:1px solid #cccc99; margin-top:0pt; margin-bottom:0pt; padding:0px 0px 0px 0px;} -
  h2 {  font:bold 10pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White; -
        margin-top:4pt; margin-bottom:0pt;} a {font:9pt Arial,Helvetica,sans-serif; color:#663300; -
        background:#ffffff; margin-top:0pt; margin-bottom:0pt; vertical-align:top;} -
 -
" -
BODY "" -
TABLE "border='1'" -
SPOOL ON ENTMAP ON PREFORMAT OFF

@dba_audit.sql

set markup html off spool off
set termout on
