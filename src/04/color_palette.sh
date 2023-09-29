#!/bin/bash

white_text='\033[97m'
red_text='\033[31m'
green_text='\033[32m'
blue_text='\033[96m'
purple_text='\033[35m'
black_text='\033[30m'

white_back='\033[107m'
red_back='\033[41m'
green_back='\033[42m'
blue_back='\033[106m'
purple_back='\033[45m'
black_back='\033[40m'

def_back='\033[0m'

color_text() {
    case $1 in
        1) echo "$white_text";;
        2) echo "$red_text";;
        3) echo "$green_text";;
        4) echo "$blue_text";;
        5) echo "$purple_text";;
        6) echo "$black_text";;
    esac
}

color_back() {
    case $1 in
        1) echo "$white_back";;
        2) echo "$red_back";;
        3) echo "$green_back";;
        4) echo "$blue_back";;
        5) echo "$purple_back";;
        6) echo "$black_back";;
    esac
}

name() {
    case $1 in
        1) echo "white";;
        2) echo "red";;
        3) echo "green";;
        4) echo "blue";;
        5) echo "purple";;
        6) echo "black";;
    esac
}


print_colors() {
    printf "\nColumn 1 background = $(echo -n "$1") ($(name $1))\n"
    printf "Column 1 font color = $(echo -n "$2") ($(name $2))\n"
    printf "Column 2 background = $(echo -n "$3") ($(name $3))\n"
    printf "Column 2 font color = $(echo -n "$4") ($(name $4))\n"
}

print_default() {
    printf "\nColumn 1 background = default ($(name $1))\n"
    printf "Column 1 font color = default ($(name $2))\n"
    printf "Column 2 background = default ($(name $3))\n"
    printf "Column 2 font color = default ($(name $4))\n"
}