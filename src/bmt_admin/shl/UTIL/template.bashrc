# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions

########################################################################
## GREENPLUM SNE DBMS
########################################################################
#source /usr/local/greenplum-db/greenplum_path.sh
#export GPBASEDIR=/usr/local/greenplum-db
#export MASTERBASEDIR=/data/gpdb_master
#export SEGBASEDIR=/data/gpdb_p1
#export MIRBASEDIR=/data/gpdb_m1
#export MASTER_DATA_DIRECTORY=/data/gpdb_master/gpsne-1


########################################################################
## GREENPLUM MNE DBMS
########################################################################
GPHOME=/usr/local/greenplum-db
export GPHOME
MASTER_DATA_DIRECTORY=/data/master/gpseg-1
export MASTER_DATA_DIRECTORY

source $GPHOME/greenplum_path.sh

GPPERFMONHOME=/usr/local/greenplum-cc-web
source $GPPERFMONHOME/gpcc_path.sh

PGDATABASE=pil
export PGDATABASE
