#!/bin/bash
# ====================================
# Name: system-info.sh
# Description: Shows information about system
# Author: Yuri Rodnov
# Usage: ./system-info.sh
# Example: ./system-info.sh
# ====================================


LINES="--------------------"

echo -e "Operational System\n$LINES"
echo -e "Hostname: $(hostname)"
echo -e "Operational system: $(grep PRETTY_NAME /etc/os-release | cut -d= -f2)"


echo -e "\n"
echo -e "Hardware\n$LINES"

echo -e "\n"
echo -e "Network\n$LINES"
