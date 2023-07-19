#!/bin/bash

# Function to get the system uptime in seconds
get_uptime_seconds() {
  uptime_seconds=$(cut -d " " -f1 /proc/uptime)
  echo "$uptime_seconds"
}

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
UPTIME_SEC=$(get_uptime_seconds)
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

# Output the information
cat <<EOF
HOSTNAME = $HOSTNAME
TIMEZONE = $TIMEZONE
USER = $USER
OS = $OS
DATE = $DATE
UPTIME = $UPTIME
UPTIME_SEC = $UPTIME_SEC seconds
IP = $IP
MASK = $MASK
GATEWAY = $GATEWAY
RAM_TOTAL = $RAM_TOTAL GB
RAM_USED = $RAM_USED GB
RAM_FREE = $RAM_FREE GB
SPACE_ROOT = $SPACE_ROOT MB
SPACE_ROOT_USED = $SPACE_ROOT_USED MB
SPACE_ROOT_FREE = $SPACE_ROOT_FREE MB
EOF

# Ask the user if they want to write the data to a file
read -p "Do you want to save this information to a file? (Y/N): " answer

# If the user answers "Y" or "y", write the data to a file
if [[ "$answer" =~ ^[Yy]$ ]]; then
  current_time=$(date +"%d_%m_%y_%H_%M_%S")
  filename="${current_time}.status"
  cat > "$filename" <<EOF
HOSTNAME = $HOSTNAME
TIMEZONE = $TIMEZONE
USER = $USER
OS = $OS
DATE = $DATE
UPTIME = $UPTIME
UPTIME_SEC = $UPTIME_SEC seconds
IP = $IP
MASK = $MASK
GATEWAY = $GATEWAY
RAM_TOTAL = $RAM_TOTAL GB
RAM_USED = $RAM_USED GB
RAM_FREE = $RAM_FREE GB
SPACE_ROOT = $SPACE_ROOT MB
SPACE_ROOT_USED = $SPACE_ROOT_USED MB
SPACE_ROOT_FREE = $SPACE_ROOT_FREE MB
EOF
  echo "Data has been saved to the file: $filename"
fi
