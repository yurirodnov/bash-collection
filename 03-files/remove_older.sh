#!/bin/bash
# ====================================
# Name: remove_older.sh
# Description: Delete all files older than a certain date
# Author: Yuri Rodnov
# ====================================


# With find:
# find "$1" -type f -mtime +"$2" -print -exec rm {} \;


# With for loop:

for file in $1/*; do
	if [[ -f "$file" ]]; then
		file_time=$(stat -c %Y "$file" 2>/dev/null)
        	if [[ $? -ne 0 ]]; then
            		echo "Skip $file"
            		continue
        	fi

		current_time=$(date +%s)
		diffrence=$((current_time-file_time))
		days_old=$((diffrence / 86400))

		if [[ $days_old -gt $2 ]]; then
			echo "Remove file $file"
			rm $file
		fi
	fi
done
