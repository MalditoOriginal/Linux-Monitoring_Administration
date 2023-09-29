#!/bin/bash

# Grant execute permissions to the specified scripts
chmod +x ./print.sh
chmod +x ./colors.conf
chmod +x ./color_palette.sh

# Source the script 'color_palette.sh'
source ./color_palette.sh
# Source the script 'print.sh'
source ./print.sh
# Source the configuration script 'colors.conf'
source ./colors.conf

# Define a function for printing based on various color settings
print_all(){
    def_clr1=1
    def_clr2=2
    def_clr3=3
    def_clr4=4
    if [ $1 != 0 ]; then
        echo "Arguments are not needed"
    elif [[ -z $2 || -z $3 || -z $4 || -z $5 ]]; then
        clr1=$(color_back $def_clr1)
        clr2=$(color_text $def_clr2)
        clr3=$(color_back $def_clr3)
        clr4=$(color_text $def_clr4)
        print_text $clr1 $clr2 $clr3 $clr4 
        print_default $def_clr1 $def_clr2 $def_clr3 $def_clr4
    elif ! [[ "$2" =~ ^[1-6]$ ]] || ! [[ "$3" =~ ^[1-6]$ ]] || ! [[ "$4" =~ ^[1-6]$ ]] || ! [[ "$5" =~ ^[1-6]$ ]]; then
        echo "You must input numbers in the range of 1 to 6"
    elif [ "$2" == "$3" ] || [ "$4" == "$5" ]; then
        echo "Font and background colors of a single column must not match"
    else
        clr1=$(color_back $2)
        clr2=$(color_text $3)
        clr3=$(color_back $4)
        clr4=$(color_text $5)
        print_text $clr1 $clr2 $clr3 $clr4 
        print_colors $2 $3 $4 $5
    fi
}

# Call the 'print_all' function with appropriate arguments based on user input
print_all $# $column1_background $column1_font_color $column2_background $column2_font_color
