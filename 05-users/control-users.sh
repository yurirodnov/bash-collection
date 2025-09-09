#!/bin/bash
# ====================================
# Name: control-users.sh
# Description: Creates users from file list or remove
# Author: Yuri Rodnov
# Usage: ./control-users.sh <action> <file> [group]
# 	 action: create | remove
# 	 file: path to file with users list
# 	 group: if creates
# Example:  ./control-users.sh create new_users.txt admin
#           ./control-users.sh remove old_users.txt
# ====================================


ACTION=$1
FILE=$2
GROUP=$3



if [[ -z "$ACTION" || -z "$FILE" ]]; then
	echo "Use it right: ./control-users.sh <action> <file> [group]" >&2
	exit 1
fi

if [[ ! -f "$FILE" ]]; then
	echo "File $FILE does not exist" >&2
	exit 1
fi


if [[ $ACTION == "create" ]]; then
	while IFS= read -r user; do
		[[ -z $user ]] && continue

		if id "$user" &>/dev/null; then
			echo "User $user already exists"
			continue
		fi

		if [[ -n "$GROUP" ]]; then
		   	sudo useradd -m -s /bin/bash "$user" -G "$GROUP"
			echo "$user successfully created"
		else
			sudo useradd -m -s /bin/bash "$user"
			echo "$user successfully created"

		fi

		echo "$user:Qwerty123!" | sudo chpasswd
		sudo passwd -e "$user"
	done < "$FILE"

elif [[ $ACTION == "remove" ]]; then
	while IFS= read -r user; do
		[[ -z $user ]] && continue

		if !id "$user" &>/dev/null; then
			echo "User $user doesn't exist" >&2
			continue
		else
			sudo userdel -r "$user"
			echo "$user was successfully removed"
		fi
	done < "$FILE"
else
	echo "Action has to be 'create' or 'remove'"
	exit 1
fi


