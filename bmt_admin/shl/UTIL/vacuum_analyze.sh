#!/bin/bash
DBNAME=${1}
#DBNAME="ebay"
VCOMMAND="VACUUM ANALYZE"
SCHEMA=${2}
psql -tc "SELECT '$VCOMMAND' || ' $SCHEMA.' || relname || ';' 
            FROM pg_class a, pg_namespace b
            WHERE a.relnamespace = b.oid AND 
                  b.nspname      = '$SCHEMA' AND
                  a.oid NOT IN (SELECT parchildrelid FROM pg_partition_rule)   AND
                  a.relstorage NOT IN ('x')                                    AND
                  a.relkind='r'" $DBNAME | psql -a $DBNAME
