# Regular Expressions

http://docs.oracle.com/database/121/ADFNS/adfns_regexp.htm#ADFNS1003

Name	Description
REGEXP_LIKE

Condition that can appear in the WHERE clause of a query, causing the query to return rows that match the given pattern.

Example: This WHERE clause identifies employees with the first name of Steven or Stephen:

WHERE REGEXP_LIKE((hr.employees.first_name, '^Ste(v|ph)en$')
REGEXP_COUNT

Function that returns the number of times the given pattern appears in the given string.

Example: This function invocation returns the number of times that e (but not E) appears in the string 'Albert Einstein', starting at character position 7:

REGEXP_COUNT('Albert Einstein', 'e', 7, 'c')
(The returned value is 1, because the c option specifies case-sensitive matching.)

REGEXP_INSTR

Function that returns an integer that indicates the starting position of the given pattern in the given string. Alternatively, the integer can indicate the position immediately following the end of the pattern.

Example: This function invocation returns the starting position of the first valid email address in the column hr.employees.email:

REGEXP_INSTR(hr.employees.email, '\w+@\w+(\.\w+)+')
If the returned value is greater than zero, then the column contains a valid email address.

REGEXP_REPLACE

Function that returns the string that results from replacing occurrences of the given pattern in the given string with a replacement string.

Example: This function invocation puts a space after each character in the column hr.countries.country_name:

REGEXP_REPLACE(hr.countries.country_name, '(.)', '\1 ')
REGEXP_SUBSTR

Function that is like REGEXP_INSTR except that instead of returning the starting position of the given pattern in the given string, it returns the matching substring itself.

Example: This function invocation returns 'Oracle' because the x option ignores the spaces in the pattern:

REGEXP_SUBSTR('Oracle 2010', 'O r a c l e', 1, 1, 'x')
