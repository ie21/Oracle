SELECT
    segment_nm,
    segment_type,
    LPAD( CASE
    WHEN bytes < 1024
    THEN ROUND( bytes, 2 ) || ' B'
    WHEN bytes < POWER( 1024, 2 )
    THEN ROUND( ( bytes / 1024 ), 2 ) || ' KB'
    WHEN bytes < POWER( 1024, 3)
    THEN ROUND( ( bytes / 1024 / 1024 ), 2 ) || ' MB'
    WHEN bytes < POWER( 1024, 4 )
    THEN ROUND( ( bytes / 1024 / 1024 / 1024 ), 2 ) || ' GB'
    ELSE ROUND( ( bytes / 1024 / 1024 / 1024 / 1024 ), 2 ) || ' TB'
    END, 15 ) AS used_size,
    tablespace_name
FROM
(
    SELECT
    owner || '.' || LOWER( segment_name ) AS segment_nm,
    segment_type,
    bytes,
    tablespace_name,
    DENSE_RANK() OVER ( ORDER BY bytes DESC ) AS dr
    FROM
    dba_segments
) A
WHERE
    dr <= 10 /* top-10 may have more then 10 */
    ORDER BY /* lots of ordering in cases of ties */
    bytes DESC,
    dr ASC,
    segment_nm ASC;