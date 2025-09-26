#!/bin/bash
# ====================================
# Name: system-info.sh
# Description: Shows information about system
# Author: Yuri Rodnov
# Usage: ./system-info.sh
# Example: ./system-info.sh
# ====================================


COLOR_START='\033[32m'
COLOR_END='\033[0m'
LINES='-------------------------------------'

MAIN_INTERFACE=$(ip route | grep default | awk '{print $5}')
PCKG_MGR=""
for pm in apt dnf yum pacman zypper apk dpkg rpm; do
	if command -v "$pm" &>/dev/null; then
		if [[ -z "$PCKG_MGR" ]]; then
			PCKG_MGR="$pm"
		else
			PCKG_MGR="$PCKG_MGR, $pm"
		fi
	fi
done

HOSTNAME=$(hostname)
OS=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 2>/dev/null)
DSTR_CODE_NAME=$(grep VERSION_CODENAME /etc/os-release 2>/dev/null | cut -d= -f2)
KERNEL=$(uname -r)
ARCH=$(uname -m)
VIRT=$(systemd-detect-virt)
UPTIME=$(uptime -p 2>/dev/null | cut -b4-)
AVG_LOAD=$(uptime | grep 'load average:' | sed 's/.*: *//' 2>/dev/null)
CPU_MODEL=$(lscpu | grep 'Model name:' | sed 's/.*: *//')
CPU_UNITS=$(nproc)
RAM=$(free -h | awk '/^Mem:/ {print $2,$3,$4 }')
SWAP=$(free -h | awk '/^Swap:/ {print $2,$3,$4}')
DISK_SPACE=$(df -h | awk '$6 == "/" {print $2,$3,$4}')
MAC=$(ip a show "$MAIN_INTERFACE" | awk '/link\/ether/ {print $2}')
EXTERNAL_IP=$(curl -s ifconfig.me 2>/dev/null || echo "Offline")
CURRENT_USER=$(whoami)
USERS_IN=$(who)
SHELL=$("$SHELL" --version | head -1)
TIMEZONE=$(timedatectl | grep 'Time zone:' | awk -F: '{print $2}')

#echo $LINES
echo
echo -e "${COLOR_START}System${COLOR_END}"
echo -e "$COLOR_START$LINES$COLOR_END"

echo -e "${COLOR_START}Hostname:${COLOR_END} ${HOSTNAME:-No data}"
echo -e "${COLOR_START}Operational system:${COLOR_END} ${OS:-No data}"
echo -e "${COLOR_START}Distributive code name:${COLOR_END} ${DSTR_CODE_NAME:-No data}"
echo -e "${COLOR_START}Package manager:${COLOR_END} ${PCKG_MGR:-No data}"
echo -e "${COLOR_START}Kernel:${COLOR_END} ${KERNEL:-No data}"
echo -e "${COLOR_START}Architecture:${COLOR_END} ${ARCH:-No data}"
echo -e "${COLOR_START}Virtualization:${COLOR_END} ${VIRT:-No data}"
echo -e "${COLOR_START}Uptime:${COLOR_END} ${UPTIME:-No data}"
echo -e "${COLOR_START}Average load last 1, 5, 15 min:${COLOR_END} ${AVG_LOAD:-No data}"

echo
#echo $LINES
echo -e "${COLOR_START}Hardware${COLOR_END}"
echo -e "$COLOR_START$LINES$COLOR_END"
echo -e "${COLOR_START}CPU model name:${COLOR_END} ${CPU_MODEL:-No data}"
echo -e "${COLOR_START}CPU units available:${COLOR_END} ${CPU_UNITS:-No data}"
echo -e "${COLOR_START}RAM total/used/free:${COLOR_END} ${RAM:-No data}"
echo -e "${COLOR_START}Swap total/used/free:${COLOR_END} ${SWAP:-No data}"
echo -e "${COLOR_START}Disk space(/) total/used/free:${COLOR_END} ${DISK_SPACE:-No data}"

echo
#echo $LINES
echo -e "${COLOR_START}Network${COLOR_END}"
echo -e "$COLOR_START$LINES$COLOR_END"
echo -e "${COLOR_START}MAC-address:${COLOR_END} ${MAC:-No data}" 
echo -e "${COLOR_START}External IP:${COLOR_END} ${EXTERNAL_IP:-No data}"


echo
#echo $LINES
echo -e "${COLOR_START}Users and security${COLOR_END}"
echo -e "$COLOR_START$LINES$COLOR_END"
echo -e "${COLOR_START}Current user:${COLOR_END} ${CURRENT_USER:-No data}"
echo -e "${COLOR_START}Users logged-in:${COLOR_END} ${USERS_IN:-No data }"

echo
#echo $LINES
echo -e "${COLOR_START}Misc${COLOR_END}"
echo -e "$COLOR_START$LINES$COLOR_END"

echo -e "${COLOR_START}Shell:${COLOR_END} ${SHELL:-No data}"
echo -e "${COLOR_START}Timezone:${COLOR_END} ${TIMEZONE:-No data}"
echo

