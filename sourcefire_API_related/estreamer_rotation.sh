#!/bin/bash
#
# Written by James Pittman - 2008-03-28
#
# Version 1.0.10 - 2015-08-14
# 
# Sourcefire eStreamer Retriever
#
# sanitized IP addresses, but otherwise left unchanged from 2008-07-11 version
#
##################################################################################################

# Execute script to verify that sourcefire_estreamer_retriever.pl is still running
/local/log/incoming/sourcefire_estreamer/estreamer_check.sh sourcefire_estreamer_retriever /local/log/incoming/sourcefire_estreamer/estreamer_kickstart.sh
# /local/log/incoming/sourcefire_estreamer/estreamer_check.sh sourcefire_estreamer_retriever 'perl  /local/log/incoming/sourcefire_estreamer/sourcefire_estreamer_retriever.pl'

# Run estreamer_prepender.sh to adjust the output
/local/log/incoming/sourcefire_estreamer/estreamer_prepender.sh 

# Cat the files into a single output file
cat /local/log/incoming/sourcefire_estreamer/SourceFire_eStreamer_* > /local/log/incoming/sourcefire_estreamer/modified_sourcefire_logs.conf

# Run the postprocessing script - we may need to add a shell script to call it...
/local/log/incoming/sourcefire_estreamer/estreamer_postproc.sh

# Move the postproc output file to the SIEM server
scp /local/log/incoming/sourcefire_estreamer/estreamer_postproc.log nic_sshd@X.X.X.X:/nic/3700/Simapp-ES/ftp_files/SOURCEFIRE_Y.Y.Y.Y/.

# Remove the postprocessing output files
rm /local/log/incoming/sourcefire_estreamer/modified_sourcefire_logs.conf
rm /local/log/incoming/sourcefire_estreamer/estreamer_postproc.log

#Archive the originals for a time
# Compress the text file
find /local/log/incoming/sourcefire_estreamer/SourceFire* -maxdepth 1 -type f -exec gzip {} \;

# Rename the file with the collector name - TODO combine this action with the gzip step...
rename .log.gz .log.simcoll1.gz /local/log/incoming/sourcefire_estreamer/*

# Move the file to the transport directory
find /local/log/incoming/sourcefire_estreamer/SourceFire* -maxdepth 1 -type f -exec mv {} /local/log/incoming/sourcefire_estreamer/archive/. \;

# Correct the permissions for the file
chown -R lms:lms /local/log/incoming/sourcefire_estreamer/archive

# Remove all files in archive that are older than 200 days
find /local/log/incoming/sourcefire_estreamer/archive/ -maxdepth 1 -mtime +200 -type f -exec rm {} \;

# End the script
exit 0
