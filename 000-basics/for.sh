#!/bin/bash




#for i in 1 2 3 4 5; do
#	echo $(( $i * 2))
#done


ITEMS=/home/yuri/*



for i in $ITEMS; do
	if [[ -d $i ]]; then
	echo "$i"
	fi
done
