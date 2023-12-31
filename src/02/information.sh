function information {
    echo "HOSTNAME = $(hostname)"
    echo "TIMEZONE = $(cat /etc/timezone) $(date -u +"%Z") $(date +"%z")" 
    echo "USER = $(whoami)"
    echo "OS = $(hostnamectl | grep 'Operating System' | awk '{printf $3, $4, $5}')"
    echo "DATE = $(date "+%d %B %Y %H:%M:%S")"
    echo "UPTIME = $(uptime -p)"
    echo "UPTIME_SEC = $(cat /proc/uptime | awk '{print $1}')"
    echo "IP = $(hostname -I)"
    echo "MASK = $(ifconfig | grep -m1 netmask | awk '{print $4}')"
    echo "GATEWAY = $(ip route | grep default | awk '{print $3}')"
    echo "RAM_TOTAL = $(free -m |  grep "Mem"| awk '{printf "%.3f GB", $2/1024}')"
    echo "RAM_USED = $(free -m |  grep "Mem"| awk '{printf "%.3f GB", $3/1024}')"
    echo "RAM_FREE = $(free -m |  grep "Mem"| awk '{printf "%.3f GB", $4/1024}')"
    echo "SPACE_ROOT = $(df /root/ | grep /dev | awk '{printf "%.2f MB", $2/1024}')"
    echo "SPACE_ROOT_USED = $(df /root/ | grep /dev | awk '{printf "%.2f MB", $3/1024}')"
    echo "SPACE_ROOT_FREE = $(df /root/ | grep /dev | awk '{printf "%.2f MB", $4/1024}')"
}