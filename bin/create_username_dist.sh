#!/bin/bash

#Step 1: Filter the data in failed_login_data.txt 
# by only getting the usernames, put it into a temporary file

tempFile=$(mktemp)
cat "$1"/*/failed_login_data.txt | perl -ne 'print if s/.* \d+ (\S+) \d.*/\1/' > "$tempFile"

#Step 2: Sort tempFile, count username and output 
# username_dist.html with correct format

sort "$tempFile" | uniq -c | perl -ne 'print if s/\D{0,}(\d+) (\S+)/data.addRow([\x27\2\x27, \1])\x3B/' | bin/wrap_contents.sh /dev/stdin html_components/username_dist "$1"/username_dist.html
 
