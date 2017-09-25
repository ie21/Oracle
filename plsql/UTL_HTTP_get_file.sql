create or replace FUNCTION get_url(
    url IN VARCHAR2 )
  RETURN BLOB
IS
  vblobref BLOB;
  vrequest UTL_HTTP.req;
  vresponse UTL_HTTP.resp;
  vdata RAW (32767);
BEGIN
  DBMS_LOB.createtemporary (vblobref, TRUE, DBMS_LOB.SESSION );
  vrequest := UTL_HTTP.begin_request (url);
  UTL_HTTP.set_header (vrequest, 'User-Agent', 'Mozilla/4.0' );
  vresponse := UTL_HTTP.get_response (vrequest);
  LOOP
    BEGIN
      UTL_HTTP.read_raw (vresponse, vdata);
      DBMS_LOB.writeappend (lob_loc => vblobref, amount => UTL_RAW.LENGTH (
      vdata), buffer => vdata );
    EXCEPTION
    WHEN UTL_HTTP.end_of_body THEN
      EXIT;
    END;
  END LOOP;
UTL_HTTP.end_response (vresponse);
RETURN vblobref;
END get_url;