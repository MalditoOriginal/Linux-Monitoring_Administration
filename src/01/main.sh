#!/bin/bash

# Check if the number of arguments is not equal to 1
if [ $# != 1 ]; then
    echo "There must be one parameter"
# Check if the argument matches a numeric pattern
elif [[ $1 =~ ^[+-]?[0-9]+([.,][0-9])?$ ]]; then
    echo "The parameter must be textual"
# If the argument is neither empty nor numeric, display the entered parameter
else
    echo "Entered parameter: $1"
fi
