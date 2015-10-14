#!/bin/bash
#
# estreamer_kickstart
#
# this script exists since I know so little about scripting...
# basically this script is to kick off the estreamer perl client from another script
# once I learn how to make that work directly, I will remove this script 
#
#
cd /local/log/incoming/sourcefire_estreamer/
perl sourcefire_estreamer_retriever.pl

exit 0
#
