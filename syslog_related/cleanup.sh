#!/bin/bash
##################################################################################################
# Written by James Pittman - 2012-05-04
#
# Version 1.1.0 - 2013-12-26
#
# cleanup.sh is a script designed to remove old log files for space considerations; however,
# logs which may be subject to much longer retention cycles are NOT to be managed with this script
# 
#################################################################################################
#
## Remove all Gigamon LOGS in the archive that are older than 200 days
find /local/log/incoming/gigamon/ -maxdepth 4 -mtime +200 -type f -exec rm {} \;
#
## Remove all IBM RACF LOGS in the archive that are older than 200 days
find /local/log/incoming/ibm_racf/archive/ -maxdepth 1 -mtime +200 -type f -exec rm {} \;
#
## Remove all PGP LOGS in the archive that are older than 200 days
find /local/log/incoming/pgp/ -maxdepth 4 -mtime +200 -type f -exec rm {} \;
#
##
# Set value and format for variable of file names to delete 
YESTERDAY="$(date +%d -d "yesterday")"
#echo 'yesterday'
#echo $YESTERDAY
#TWODAYSAGO="$(date +%d -d "2 days ago")"
#echo 'two days ago'
#echo $TWODAYSAGO
#THREEDAYSAGO="$(date +%d -d "3 days ago")"
#echo 'three days ago'
#echo $THREEDAYSAGO
a='messages_for_day-of-month_'
b=$YESTERDAY
#b=$TWODAYSAGO
#b=$THREEDAYSAGO
c='.log'
d=$a$b$c
#echo $d
## Remove all LOGS in the remote archive that are older than 1 days
find /local/log/incoming/remote/ -maxdepth 4 -type f -name $d -exec rm {} \;
#
# End the script
exit 0
###################################################################################################
