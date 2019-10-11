set serveroutput on
declare
--http_req  utl_http.req;
   -- SOAP REQUESTS/RESPONSE
   soap_req_msg    VARCHAR2 (32767);
   soap_resp_msg   VARCHAR2 (32767);
   resp    Utl_Http.resp;
   req     Utl_Http.req;
   escaped_url  VARCHAR2 (32767);
   c_buffer     VARCHAR2 (32767);
   response_env VARCHAR2 (32767);
   url varchar2(100);
  i_Prog_Type VARCHAR2(10) := 'ILS';
  i_begin_date VARCHAR2(10) := '2015-05-01';
  i_end_date VARCHAR2(10)   := '2015-05-30';
  sv_EndDate VARCHAR2(20);
   -- HTTP REQUEST/RESPONSE
   http_req        UTL_HTTP.req;
   http_resp       UTL_HTTP.resp;
begin
url := 'https://bridgesuat.state.mi.us/services/INWSSFSessionEJB/wsdl/INWSSF.wsdl';

DBMS_OUTPUT.PUT_LINE('start');
UTL_HTTP.SET_WALLET('file:/etc/ORACLE/WALLETS/oracle','bridgesw1');
http_req := utl_http.begin_request(url);
DBMS_OUTPUT.PUT_LINE('Wallet opened');
 
req := 
Utl_Http.begin_request (url,'POST');
   soap_req_msg :='';

http_req :=   
   UTL_HTTP.begin_request (url,'POST','HTTP/1.1');
   --UTL_HTTP.set_header (http_req, 'Content-Type', 'text/xml');
   --UTL_HTTP.set_header (http_req, 'Content-Length', LENGTH (soap_req_msg));
   --UTL_HTTP.set_header (http_req, 'SOAPAction', '');
   UTL_HTTP.write_text (http_req, soap_req_msg);
   
DBMS_OUTPUT.PUT_LINE('UTL_HTTP Response');   

http_resp := 
    UTL_HTTP.get_response (http_req);
   --UTL_HTTP.read_text (http_resp, soap_resp_msg);
   --UTL_HTTP.read_line (http_resp, soap_resp_msg);
   
     /*
     while length(response_env) = 2000 LOOP
         utl_http.read_line(http_resp, soap_resp_msg);
         DBMS_OUTPUT.put_line ('Output: ' || soap_resp_msg);
         DBMS_OUTPUT.put_line ('Output2: ' || response_env);
         c_buffer := c_buffer||response_env;
      END LOOP;
      */
    LOOP
    UTL_HTTP.READ_LINE(http_resp, soap_resp_msg);
    DBMS_OUTPUT.PUT_LINE('LOOPING');
    DBMS_OUTPUT.PUT_LINE(soap_resp_msg);
    END LOOP;


   UTL_HTTP.end_response (http_resp);
   UTL_HTTP.END_RESPONSE(resp);
   --DBMS_OUTPUT.put_line ('Output: ' || c_buffer);
   --DBMS_OUTPUT.put_line ('Output: ' || soap_resp_msg);
   
EXCEPTION
      WHEN UTL_HTTP.TOO_MANY_REQUESTS THEN
           DBMS_OUTPUT.put_line (' EXCEPTION TOO_MANY_REQUESTS: ' || utl_http.get_detailed_sqlerrm);
           UTL_HTTP.END_RESPONSE(resp); 
      WHEN utl_http.request_failed   THEN
           DBMS_OUTPUT.put_line (' EXCEPTION Request_Failed: ' || utl_http.get_detailed_sqlerrm);
           utl_http.end_request (r => req); 
      WHEN Utl_Http.http_server_error  THEN
           DBMS_OUTPUT.put_line (' EXCEPTION Http_Server_Error: ' || Utl_Http.get_detailed_sqlerrm);
           Utl_Http.end_request (r => req); 
      WHEN Utl_Http.http_client_error THEN
           DBMS_OUTPUT.put_line (' EXCEPTION Http_Client_Error: ' || Utl_Http.get_detailed_sqlerrm);
           Utl_Http.end_request (r => req);  
      when others then
           dbms_output.put_line(' EXCEPTION ERROR AT BEGIN REQUEST '||SQLERRM);
           Utl_Http.end_request (r => req);
           Utl_Http.end_response (r => resp);
end;
/
