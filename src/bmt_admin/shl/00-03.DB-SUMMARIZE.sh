#!/bin/bash
source ../cmn/env.profile

SHELLFILE=${0}
LOGDIR=../log
LOGFILE=$LOGDIR"/"$SHELLFILE".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`
echo $SHELLFILE":Start Time:"$START_TM1

## please run at segment node
###### query start
psql -U lr_etl -d pil -e > $LOGFILE 2>&1 <<-!
\timing on


SELECT 'pil' dbname, pg_size_pretty(pg_Database_size('pil'));



!
###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`

echo $SHELLFILE'|Start Time         |End Time' >> $LOGFILE
echo $SHELLFILE'|'$START_TM1'|'$END_TM1 >> $LOGFILE

echo $SHELLFILE":End Time  :"$END_TM1


