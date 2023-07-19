#!/bin/bash

# Check if the script is run with one parameter
if [ $# -ne 1 ]; then
    echo "Usage: $0 <parameter>"
    exit 1
fi

# Check if the parameter is a number
if [[ $1 =~ ^[0-9]+$ ]]; then
    echo "Invalid input: Parameter cannot be a number."
else
    echo "Parameter: $1"
fi
