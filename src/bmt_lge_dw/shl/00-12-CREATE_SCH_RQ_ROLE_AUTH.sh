#!/bin/bash
source ../cmn/env.profile

SHELLFILE=${0}
LOGDIR=../log
LOGFILE=$LOGDIR"/"$SHELLFILE".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`
echo $SHELLFILE":Start Time:"$START_TM1

###### query start
psql -U gpadmin -d lge -e > $LOGFILE 2>&1 <<-!

/* SCHEMA */
--DROP SCHEMA IF EXISTS sn2ro CASCADE;
--CREATE SCHEMA sn2ro;

--DROP SCHEMA IF EXISTS sn2ro_err CASCADE;
--CREATE SCHEMA sn2ro_err;

/* Resource Queue */
DROP RESOURCE QUEUE rq_batch;
DROP RESOURCE QUEUE rq_olap;
DROP RESOURCE QUEUE rq_adhoc;
DROP RESOURCE QUEUE rq_oltp;

CREATE RESOURCE QUEUE rq_batch WITH (ACTIVE_STATEMENTS=30,PRIORITY=MIN);
CREATE RESOURCE QUEUE rq_olap  WITH (ACTIVE_STATEMENTS=100,PRIORITY=MAX);
CREATE RESOURCE QUEUE rq_adhoc WITH (ACTIVE_STATEMENTS=10,PRIORITY=MEDIUM);
CREATE RESOURCE QUEUE rq_oltp  WITH (ACTIVE_STATEMENTS=100,PRIORITY=MAX);

--CREATE RESOURCE QUEUE rq_batch  WITH (ACTIVE_STATEMENTS=30, MAX_COST=100000000000,COST_OVERCOMMIT=FALSE,MIN_COST=100000,PRIORITY=MIN,   MEMORY_LIMIT='4GB');
--CREATE RESOURCE QUEUE rq_olap   WITH (ACTIVE_STATEMENTS=100,MAX_COST=100000000000,COST_OVERCOMMIT=FALSE,MIN_COST=100000,PRIORITY=MAX,   MEMORY_LIMIT='3GB');
--CREATE RESOURCE QUEUE rq_adhoc  WITH (ACTIVE_STATEMENTS=10, MAX_COST=100000000000,COST_OVERCOMMIT=FALSE,MIN_COST=100000,PRIORITY=MEDIUM,MEMORY_LIMIT='3GB');
--CREATE RESOURCE QUEUE rq_oltp   WITH (ACTIVE_STATEMENTS=100,MAX_COST=100000000000,COST_OVERCOMMIT=FALSE,MIN_COST=100000,PRIORITY=MAX,   MEMORY_LIMIT='3GB');

/* Role */
--DROP ROLE IF EXISTS lr_dba, lr_batch, lr_olap, lr_adhoc, lr_oltp;
DROP ROLE IF EXISTS lr_dba;
DROP ROLE IF EXISTS lr_adhoc;
DROP ROLE IF EXISTS lr_batch;
DROP ROLE IF EXISTS lr_olap;
DROP ROLE IF EXISTS lr_oltp;

CREATE ROLE lr_dba   LOGIN ENCRYPTED PASSWORD 'pwd1234' RESOURCE QUEUE pg_default;
CREATE ROLE lr_adhoc LOGIN ENCRYPTED PASSWORD 'pwd1234' RESOURCE QUEUE rq_adhoc;
CREATE ROLE lr_batch LOGIN ENCRYPTED PASSWORD 'pwd1234' RESOURCE QUEUE rq_batch;
CREATE ROLE lr_olap  LOGIN ENCRYPTED PASSWORD 'pwd1234' RESOURCE QUEUE rq_olap;
CREATE ROLE lr_oltp  LOGIN ENCRYPTED PASSWORD 'pwd1234' RESOURCE QUEUE rq_oltp;
                                                  
/* Role Configuration */
--ALTER ROLE lr_dba    SET search_path=sn2ro, public;
--ALTER ROLE lr_adhoc  SET search_path=sn2ro, sn2ro_err, public, pg_catalog;
--ALTER ROLE lr_batch  SET search_path=sn2ro, sn2ro_err, public, pg_catalog;
--ALTER ROLE lr_olap   SET search_path=sn2ro, sn2ro_err, public, pg_catalog;
--ALTER ROLE lr_oltp   SET search_path=sn2ro, sn2ro_err, public, pg_catalog;
--ALTER ROLE gpadmin   SET search_path=sn2ro, sn2ro_err, public, pg_catalog;

/* Grant */
--GRANT ALL ON SCHEMA sn2ro TO lr_dba;
--GRANT ALL ON SCHEMA sn2ro TO lr_adhoc;
--GRANT ALL ON SCHEMA sn2ro TO lr_batch;
--GRANT ALL ON SCHEMA sn2ro TO lr_olap;
--GRANT ALL ON SCHEMA sn2ro TO lr_oltp;

--GRANT ALL ON SCHEMA sn2ro_err TO lr_dba;
--GRANT ALL ON SCHEMA sn2ro_err TO lr_adhoc;
--GRANT ALL ON SCHEMA sn2ro_err TO lr_batch;
--GRANT ALL ON SCHEMA sn2ro_err TO lr_olap;
--GRANT ALL ON SCHEMA sn2ro_err TO lr_oltp;


--GRANT USAGE ON SCHEMA sn2ro, abccmn, abcpdw, abcpdm TO lr_adhoc;

/* HAK */
--ALTER DATABASE lge SET search_path TO sn2ro, sn2ro_err, public, pg_catalog, oracompat;
ALTER DATABASE lge SET search_path = iptcm, iptcp, iptdw, public, pg_catalog, oracompat;

GRANT ALL ON SCHEMA sn2ro_err TO lr_olap,lr_batch,lr_adhoc,lr_oltp ;
GRANT ALL ON SCHEMA public    TO lr_olap,lr_batch,lr_adhoc,lr_oltp ;

ALTER RESOURCE QUEUE rq_batch  WITH (active_statements=20, max_cost=1e+16, min_cost=2e+05, cost_overcommit = true,   priority=medium, memory_limit=-1) ;
ALTER RESOURCE QUEUE rq_olap   WITH (active_statements=6,  max_cost=1e+15, min_cost=2e+07, cost_overcommit = true,   priority=max,    memory_limit=-1) ;
ALTER RESOURCE QUEUE rq_adhoc  WITH (active_statements=5,  max_cost=1e+15, min_cost=2e+07, cost_overcommit = true,   priority=max,    memory_limit=-1) ;

!
###### query end

END_TM1=`date "+%Y-%m-%d %H:%M:%S"`

echo $SHELLFILE'|Start Time         |End Time' >> $LOGFILE
echo $SHELLFILE'|'$START_TM1'|'$END_TM1 >> $LOGFILE
echo $SHELLFILE":End Time  :"$END_TM1

