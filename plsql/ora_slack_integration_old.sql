-- uses new API, this code is depreceted.

declare
  p_url            varchar2(2000):= 'https://slack.com/api/chat.postMessage';
  l_http_request   utl_http.req;
  l_http_response  utl_http.resp;
  l_text           varchar2(32767);
  l_token          varchar2(1000)  := 'T1RP4CABU/B1RQFBMCP/4EbrPcxbDOoVLwDHg5NjbIQC';
  l_param          varchar2(32676) := 'channel=#oracle'||chr(38)
                                    ||'text=Hello world from the database';
BEGIN
  UTL_HTTP.SET_DETAILED_EXCP_SUPPORT ( TRUE );  
  utl_http.set_wallet('file:G:\Oracle\app\oracle\wallet\ewallet.p12');
  -- 
  L_HTTP_REQUEST  := UTL_HTTP.BEGIN_REQUEST
                       ( url=>p_url||'?token='||l_token
                       , method => 'POST'
                       );
  utl_http.set_header
    ( r      =>  l_http_request
    , name   =>  'Content-Type'
    , value  =>  'application/x-www-form-urlencoded'
    );				
  utl_http.set_header 
    ( r      =>   l_http_request
    , name   =>   'Content-Length'
    , value  =>   length(l_param)
    );
  utl_http.write_text
    ( r      =>   l_http_request
    , data   =>   l_param
    );
  -- 
  l_http_response := UTL_HTTP.get_response(l_http_request);
  BEGIN
    LOOP
      UTL_HTTP.read_text(l_http_response, l_text, 32766);
      DBMS_OUTPUT.put_line (l_text);
    END LOOP;
  EXCEPTION
    WHEN utl_http.end_of_body 
    THEN
      utl_http.end_response(l_http_response);
  END;
EXCEPTION
  WHEN OTHERS 
  THEN
    utl_http.end_response(l_http_response);
    RAISE;
END;