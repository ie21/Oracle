-- IN SOME SITUATIONS YOU MAY HAVE TO COMPILE MANY INVALID OBJECTS IN ONE GO. 
-- One approach is to write a custom script to identify and compile the invalid objects. 
-- The following example identifies and recompiles invalid packages and package bodies.

SET SERVEROUTPUT ON SIZE 1000000
BEGIN
  FOR cur_rec IN
  (
    SELECT
      owner,
      object_name,
      object_type,
      DECODE(object_type, 'PACKAGE', 1, 'PACKAGE BODY', 2, 2) AS
      recompile_order
    FROM
      dba_objects
    WHERE
      object_type IN ('PACKAGE', 'PACKAGE BODY')
    AND status    != 'VALID'
    ORDER BY
      4
  )
  LOOP
    BEGIN
      IF cur_rec.object_type = 'PACKAGE' THEN
        EXECUTE IMMEDIATE 'ALTER ' || cur_rec.object_type || ' "' ||
        cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE';
      ELSE
        EXECUTE IMMEDIATE 'ALTER PACKAGE "' || cur_rec.owner || '"."' ||
        cur_rec.object_name || '" COMPILE BODY';
      END IF;
    EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(cur_rec.object_type || ' : ' || cur_rec.owner ||
      ' : ' || cur_rec.object_name);
    END;
  END LOOP;
END;
/
