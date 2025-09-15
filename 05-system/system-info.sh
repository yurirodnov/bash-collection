#!/bin/bash
# ====================================
# Name: system-info.sh
# Description: Shows information about system
# Author: Yuri Rodnov
# Usage: ./system-info.sh
# Example: ./system-info.sh
# ====================================


LINES="-------------------------------------"
MAIN_INTERFACE=$(ip route | grep default | awk '{print $5}')


#echo $LINES
echo "System"
echo $LINES

echo "Hostname: $(hostname)"
echo "Operational system: $(grep PRETTY_NAME /etc/os-release | cut -d= -f2)"
echo "Distributive code name: $(grep VERSION_CODENAME /etc/os-release | cut -d= -f2)"
echo "Kernel: $(uname -r)"
echo "Architecture: $(uname -m)"
echo "Virtualization: $(systemd-detect-virt)"
echo "Uptime: $(uptime -p | cut -b4-)"
echo "Load average last 1, 5, 15 min: $(uptime | grep 'load average:' | sed 's/.*: *//') "

echo
#echo $LINES
echo "Hardware"
echo $LINES
echo "CPU model name: $(lscpu | grep 'Model name:' | sed 's/.*: *//')"
echo "CPU units available: $(nproc)"
echo "RAM total/used/free: $(free -h | awk '/^Mem:/ {print $2,$3,$4 }')"
echo "Swap total/used/free: $(free -h | awk '/^Swap:/ {print $2,$3,$4}')"
echo "Disk space(/) total/used/free: $(df -h | awk '$6 == "/" {print $2,$3,$4}')"

echo
#echo $LINES
echo "Network"
echo $LINES
echo "MAC-address: $(ip a show "$MAIN_INTERFACE" | awk '/link\/ether/ {print $2}')" 
echo "External IP: $(curl -s ifconfig.me 2>/dev/null || echo "Offline")"


echo
#echo $LINES
echo "Users and security"
echo $LINES

echo "Current user: $(whoami)"
echo "Users logged-in: $(who)"

echo
#echo $LINES
echo "Another info"
echo $LINES

echo "Timezone: $(timedatectl | grep 'Time zone:' | awk '{print $3}')"

