#!/bin/bash

while [ true ] ;
do

psql -c "select now();" -e > logtmp 2>&1

cat logtmp
cat logtmp >> ping_query.log

sleep 1

done

