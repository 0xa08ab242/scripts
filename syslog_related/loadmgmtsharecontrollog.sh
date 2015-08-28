#!/bin/bash
##################################################################################################
# Written by James Pittman - 2012-08-27
#
# Version 1.0.2 - 2012-10-15
#
# Aclara TNS 
# Load Management Share Control Logs 
# Collection, Transfer, and Rotation script
#
# Logs are retrieved from network share on server alton
# The files will be copied from \\alton\ipc\security\LMSchedSvc.LOG
# The files are then archived into /local/logs/incoming/load_control/archive/
# Updated the script to open and close the mount points each time the script is run
# Minor clean up of comments
#################################################################################################
# The original command line information for connecting to a windows share from Linux
#
# mkdir -p /mnt/win
# mount -t smbfs -o username=winntuser,password=mypassword //windowsserver/sharename /mnt/win
# cd /mnt/win
# ls -l
#
## make mount point on linux file system
## this should only be needed if we are rebuilding the script on a new system or if we add an additional source
#mkdir -p /mnt/load_control/alton
#
## mount target server log directory to linux mount point
mount -t cifs -o username=<username>,password=<password> //alton/ipc/security/ /mnt/load_control/alton
#
# Set value and format for variable CURRENT_DATE to be used to timestamp the files
CURRENT_DATE="$(date +%FT%R)";
#
## locate files on load control log directory and copy them to the local file system
# Move the file to the incoming directory
find /mnt/load_control/alton/ -maxdepth 1 -type f -exec cp {} /local/log/incoming/load_control/temp/. \;
#
## unmount the exchange server log directory
umount /mnt/load_control/alton
#################################################################################################
##
# Rename the file with the timestamp - TODO combine this action with the gzip step...
find /local/log/incoming/load_control/temp/ -name '*.LOG' -exec rename '.LOG' _$CURRENT_DATE.log {} \;
## commented out sending logs to SIEM for now - will research adding this in later
#find /local/log/incoming/load_control/ -maxdepth 1 -type f -exec scp {} nic_sshd@<SIEM_IP>:/LOAD_CONTROL_<log_source_IP>/. \;
# Fix the colon filename issue by running the following command twice, once for each colon in the name
find /local/log/incoming/load_control/ -name '*:*' -exec rename ':' '_' {} \;
## second run of colon removal should not be needed with modified rename format
#find /local/log/incoming/load_control/ -name '*:*' -exec rename ':' '_' {} \;
#
# Move the file to the archive directory
find /local/log/incoming/load_control/temp/ -maxdepth 1 -type f -exec mv {} /local/log/incoming/load_control/archive/. \;
#################################################################################################
# Correct the permissions for the file
chown <valid_username>:users /local/log/incoming/load_control/*
#
# End the script
exit 0
#################################################################################################
#
