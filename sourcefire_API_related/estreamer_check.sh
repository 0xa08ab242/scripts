#!/bin/bash

# estreamer_check.sh 
#
# version 1.0.2		2008-03-28
#
# this simple shell script checks if a stated process is running
# original version created by Doug Dalton
# modified to target estreamer process

TEST=`pgrep $1`
if [ ! "$TEST" ]
then
$2 && 
 syslogsend() {
       logger -testreamer -p$syslog estreamer_check.sh detected that sourcefire_estreamer_retriever not running: $dead
}
else
echo "$1 Alive "
fi

exit 0

# Usage:
# estreamer_check.sh

# Example:
# estreamer_check.sh sourcefire /local/log/incoming/sourcefire_estreamer/estreamer_kickstart.sh
#
# or
#
# ./estreamer_check.sh sourcefire 'perl sourcefire_estreamer_retriever.pl'
