# How does one load Java Source Code into the database?

Use the "CREATE OR REPLACE JAVA SOURCE" command or "loadjava" utility.

## To load java source in the database:
```java
create or replace java source named "Hello" as

        public class Hello {                             /* Pure Java Code */

                static public String Msg(String tail) {

                        return "Hello " + tail;

                }

        }

/
```
## To publish Java to PL/SQL:
```sql
create or replace function hello (str varchar2) return varchar as

        language java name 'Hello.Msg(java.lang.String) return java.lang.String';

/
```
## To call Java function:
```sql
select hello('Friend') from dual

/
```
Loaded code can be viewed by selecting from the USER_SOURCE view.
