#!/bin/bash
source ../cmn/env.profile

SHELLFILE=${0}
LOGDIR=../log
LOGFILE=$LOGDIR"/"$SHELLFILE".log"

START_TM1=`date "+%Y-%m-%d %H:%M:%S"`
echo $SHELLFILE":Start Time:"$START_TM1

###### query start
psql -U gpadmin -d eland -e > $LOGFILE 2>&1 <<-!

/* SCHEMA */
--DROP SCHEMA IF EXISTS eland CASCADE;
--CREATE SCHEMA eland;

--DROP SCHEMA IF EXISTS eland_err CASCADE;
--CREATE SCHEMA eland_err;

/* Resource Queue */
DROP RESOURCE QUEUE rq_batch;
DROP RESOURCE QUEUE rq_olap;
DROP RESOURCE QUEUE rq_adhoc;
DROP RESOURCE QUEUE rq_oltp;

CREATE RESOURCE QUEUE rq_batch WITH (ACTIVE_STATEMENTS=30,PRIORITY=MIN);
CREATE RESOURCE QUEUE rq_olap  WITH (ACTIVE_STATEMENTS=100,PRIORITY=MAX);
CREATE RESOURCE QUEUE rq_adhoc WITH (ACTIVE_STATEMENTS=10,PRIORITY=MEDIUM);
CREATE RESOURCE QUEUE rq_oltp  WITH (ACTIVE_STATEMENTS=100,PRIORITY=MAX);

CREATE RESOURCE QUEUE rq_batch  WITH (ACTIVE_STATEMENTS=12, MAX_COST=1e+40,       min_cost=2e+05, COST_OVERCOMMIT=true, PRIORITY=max,   MEMORY_LIMIT=-1);
CREATE RESOURCE QUEUE rq_olap   WITH (ACTIVE_STATEMENTS=100,MAX_COST=100000000000,min_cost=2e+05, COST_OVERCOMMIT=FALSE,PRIORITY=MAX,   MEMORY_LIMIT='3GB');
CREATE RESOURCE QUEUE rq_adhoc  WITH (ACTIVE_STATEMENTS=10, MAX_COST=100000000000,min_cost=2e+05, COST_OVERCOMMIT=FALSE,PRIORITY=MEDIUM,MEMORY_LIMIT='3GB');
CREATE RESOURCE QUEUE rq_oltp   WITH (ACTIVE_STATEMENTS=100,MAX_COST=100000000000,min_cost=2e+05, COST_OVERCOMMIT=FALSE,PRIORITY=MAX,   MEMORY_LIMIT='3GB');





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
--ALTER ROLE lr_dba    SET search_path=eland, public;
ALTER ROLE lr_adhoc  SET search_path=eland, eland_err, public, pg_catalog, information_schema, oracompat;
ALTER ROLE lr_batch  SET search_path=eland, eland_err, public, pg_catalog, information_schema, oracompat;
ALTER ROLE lr_olap   SET search_path=eland, eland_err, public, pg_catalog, information_schema, oracompat;
ALTER ROLE lr_oltp   SET search_path=eland, eland_err, public, pg_catalog, information_schema, oracompat;
ALTER ROLE gpadmin   SET search_path=eland, eland_err, public, pg_catalog, information_schema, oracompat;

/* Grant */
GRANT ALL ON SCHEMA eland TO lr_dba;
GRANT ALL ON SCHEMA eland TO lr_adhoc;
GRANT ALL ON SCHEMA eland TO lr_batch;
GRANT ALL ON SCHEMA eland TO lr_olap;
GRANT ALL ON SCHEMA eland TO lr_oltp;

GRANT ALL ON SCHEMA eland_err TO lr_dba;
GRANT ALL ON SCHEMA eland_err TO lr_adhoc;
GRANT ALL ON SCHEMA eland_err TO lr_batch;
GRANT ALL ON SCHEMA eland_err TO lr_olap;
GRANT ALL ON SCHEMA eland_err TO lr_oltp;


--GRANT USAGE ON SCHEMA eland, abccmn, abcpdw, abcpdm TO lr_adhoc;

/* HAK */
--ALTER DATABASE eland SET search_path TO eland, eland_err, public, pg_catalog, information_schema, oracompat;
ALTER DATABASE eland SET search_path = eland, eland_err, public, pg_catalog, information_schema, oracompat;

GRANT ALL ON SCHEMA eland     TO lr_olap,lr_batch,lr_adhoc,lr_oltp ;
GRANT ALL ON SCHEMA eland_err TO lr_olap,lr_batch,lr_adhoc,lr_oltp ;
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

