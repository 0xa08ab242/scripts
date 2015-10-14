#!/bin/bash
##################################################################################################
# Written by James Pittman - 2012-05-02
#
# Version 1.0.3 - 2012-09-12
#
# Microsoft Exchange Log Collection, Transfer, and Rotation script
#
# Exchange Logs are retrieved from network shares on 3 servers, corbin, hobson, and mendon 
# The files are copied to /local/logs/incoming/exchange/<server name>
# The transferred files are tested to see if they need to be sent to the SIEM
# Only previously unsent files are sent to the SIEM
# The files are then archived into /local/logs/incoming/exchange/<server name>/archive/
# Updated the script to open and close the mount points each time the script is run
# Updated the script to add server monson
#################################################################################################
# The original command line information for connecting to a windows share from linux
#
# mkdir -p /mnt/win
# mount -t smbfs -o username=winntuser,password=mypassword //windowsserver/sharename /mnt/win
# cd /mnt/win
# ls -l
#
## make mount point on linux file system
## this should only be needed if we are rebuilding the script on a new system or if we add an additional source
#mkdir -p /mnt/exchange/corbin
#mkdir -p /mnt/exchange/hobson
#mkdir -p /mnt/exchange/mendon
#mkdir -p /mnt/exchange/monson
#
## mount exchange server log directory to linux mount point
mount -t cifs -o username=<username>,password=<password> //corbin/d\$/Program\ Files/Microsoft/Exchange\ Server/TransportRoles/Logs/MessageTracking/ /mnt/exchange/corbin
mount -t cifs -o username=<username>,password=<password> //hobson/d\$/Program\ Files/Microsoft/Exchange\ Server/TransportRoles/Logs/MessageTracking/ /mnt/exchange/hobson
mount -t cifs -o username=<username>,password=<password> //mendon/d\$/Program\ Files/Microsoft/Exchange\ Server/TransportRoles/Logs/MessageTracking/ /mnt/exchange/mendon
mount -t cifs -o username=<username>,password=<password> //monson/d\$/Program\ Files/Microsoft/Exchange\ Server/TransportRoles/Logs/MessageTracking/ /mnt/exchange/monson
#
## locate files on exchange log directory and copy them to the local file system
## the script is designed to be run just past noon of the day following the day the logs we want were created, this is in response to the way the logs are created 
## if the script fails to run for whatever reason, the catchup process would involve changing the mtime values below [see 'man find' for more information]
find /mnt/exchange/corbin -maxdepth 1 -type f -mtime -1.5 -mtime 0.5 -exec cp {} /local/log/incoming/exchange/corbin/. \;
find /mnt/exchange/hobson -maxdepth 1 -type f -mtime -1.5 -mtime 0.5 -exec cp {} /local/log/incoming/exchange/hobson/. \;
find /mnt/exchange/mendon -maxdepth 1 -type f -mtime -1.5 -mtime 0.5 -exec cp {} /local/log/incoming/exchange/mendon/. \;
find /mnt/exchange/monson -maxdepth 1 -type f -mtime -1.5 -mtime 0.5 -exec cp {} /local/log/incoming/exchange/monson/. \;
#
## unmount the exchange server log directory
umount /mnt/exchange/corbin
umount /mnt/exchange/hobson
umount /mnt/exchange/mendon
umount /mnt/exchange/monson
#
#################################################################################################
# Script information for testing files, sending to the SIEM, and archiving
# updated the file share paths
# locate the files to send and transfer them to the SIEM
find /local/log/incoming/exchange/corbin -maxdepth 1 -type f -exec scp {} nic_sshd@<SIEM_IP>:/EXCHANGE2007_<corbin_IP>/. \;
find /local/log/incoming/exchange/hobson -maxdepth 1 -type f -exec scp {} nic_sshd@1<SIEM_IP>:/EXCHANGE2007_<hobson_IP>/. \;
find /local/log/incoming/exchange/mendon -maxdepth 1 -type f -exec scp {} nic_sshd@<SIEM_IP>:/EXCHANGE2007_<mendon_IP>/. \;
find /local/log/incoming/exchange/monson -maxdepth 1 -type f -exec scp {} nic_sshd@<SIEM_IP>:/EXCHANGE2007_<monson_IP>/. \;
#
###need better use of 'find' directive###
#
# Compress the text files in the local directory
find /local/log/incoming/exchange/corbin -maxdepth 1 -type f -exec gzip {} \; 
find /local/log/incoming/exchange/hobson -maxdepth 1 -type f -exec gzip {} \;
find /local/log/incoming/exchange/mendon -maxdepth 1 -type f -exec gzip {} \;
find /local/log/incoming/exchange/monson -maxdepth 1 -type f -exec gzip {} \;
#
# Move the file to the archive directory
find /local/log/incoming/exchange/corbin/ -maxdepth 1 -type f -exec mv {} /local/log/incoming/exchange/corbin/archive/. \;
find /local/log/incoming/exchange/hobson/ -maxdepth 1 -type f -exec mv {} /local/log/incoming/exchange/hobson/archive/. \;
find /local/log/incoming/exchange/mendon/ -maxdepth 1 -type f -exec mv {} /local/log/incoming/exchange/mendon/archive/. \;
find /local/log/incoming/exchange/monson/ -maxdepth 1 -type f -exec mv {} /local/log/incoming/exchange/monson/archive/. \;
#
# Correct the permissions for the file
chown <valid_username>:users /local/log/incoming/exchange/corbin/*
chown <valid_username>:users /local/log/incoming/exchange/hobson/*
chown <valid_username>:users /local/log/incoming/exchange/mendon/*
chown <valid_username>:users /local/log/incoming/exchange/monson/*
#
# Remove all files in archive that are older than 180 days
find /local/log/incoming/exchange/corbin/archive/ -maxdepth 1 -mtime +180 -type f -exec rm {} \;
find /local/log/incoming/exchange/hobson/archive/ -maxdepth 1 -mtime +180 -type f -exec rm {} \;
find /local/log/incoming/exchange/mendon/archive/ -maxdepth 1 -mtime +180 -type f -exec rm {} \;
find /local/log/incoming/exchange/monson/archive/ -maxdepth 1 -mtime +180 -type f -exec rm {} \;
#
# End the script
exit 0
#################################################################################################
#