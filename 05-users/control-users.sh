#!/bin/bash
# ====================================
# Name: control-users.sh
# Description: Creates users from file list or remove
# Author: Yuri Rodnov
# Usage: ./control-users.sh <action> <file> <group>
# 	 action: create | remove
# 	 file: path to file with users list
# 	 group: if creates
# Example:  ./control-users.sh create new_users.txt admin
#           ./control-users.sh remove old_users.txt
# ====================================


ACTION=$1
FILE=$2
GROUP=$3





