#!/bin/bash

#Step 1: Creates a temporary scratch directory to store all the intermediate files in
tempMainDir=$(mktemp -d)

#Step 2: Loops over the compressed tar files provided on the command line, 
# extracting the contents of each file we were given

for tarFile in "$@"
do
	#Step 2-1: Get the base name of each log files
	#fileBaseName=$(echo "$tarFile" | perl -pe 's/(\w+)_.*/\1/')
	fileBaseName=$(basename "$tarFile" .tgz)

	#Step 2-2: Make a directory under the tempDir by using its basename
	tempFileBaseDir="$tempMainDir"/"$fileBaseName"
	mkdir -p "$tempFileBaseDir"

	#Step 2-3: Decompress the logs into related directory
	tar -zxf "$tarFile" -C "$tempFileBaseDir"

	#Step 2-4: Process 'process_client_logs.sh', 
	# generate the 'failed_login_data.txt' for each directory
	bin/process_client_logs.sh "$tempFileBaseDir"

done

#Step 3: Process 'create_username_dist.sh', 'create_hours_dist.sh'
# and 'create_country_dist.sh', generate the related html file in tempMainDir

bin/create_username_dist.sh "$tempMainDir"
bin/create_hours_dist.sh "$tempMainDir"
bin/create_country_dist.sh "$tempMainDir"

#Step 4: Assemble the html generated above to one html report by using 'assemble_report.sh'

bin/assemble_report.sh "$tempMainDir"

#Step 5: Move the 'failed_login_summary.html' from tempMainDir to the final target directory
# and clean up the tempMainDir after finish

mv "$tempMainDir"/failed_login_summary.html ./failed_login_summary.html
rm -r "$tempMainDir"

