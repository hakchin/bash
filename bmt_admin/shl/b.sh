#!/bin/bash

. ./03-00-READ_FILE.shl

read_file init_file.txt 5 
echo read_file |readarray -n 0 arraylist

cnt=`echo ${#arraylist[*]}`

echo $cnt

echo $arraylist

