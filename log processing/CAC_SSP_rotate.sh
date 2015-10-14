#!/bin/sh
#
# Written by James Pittman - 2009-06-30
#
# Version 1.0.1 - 2009-07-01
#
# This script handles rotating the stored file of CAC_SSP syslogs
# The file called syslog-ng_ssp-cache is created by syslog-ng
# This file is copied to /local/log/incoming/cisco_ios/. by the script /var/log/syslog_relay.sh
# This script is kicked off by /var/log/syslog_relay.sh and may be merged with that script later...

find /local/log/incoming/cisco_ios/ -maxdepth 1 -type f -exec gzip {} \;

# Set value and format for variable CURRENT_DATE to be used to timestamp the files
CURRENT_DATE="$(date +%FT%X)";

# Rename the file with the timestamp - TODO combine this action with the gzip step...
rename .gz _$CURRENT_DATE.log.simcoll1.gz /local/log/incoming/cisco_ios/*

# Move the file to the archive directory
find /local/log/incoming/cisco_ios/ -maxdepth 1 -type f -exec mv {} /local/log/incoming/cisco_ios/archive/. \;

# Correct the permissions for the file
chown lms:lms /local/log/incoming/cisco_ios/archive/*

# Remove all files in archive that are older than 180 days
find /local/log/incoming/cisco_ios/archive/ -maxdepth 1 -mtime +180 -type f -exec rm {} \;

# End the script
exit 0
