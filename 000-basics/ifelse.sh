#!/bin/bash

MIN_AGE=18

read -p "Type your age, please: " age
if [ "$age" -lt "$MIN_AGE" ]; then
echo "Fuck you, kid!"
else
echo "You are welcome!"
fi

