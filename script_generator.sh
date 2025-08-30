#!/bin/bash


EXTENSION=".sh"
TEMPLATE="template.sh"



read -p "New script name: " NEW_SCRIPT_NAME
read -p "New script directory: " NEW_SCRIPT_DIR

if [[ "$NEW_SCRIPT_NAME" != *"$EXTENSION" ]]; then
	NEW_SCRIPT_NAME="${NEW_SCRIPT_NAME}${EXTENSION}"
fi


NEW_SCRIPT="$NEW_SCRIPT_DIR/$NEW_SCRIPT_NAME"

read -p "Введите описание скрипта (опционально): " DESCRIPTION
DESCRIPTION=${DESCRIPTION:-"Описание отсутствует"}


sed -e "s/Name: -/Name: $NEW_SCRIPT_NAME/" \
    -e "s/Description: -/Description: $DESCRIPTION/" \
    "$TEMPLATE" > "$NEW_SCRIPT"

# Делаем файл исполняемым
chmod +x "$NEW_SCRIPT"


