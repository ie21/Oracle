/* CREATE TABLE OBJECTS 
 *
 * 1: 
 *  - table with specified columns (_DATE for DATE datatype, or else VARCHAR2(4000)
 *  - sequence for table ID column
 *  - trrigger for insert into ID from sequence 
 *
 * 2: 
 *  - store DDL into table for later use 
 * 
 */


create or replace procedure create_table (
    p_table_name   VARCHAR2
    , p_cols  VARCHAR2
    , p_clean number default null
)
IS
    v_trig_name VARCHAR2(90);
    v_seq_name  VARCHAR2(90);
    v_object_check VARCHAR2(256);
    v_sql_seq VARCHAR2(4000);
    v_sql_trig VARCHAR2(4000);
    v_sql_table VARCHAR2(4000);
    v_sql   VARCHAR2(4000);
    v_array apex_application_global.vc_arr2;
    v_col_type varchar2(4000);
    v_temp_table varhar2(4000) := 'create table DDL_SQL (CODE long);';

    BEGIN

    v_trig_name := 'TRG_ID_INS_' || UPPER(p_table_name);
    v_seq_name := 'SEQ_ID_' || UPPER(p_table_name);
    

    --  CREATE TABLE
    v_sql_table := 'CREATE TABLE ' 
                    || P_TABLE_NAME
                    || ' ( ID NUMBER, '
                    || CHR(10);

        v_array := apex_util.string_to_table(p_cols, ',');
        for i in 1..v_array.count
         loop
            v_col_type := 'VARCHAR2(4000)';
            
            IF UPPER(V_ARRAY(I)) LIKE '%DATE%' THEN
                v_col_type := 'DATE';
            END IF;

            if UPPER(V_ARRAY(I)) LIKE '%NUM' THEN   
                v_col_type := 'NUMBER';
            END IF;
               
            v_sql_table := v_sql_table 
                            || CHR(10) 
                            || V_ARRAY(I) 
                            || ' ' 
                            || v_col_type
                            || ',';
         end loop;

   v_sql_table := v_sql_table 
                    || chr(10) 
                    || 'USER_CREATE_ID NUMBER, 
                        USER_CHANGE_ID NUMBER, 
                        DATE_CREATE DATE, 
                        DATE_CHANGE DATE ' 
                    || ') ' ;

    -- CERATE SEQUENCE
    v_sql_seq := '
        CREATE SEQUENCE ' || v_seq_name 
        || '
            MINVALUE 1 MAXVALUE 999999999999999999999999999 
            INCREMENT BY 1 START WITH 1
            CACHE 20 NOCYCLE ';

    -- CREATE TRIGGER
    v_sql_trig := '
        create or replace TRIGGER ' || v_trig_name
        || '
            BEFORE
            INSERT OR UPDATE
            ON ' || p_table_name
            || '
            REFERENCING NEW AS NEW OLD AS OLD
            FOR EACH ROW
            DECLARE
            BEGIN
                IF INSERTING
                THEN
                    IF NVL ( :NEW.id, 0 ) <= 0
                    THEN
                          SELECT  '
                          ||  v_seq_name || '.NEXTVAL INTO :NEW.ID FROM DUAL;
                    END IF;

                    :NEW.USER_CREATE_ID   := NVL ( v ( ''MS_USER_ID'' ), -1 );
                    :NEW.DATE_CREATE      := SYSDATE;
                END IF;

                :NEW.USER_CHANGE_ID   := NVL ( v ( ''MS_USER_ID'' ), -1 );
                :NEW.DATE_CHANGE      := SYSDATE;
        END;';
    
    if p_clean = -1 THEN
            EXECUTE IMMEDIATE 'truncate table ' || p_table_name;
            EXECUTE IMMEDIATE 'drop table '|| p_table_name; 
            EXECUTE IMMEDIATE 'drop sequence ' || v_seq_name;
            EXECUTE IMMEDIATE 'drop trigger '|| v_trig_name;       
        else             
            EXECUTE IMMEDIATE v_sql_table;
            EXECUTE IMMEDIATE v_sql_seq;   
            EXECUTE IMMEDIATE v_sql_trig;
            commit;
        END IF;
END create_table;