psql <<!
select schema_nm, tb_nm, sum(tb_size_mb/1024) tb_size_gb, sum(ix_size_mb/1024) ix_size_gb, count(*) cnt
from   dba.tb_pt_size
where  schema_nm like 'mas%'
group by 1, 2
order by 1, 2
!
