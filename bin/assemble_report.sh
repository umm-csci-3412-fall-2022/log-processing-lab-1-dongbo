#!/bin/bash

#Step 1: Merge the three html dists from the input directory
cat "$1"/*_dist.html | bin/wrap_contents.sh /dev/stdin html_components/summary_plots "$1"/failed_login_summary.html 
