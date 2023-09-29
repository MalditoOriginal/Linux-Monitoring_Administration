#!/bin/bash

# Grant execute permissions to 'color_palette.sh' and 'print.sh'
chmod +x color_palette.sh
chmod +x print.sh

# Source the script 'color_palette.sh'
source ./color_palette.sh
# Source the script 'print.sh'
source ./print.sh

# Check if the number of arguments is not equal to 4
if [ $# != 4 ]; then
  echo "There must be 4 arguments"
# Check if the arguments are within the range of 1 to 6
elif ! [[ "$1" =~ ^[1-6]$ ]] || ! [[ "$2" =~ ^[1-6]$ ]] || ! [[ "$3" =~ ^[1-6]$ ]] || ! [[ "$4" =~ ^[1-6]$ ]]; then
  echo "You must input numbers in the range of 1 to 6"
# Check if colors for font and background of a single column do not match
elif [ "$1" == "$2" ] || [ "$3" == "$4" ]; then
  echo "Font and background colors of a single column must not match. Restart the script? (y/n)"
  read answer
    if [[ "$answer" = 'y' || "$answer" = 'Y' ]]; then
      echo "Enter 4 numeric arguments"
      read -r one two three four
      if ! [[ -z $one || -z $two || -z $three || -z $four ]]; then
        bash main.sh "$one" "$two" "$three" "$four"
      fi
    fi
else
    # Get background and font colors based on user input
    clr1=$(color_back $1)
    clr2=$(color_text $2)
    clr3=$(color_back $3)
    clr4=$(color_text $4)
    # Print colored text using the selected colors
    print_text $clr1 $clr2 $clr3 $clr4 
fi
