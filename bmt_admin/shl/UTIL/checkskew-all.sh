#/bin/bash
. /usr/local/greenplum-db/greenplum_path.sh

echo "current $GPHOME"

#psql -U gpadmin -d posco -tc "select schemaname||'.'||tablename  from pg_tables;"
tabname=$(/usr/local/greenplum-db/bin/psql -U gpadmin -d pil -tc "select schemaname||'.'||tablename  from pg_tables;"|grep -v err|grep -v ext|grep -v pg_catalog|grep -v gp_toolkit)

#echo $tabname

for t in $tabname 
do
   echo "table $t skew stat:"
  psql -U gpadmin -d pil -c "select gp_segment_id,count(*) from $t group by 1;"

done
