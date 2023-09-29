#!/bin/bash

# Executable permission for 'information.sh'
chmod +x information.sh

# Source the script 'information.sh'
source ./information.sh

# Check if no command line arguments are provided
if [ $# == 0 ]; then
   # Call the 'information' function from the sourced script
   information

    echo "Write data to file? [Y/N]"
    read answer
    
    if [[ "$answer" = 'y' || "$answer" = 'Y' ]];
    then
            # Generate a timestamp
            date=$(date +"%d_%m_%Y_%H_%M_%S")
            # Redirect the output of 'information' function to a file with the timestamp as its name
            information > "${date}.txt"
            echo "Data has been recorded"
    fi
else 
  echo "The script is executed without parameters"
fi
