#!/bin/bash

#Step 1: Filter the data in failed_login_data.txt
# by only getting the IP address

tempFile=$(mktemp)
cat "$1"/*/failed_login_data.txt | perl -ne 'print if s/.* ([\d.]+$)/\1/' > "$tempFile"

#Step 2: Join the tempFile with contury_IP_map.txt, then count the country code
# and output country_dist.html with correct format

sort "$tempFile" | join /dev/stdin etc/country_IP_map.txt | perl -ne 'print if s/.* ([A-Z]+)/\1/' | sort | uniq -c | perl -ne 'print if s/.*(\d+) (\w+)/data.addRow([\x27\2\x27, \1])\x3B/' | bin/wrap_contents.sh /dev/stdin html_components/country_dist "$1"/country_dist.html
