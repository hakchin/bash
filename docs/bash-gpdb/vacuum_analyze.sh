#!/bin/bash

if [ -f /home/gpadmin/.bash_profile ];then
. /home/gpadmin/.bash_profile
fi

DBNAME="crmmart"
DATE="/bin/date"
ECHO="/bin/echo"
LOGFILE="/data/dbalog/vacuumcat/vacuum_analyze_${DBNAME}_`date '+%Y-%m-%d'`.log"

$ECHO "  CATALOG TABLE VACUUM ANALYZE started at " > $LOGFILE
$DATE >> $LOGFILE 

VCOMMAND="VACUUM ANALYZE"
psql -tc "select '$VCOMMAND' || ' pg_catalog.' || relname || ';' from pg_class a,pg_namespace b where a.relnamespace=b.oid and b.nspname= 'pg_catalog' and a.relkind='r'" $DBNAME | psql -a $DBNAME  >> $LOGFILE

$ECHO "..............................." >> $LOGFILE 
$ECHO "  CATALOG TABLE VACUUM ANALYZE Completed at" >> $LOGFILE
$DATE >> $LOGFILE 


DBNAME="crpmart"
LOGFILE="/data/dbalog/vacuumcat/vacuum_analyze_${DBNAME}_`date '+%Y-%m-%d'`.log"

$ECHO "  CATALOG TABLE VACUUM ANALYZE started at " > $LOGFILE
$DATE >> $LOGFILE

VCOMMAND="VACUUM ANALYZE"
psql -tc "select '$VCOMMAND' || ' pg_catalog.' || relname || ';' from pg_class a,pg_namespace b where a.relnamespace=b.oid and b.nspname= 'pg_catalog' and a.relkind='r'" $DBNAME | psql -a $DBNAME  >> $LOGFILE

$ECHO "..............................." >> $LOGFILE
$ECHO "  CATALOG TABLE VACUUM ANALYZE Completed at" >> $LOGFILE
$DATE >> $LOGFILE
