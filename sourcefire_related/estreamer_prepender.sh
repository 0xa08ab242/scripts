#!/bin/bash
#
# estreamer_prepender.sh
#
# Prepend each line with estreamer (and create a backup file)
find /local/log/incoming/sourcefire_estreamer/SourceFire* -maxdepth 1 -type f -exec perl -pi.bak -e '$_="estreamer,$_"' {} \;

# Remove the backup file created in the previous step
find /local/log/incoming/sourcefire_estreamer/SourceFire*.bak -maxdepth 1 -type f -exec rm {} \;

exit 0
