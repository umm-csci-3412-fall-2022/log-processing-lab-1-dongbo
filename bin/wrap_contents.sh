#!/bin/bash

# From Pre-Lab 1 by Dongting Cai
# CSCI 3412, Fall 2022

# Identify the arugments
fileContents="$1"
headerFooterSpec="$2"
resultingFile="$3"

# Find Header, Footer and Spec files
# Merge into one file, output with the target name
cat "${headerFooterSpec}_header.html" "$fileContents" "${headerFooterSpec}_footer.html" > "$resultingFile"
