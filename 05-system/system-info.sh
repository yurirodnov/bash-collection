#!/bin/bash
# ====================================
# Name: system-info.sh
# Description: Shows information about system
# Author: Yuri Rodnov
# Usage: ./system-info.sh
# Example: ./system-info.sh
# ====================================


LINES="--------------------"

echo $LINES
echo "System"
echo $LINES

echo "Hostname: $(hostname)"
echo "Operational system: $(grep PRETTY_NAME /etc/os-release | cut -d= -f2)"
echo "Distributive code name: $(grep VERSION_CODENAME /etc/os-release | cut -d= -f2)"
echo "Kernel: $(uname -r)"
echo "Architecture: $(lscpu | grep 'Architecture: ' | cut -b 39-)"
echo "Virtualization: "
echo "Uptime: "
echo "Load average: "


echo -e "\n"
echo $LINES
echo "Hardware"
echo $LINES
echo "CPU model name: $(lscpu | grep 'Model name: ' | cut -b 39-)"
echo "CPU units available: $(nproc --all)"



echo -e "\n"
echo $LINES
echo "Network"
echo $LINES

echo -e "\n"
echo $LINES
echo "Users and security"
echo $LINES

echo "Current user: $(whoami)"
echo "Users logged-in: $(who)"

echo -e "\n"
echo $LINES
echo "Another info"
echo $LINES

