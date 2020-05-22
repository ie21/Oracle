create or replace PROCEDURE set_lang_cookie
    IS

    f_language    varchar2(200);
    f_langc       OWA_COOKIE.cookie;

    BEGIN
      f_langc := OWA_COOKIE.get ('LANG_COOKIE');

      if f_langc.vals.count = 0
          then
            f_language := GET_APP_SETTINGS('AppLanguage');
            owa_cookie.send(
            name=>'LANG_COOKIE',
            value=> f_language);
      END IF;

      IF f_langc.vals.COUNT > 0 THEN
          if f_langc.vals(1) is null then
                   f_language := 'hr';
              ELSE
                    f_language := f_langc.vals(1);
          END IF;
                   owa_cookie.send(
                        name=>'LANG_COOKIE',
                        value=> f_language);
            ELSE
              f_language := f_langc.vals(1);

        END IF;

        owa_cookie.send(
           name=>'LANG_COOKIE',
           value=> f_language);


        HTMLDB_APPLICATION.update_cache_with_write ( 'FSP_LANGUAGE_PREFERENCE', f_language );
        apex_util.set_preference( p_preference => 'FSP_LANGUAGE_PREFERENCE'
                                , p_value      => f_language );

    EXCEPTION
       when NO_DATA_FOUND
       THEN
           NULL;

    END ;