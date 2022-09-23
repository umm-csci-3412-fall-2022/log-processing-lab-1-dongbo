#!/bin/bash

#Step 1: Move to the specified directory.
cd "$1" || return

#Step 2: Gather the contents of all the log files in that directory and pipe them
#Step 3: Extracts the appropriate columns from the relevant lines
#Step 4: Removes the minutes and seconds from all the times
#Step 5: Redirect the output to the file
cat var/log/secure* | perl -ne 'print if s/([A-Za-z]+)\W*(\d+ \d+).*Failed password for.* (\S+) from ([\d.]+).*/\1 \2 \3 \4/' > failed_login_data.txt
