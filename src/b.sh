#!/bin/bash


#while [ true ] ;
#do
#
#psql -c "select 1 from ins_cr_dh_stf_crr limit 1;" -e > logtmp 2>&1
#
#cat logtmp
#cat logtmp >> ping_query.log
#
#sleep 1
#
#
#done


for (( i=0 ; i < 500 ; i++ )) ; 

do echo $i ; 

psql -c "select 1 from ins_cr_dh_stf_crr limit 1;" -e > logtmp 2>&1

cat logtmp
cat logtmp >> ping_query.log

#sleep 1
done;
