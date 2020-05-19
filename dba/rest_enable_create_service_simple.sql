-- /ords/nova_runda/rest-api/artikli
BEGIN
  ORDS.enable_schema(
    p_enabled             => TRUE,
    p_schema              => 'NRWH',
    p_url_mapping_type    => 'BASE_PATH',
    p_url_mapping_pattern => 'nova_runda',
    p_auto_rest_auth      => FALSE
  );
    
  COMMIT;
END;
/
BEGIN
  ORDS.define_service(
    p_module_name    => 'rest-api',
    p_base_path      => 'rest-api/',
    p_pattern        => 'artikli/',
    p_method         => 'GET',
    p_source_type    => ORDS.source_type_collection_feed,
    p_source         => 'SELECT * FROM v_rest_artikli',
    p_items_per_page => 0);

  COMMIT;
END;
/



select * from user_ords_modules;

select * from user_ords_templates;

select * from user_ords_handlers;
/*
-- manual build 
BEGIN
  ORDS.define_module(
    p_module_name    => 'rest',
    p_base_path      => 'nova_runda/',
    p_items_per_page => 0);
  
  ORDS.define_template(
   p_module_name    => 'rest',
   p_pattern        => 'artikli/');

  ORDS.define_handler(
    p_module_name    => 'rest',
    p_pattern        => 'employees/',
    p_method         => 'GET',
    p_source_type    => ORDS.source_type_collection_feed,
    p_source         => 'SELECT * FROM v_rest_artikli',
    p_items_per_page => 0);
    
  COMMIT;
END;
/