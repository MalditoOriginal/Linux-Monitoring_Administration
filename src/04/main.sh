#!/bin/bash

# Default color scheme
default_column1_bg=6   # Black
default_column1_font=7 # White
default_column2_bg=1   # Red
default_column2_font=4 # Blue

# Check if the configuration file exists
config_file="config.txt"
if [ ! -f "$config_file" ]; then
    echo "Error: Configuration file '$config_file' not found."
    exit 1
fi

# Read the configuration values from the file and set default values if not provided
source "$config_file"

column1_bg=${column1_background:-$default_column1_bg}
column1_font=${column1_font_color:-$default_column1_font}
column2_bg=${column2_background:-$default_column2_bg}
column2_font=${column2_font_color:-$default_column2_font}

# ANSI escape codes for colors
bg_color_names="\e[4$column1_bg;3$column1_fontm"    # Background color for value names
font_color_names="\e[3$column1_font;4$column1_bgm"  # Font color for value names
bg_color_values="\e[4$column2_bg;3$column2_fontm"   # Background color for values
font_color_values="\e[3$column2_font;4$column2_bgm" # Font color for values
reset="\e[0m"                                      # Reset color

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

# Get system information (same as Part 3)
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

# Get memory information (same as Part 3)
MEMORY_INFO=$(free -b | grep Mem)
RAM_TOTAL=$(bytes_to_gb $(echo "$MEMORY_INFO" | awk '{print $2}'))
RAM_USED=$(bytes_to_gb $(echo "$MEMORY_INFO" | awk '{print $3}'))
RAM_FREE=$(bytes_to_gb $(echo "$MEMORY_INFO" | awk '{print $4}'))

# Get root partition information (same as Part 3)
ROOT_INFO=$(df -BM / | tail -1)
SPACE_ROOT=$(bytes_to_mb $(echo "$ROOT_INFO" | awk '{print $2}' | sed 's/M//'))
SPACE_ROOT_USED=$(bytes_to_mb $(echo "$ROOT_INFO" | awk '{print $3}' | sed 's/M//'))
SPACE_ROOT_FREE=$(bytes_to_mb $(echo "$ROOT_INFO" | awk '{print $4}' | sed 's/M//'))

# Output the system information with the color scheme
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

# Output the color scheme
echo -e "\nColumn 1 background = $column1_bg $(tput setaf $column1_bg)($(tput sgr0)$(tput setab $column1_bg)color$(tput sgr0)$(tput setaf $column1_bg))"
echo -e "Column 1 font color = $column1_font $(tput setaf $column1_font)($(tput sgr0)$(tput setab $column1_font)color$(tput sgr0)$(tput setaf $column1_font))"
echo -e "Column 2 background = $column2_bg $(tput setaf $column2_bg)($(tput sgr0)$(tput setab $column2_bg)color$(tput sgr0)$(tput setaf $column2_bg))"
echo -e "Column 2 font color = $column2_font $(tput setaf $column2_font)($(tput sgr0)$(tput setab $column2_font)color$(tput sgr0)$(tput setaf $column2_font))\n"
