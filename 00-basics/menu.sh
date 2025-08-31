#!/bin/bash
# ====================================
# Name: menu.sh
# Description: CLI-menu
# Author: Yuri Rodnov
# ====================================


CAT=$'|\---/|\n| o_o |\n \_^_/'





DOG=$'  /^ ^\\\n / 0 0 \\\n V\ Y /V\n  / - \\\n /    |\nV__) ||'

       
BIRD=$'   \\\\\\\n   (o>\n\\\\\_//)\n \_/_)\n  _|_'




echo "Select what you wanna see: "
echo -e "1 - Cat\n2 - Dog\n3 - Bird"
read -p "> " ANSWER




if [[ "$ANSWER" -eq 1 ]]; then
	echo -e "$CAT"
elif [[ $ANSWER -eq 2 ]]; then
	echo -e "$DOG"
elif [[ $ANSWER -eq 3 ]]; then
	echo -e "$BIRD"
else
	echo "Invalid choise"
fi



