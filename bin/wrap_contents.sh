#!/bin/bash

# Identify the arugments
fileContents="$1"
headerFooterSpec="$2"
resultingFile="$3"

# Find Header, Footer and Spec files
# Merge into one file, output with the target name
cat "${headerFooterSpec}_header.html" "$fileContents" "${headerFooterSpec}_footer.html" > "$resultingFile"
