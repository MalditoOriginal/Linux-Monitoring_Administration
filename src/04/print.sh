#!/bin/bash

print_text() {
   echo -e "${clr1}${clr2}HOSTNAME${def_back} = ${clr3}${clr4}$(hostname)${def_back}"
   echo -e "${clr1}${clr2}TIMEZONE${def_back} = ${clr3}${clr4}$(cat /etc/timezone) $(date -u +"%Z") $(date +"%z")${def_back}"
   echo -e "${clr1}${clr2}USER${def_back} = ${clr3}${clr4}$(whoami)${def_back}"
   echo -e "${clr1}${clr2}OS${def_back} = ${clr3}${clr4}$(hostnamectl | grep 'Operating System' | awk '{printf $3, $4, $5}')${def_back}"
   echo -e "${clr1}${clr2}DATE${def_back} = ${clr3}${clr4}$(date "+%d %B %Y %H:%M:%S")${def_back}"
   echo -e "${clr1}${clr2}UPTIME${def_back} = ${clr3}${clr4}$(uptime -p)${def_back}"
   echo -e "${clr1}${clr2}UPTIME_SEC${def_back} = ${clr3}${clr4}$(cat /proc/uptime | awk '{print $1}')${def_back}"
   echo -e "${clr1}${clr2}IP${def_back} = ${clr3}${clr4}$(hostname -I)${def_back}"
   echo -e "${clr1}${clr2}MASK${def_back} = ${clr3}${clr4}$(ifconfig | grep -m1 netmask | awk '{print $4}')${def_back}"
   echo -e "${clr1}${clr2}GATEWAY${def_back} = ${clr3}${clr4}$(ip route | grep default | awk '{print $3}')${def_back}"
   echo -e "${clr1}${clr2}RAM_TOTAL${def_back} = ${clr3}${clr4}$(free -m |  grep "Mem"| awk '{printf "%.3f GB", $2/1024}')${def_back}"
   echo -e "${clr1}${clr2}RAM_USED${def_back} = ${clr3}${clr4}$(free -m |  grep "Mem"| awk '{printf "%.3f GB", $3/1024}')${def_back}"
   echo -e "${clr1}${clr2}RAM_FREE${def_back} = ${clr3}${clr4}$(free -m |  grep "Mem"| awk '{printf "%.3f GB", $4/1024}')${def_back}"
   echo -e "${clr1}${clr2}SPACE_ROOT${def_back} = ${clr3}${clr4}$(df /root/ | grep /dev | awk '{printf "%.2f MB", $2/1024}')${def_back}"
   echo -e "${clr1}${clr2}SPACE_ROOT_USED${def_back} = ${clr3}${clr4}$(df /root/ | grep /dev | awk '{printf "%.2f MB", $3/1024}')${def_back}"
   echo -e "${clr1}${clr2}SPACE_ROOT_FREE${def_back} = ${clr3}${clr4}$(df /root/ | grep /dev | awk '{printf "%.2f MB", $4/1024}')${def_back}"
}