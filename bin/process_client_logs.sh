#!/bin/bash

#Step 1: Move to the specified directory.
cd "$1" || exit
#tarDir=$(pwd)

#Step 2: Gather the contents of all the log files in that directory and pipe them to a command that…
#cat var/log/secure* > merge_logs
#cat var/log/secure* | perl -ne 'print if s/(.*?(?:\d(?=:))).*Failed.* ([a-z]+) from ([\d.]+).*/\1 \2 \3/p' > failed_login_data.txt

cat var/log/secure* | perl -ne 'print if s/([A-Za-z]+)\W*(\d+ \d+).*Failed.* (\S+) from ([\d.]+).*/\1 \2 \3 \4/p' > failed_login_data.txt

#Step 3: Extracts the appropriate columns from the relevant lines, piping them to a command that…
#tempText=$(sed -n -E 's/(.*sshd.* Failed\spassword .*)/\1/p' < merge_logs)

#Step 4: Removes the minutes and seconds from all the times, then…
#Step 5: Redirect the output to the file failed_login_data.txt
#sed -n -E 's/(.*?(?:\d(?=:))).* ([a-z]+) from ([\d.]+).*/\1 \2 \3\n/p' < "$tempText" > failed_login_data.txt
