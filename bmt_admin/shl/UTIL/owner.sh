psql -AXt <<!
select ' alter table '||schemaname||'.'||tablename ||' owner to  letl;'  
from   pg_tables
where  schemaname in ('sdmin', 'sdmin_err') ;
!
