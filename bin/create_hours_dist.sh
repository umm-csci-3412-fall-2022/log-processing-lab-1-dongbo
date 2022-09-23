#!/bin/bash

#Step 1: Filter the data in failed_login_data.txt
# by only getting the hours, put it into a temporary file

tempFile=$(mktemp)
cat "$1"/*/failed_login_data.txt | perl -ne 'print if s/.* (\d+) \S+ \d.*/\1/' > "$tempFile"

#Step 2: Sort tempFile, count hours and output
#hours_dist.html with correct format

sort "$tempFile" | uniq -c | perl -ne 'print if s/\D{0,}(\d+) (\d+)/data.addRow([\x27\2\x27, \1])\x3B/' | bin/wrap_contents.sh /dev/stdin html_components/hours_dist "$1"/hours_dist.html
