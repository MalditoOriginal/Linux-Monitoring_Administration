#!/bin/bash

# Check if the script is run with exactly 4 parameters
if [ $# -ne 4 ]; then
    echo "Usage: $0 <bg_color_value_names> <font_color_value_names> <bg_color_values> <font_color_values>"
    echo "Colour designations: (1 - white, 2 - red, 3 - green, 4 - blue, 5 - purple, 6 - black)"
    exit 1
fi

# Check if the font and background colors of one column match
if [ "$1" == "$3" ] || [ "$2" == "$4" ]; then
    echo "Error: The font and background colors of one column must not match."
    exit 1
fi

# ANSI escape codes for colors
# Format: \e[<bg_color_code>;<font_color_code>m
bg_color_names="\e[4$1;3$2m"    # Background color for value names
font_color_names="\e[3$2;4$1m"  # Font color for value names
bg_color_values="\e[4$3;3$4m"   # Background color for values
font_color_values="\e[3$4;4$3m" # Font color for values
reset="\e[0m"                  # Reset color

# Function to convert bytes to GB with three decimal places
bytes_to_gb() {
  local bytes=$1
  local gb=$(echo "scale=3; $bytes / (1024^3)" | bc)
  echo "$gb"
}

# Function to convert bytes to MB with two decimal places
bytes_to_mb() {
  local bytes=$1
  local mb=$(echo "scale=2; $bytes / (1024^2)" | bc)
  echo "$mb"
}

# Get system information
HOSTNAME=$(hostname)
TIMEZONE=$(date +"%Z %:z")
USER=$(whoami)
OS=$(cat /etc/os-release | grep -w "PRETTY_NAME" | cut -d "=" -f2 | tr -d '"')
DATE=$(date +"%d %b %Y %H:%M:%S")
UPTIME=$(uptime -p)
UPTIME_SEC=$(cut -d " " -f1 /proc/uptime)
IP=$(hostname -I | awk '{print $1}')
MASK=$(ip -o -f inet addr show | awk '{print $4}' | head -n 1)
GATEWAY=$(ip route | grep default | awk '{print $3}')

# Get memory information
MEMORY_INFO=$(free -b | grep Mem)
RAM_TOTAL=$(bytes_to_gb $(echo "$MEMORY_INFO" | awk '{print $2}'))
RAM_USED=$(bytes_to_gb $(echo "$MEMORY_INFO" | awk '{print $3}'))
RAM_FREE=$(bytes_to_gb $(echo "$MEMORY_INFO" | awk '{print $4}'))

# Get root partition information
ROOT_INFO=$(df -BM / | tail -1)
SPACE_ROOT=$(bytes_to_mb $(echo "$ROOT_INFO" | awk '{print $2}' | sed 's/M//'))
SPACE_ROOT_USED=$(bytes_to_mb $(echo "$ROOT_INFO" | awk '{print $3}' | sed 's/M//'))
SPACE_ROOT_FREE=$(bytes_to_mb $(echo "$ROOT_INFO" | awk '{print $4}' | sed 's/M//'))

# Output the information with colors
echo -e "${bg_color_names}${font_color_names}HOSTNAME${reset} = ${bg_color_values}${font_color_values}$HOSTNAME${reset}"
echo -e "${bg_color_names}${font_color_names}TIMEZONE${reset} = ${bg_color_values}${font_color_values}$TIMEZONE${reset}"
echo -e "${bg_color_names}${font_color_names}USER${reset} = ${bg_color_values}${font_color_values}$USER${reset}"
echo -e "${bg_color_names}${font_color_names}OS${reset} = ${bg_color_values}${font_color_values}$OS${reset}"
echo -e "${bg_color_names}${font_color_names}DATE${reset} = ${bg_color_values}${font_color_values}$DATE${reset}"
echo -e "${bg_color_names}${font_color_names}UPTIME${reset} = ${bg_color_values}${font_color_values}$UPTIME${reset}"
echo -e "${bg_color_names}${font_color_names}UPTIME_SEC${reset} = ${bg_color_values}${font_color_values}$UPTIME_SEC seconds${reset}"
echo -e "${bg_color_names}${font_color_names}IP${reset} = ${bg_color_values}${font_color_values}$IP${reset}"
echo -e "${bg_color_names}${font_color_names}MASK${reset} = ${bg_color_values}${font_color_values}$MASK${reset}"
echo -e "${bg_color_names}${font_color_names}GATEWAY${reset} = ${bg_color_values}${font_color_values}$GATEWAY${reset}"
echo -e "${bg_color_names}${font_color_names}RAM_TOTAL${reset} = ${bg_color_values}${font_color_values}$RAM_TOTAL GB${reset}"
echo -e "${bg_color_names}${font_color_names}RAM_USED${reset} = ${bg_color_values}${font_color_values}$RAM_USED GB${reset}"
echo -e "${bg_color_names}${font_color_names}RAM_FREE${reset} = ${bg_color_values}${font_color_values}$RAM_FREE GB${reset}"
echo -e "${bg_color_names}${font_color_names}SPACE_ROOT${reset} = ${bg_color_values}${font_color_values}$SPACE_ROOT MB${reset}"
echo -e "${bg_color_names}${font_color_names}SPACE_ROOT_USED${reset} = ${bg_color_values}${font_color_values}$SPACE_ROOT_USED MB${reset}"
echo -e "${bg_color_names}${font_color_names}SPACE_ROOT_FREE${reset} = ${bg_color_values}${font_color_values}$SPACE_ROOT_FREE MB${reset}"
