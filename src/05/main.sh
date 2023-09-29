#!/bin/bash

# Get the current time in seconds
time_code=$(date +%s)

# Check if exactly one argument is provided
if [ $# != 1 ]; then
  echo "You must input a directory name"
# Check if the argument does not start with a '/'
elif  [[ ${1: -1} != "/" ]]; then
  echo "The parameter must be end with '/'"
# Check if the provided argument is not a valid directory
elif ! [ -d "$1" ]; then
  echo "The directory does not exist"
else
  # Grant execute permissions to the 'print.sh' script
  chmod +x print.sh
  # Execute the 'print.sh' script with the provided directory argument
  bash ./print.sh "$1"
  # Calculate and display the script execution time
  echo "Script execution time (in seconds) = $(($(date +%s)-time_code))"
fi
