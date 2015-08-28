#!/bin/bash
##################################################################################################
# Written by James Pittman - 2008-03-17
#
# Version 2.0.5 - 2014-01-22
#
# IBM RACF Type 80 Log Handling script
#
# IBM RACF Type 80 Logs are received via FTP in /home/ftp_local/
# These logs are modified to remove tailing null characters
# Then they are modified to change the delimiter from | to ,
# Then the file is renamed to include the date
# Then the file name is corrected to change : to _
# Then the file is copied to a directory indexed by the new SIEM
# Then the original file is moved to an archive location
# Then the indexed copy and the archived copy are deleted according to a rotation schedule
## Historical comments are in the version in the archive folder /local/script/archive/
#################################################################################################
## Copy the file to the SIEM appliance -this runs first since annotated file name breaks scp
## upon changing to version 4.0, the sftp destination folder changed, I am retaining the old one in case it changes again
##  change directory to where the file is placed by ftp
cd /home/ftp_local/ &&
#
## strip the trailing nulls and create a new file
tr < RACF_Reports.txt -d '\000' > RACF_Reports.log
#
## remove the original file to reduce the subsequent processing steps
find /home/ftp_local/ -type f -name 'RACF_Reports.txt' -exec rm {} \;
#
## grab the file and ship it to enVision
find /home/ftp_local/ -maxdepth 1 -type f -name 'RACF_Reports.log' -exec scp {} nic_sshd@<SIEM_IP>:/RACF_<MainframeIP>/. \;
#
## fix delimiter for Splunk, change | to ,
## this step can be moved upwards once enVision is no longer an active target for the logs
tr '|' ','  < RACF_Reports.log  > RACF_Reports.csv
#
## Set value and format for variable CURRENT_DATE to be used to timestamp the files
## modified from example documentation for difference in linux flavors
CURRENT_DATE="$(date +%FT%R)";
#
## rename the file to include the date for indexing and archiving
find /home/ftp_local/ -name '*.csv' -exec rename '.csv' _$CURRENT_DATE.csv {} \;
#
## rename the file to change colons to underscores
find /home/ftp_local/ -name '*:*' -exec rename ':' '_' {} \;
#
## copy the file to the index_me directory for Splunk
find /home/ftp_local/ -name '*.csv' -maxdepth 1 -type f -exec cp {} /local/log/incoming/ibm_racf/index_this/. \;
#
## Compress the text file in the ftp arrival directory
find /home/ftp_local/ -name '*.csv' -maxdepth 1 -type f -exec gzip {} \; 
#
## Move the file to the incoming directory
find /home/ftp_local/ -name '*.csv.gz' -maxdepth 1 -type f -exec mv {} /local/log/incoming/ibm_racf/temp/. \;
#
## Rename the file with the timestamp - TODO combine this action with the gzip step...
# restating for consistency in script format
#
## Move the file to the archive directory
## Commenting out the archiving until the scp function is verifed as working
find /local/log/incoming/ibm_racf/temp/ -maxdepth 1 -type f -exec mv {} /local/log/incoming/ibm_racf/archive/. \;
#
# Correct the permissions for the file
chown <valid_username>:users /local/log/incoming/ibm_racf/archive/*
#
# Remove yesterday's file in the temp directory 
# modify this to use files older than 4 hours
find /local/log/incoming/ibm_racf/index_this/ -maxdepth 1 -cmin +240 -type f -exec rm {} \;
# Remove all files in archive that are older than 180 days
find /local/log/incoming/ibm_racf/archive/ -maxdepth 1 -mtime +180 -type f -exec rm {} \;
#
# End the script
exit 0
###################################################################################################
