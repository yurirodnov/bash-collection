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


#echo $LINES
echo
echo "System"
echo $LINES

echo "Hostname: ${HOSTNAME:-No data}"
echo "Operational system: ${OS:-No data}"
echo "Distributive code name: ${DSTR_CODE_NAME:-No data}"
echo "Package manager: ${PCKG_MGR:-No data}"
echo "Kernel: ${KERNEL:-No data}"
echo "Architecture: ${ARCH:-No data}"
echo "Virtualization: ${VIRT:-No data}"
echo "Uptime: ${UPTIME:-No data}"
echo "Average load last 1, 5, 15 min: ${AVG_LOAD:-No data}"

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
echo "Misc"
echo $LINES

echo "Shell: $("$SHELL" --version | head -1)"
echo "Timezone: $(timedatectl | grep 'Time zone:' | awk -F: '{print $2}')"
echo

