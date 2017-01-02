psql -AXt <<!
select ' grant all on '||schemaname||'.'||tablename ||' to ladhoc,letl,lolap,loltp ;'  
from   pg_tables
where  schemaname like 'ma%';
!

psql -AXt <<!
select ' grant all on schema '||nspname ||' to ladhoc,letl,lolap,loltp ;'
from   pg_namespace
where  nspname like 'ma%'
or      nspname  in ('com', 'dba', 'public');
!
