#!/bin/bash


EXTENSION=".sh"
TEMPLATE="template.sh"

read -p "New script name: " NEW_SCRIPT_NAME
read -p "New script directory: " NEW_SCRIPT_DIR

read -p "New script description: " DESCRIPTION
DESCRIPTION=${DESCRIPTION:-"-"}

if [[ "$NEW_SCRIPT_NAME" != *"$EXTENSION" ]]; then
	NEW_SCRIPT_NAME="${NEW_SCRIPT_NAME}${EXTENSION}"
fi

NEW_SCRIPT="$NEW_SCRIPT_DIR/$NEW_SCRIPT_NAME"

sed -e "s/Name: -/Name: $NEW_SCRIPT_NAME/" \
    -e "s/Description: -/Description: $DESCRIPTION/" \
    "$TEMPLATE" > "$NEW_SCRIPT"

chmod +x "$NEW_SCRIPT"


if [[ -f"$NEW_SCRIPT" ]]; then
	echo "Script $NEW_SCRIPT has created"
else
	echo "Something went wrong"
fi

