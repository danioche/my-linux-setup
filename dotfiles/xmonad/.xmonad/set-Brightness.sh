#!/usr/bin/env bash

currBright=`xrandr --verbose | grep -e "Brightness" | cut -d " " -f2`
newBright=$(echo "$currBright - 0.1" | bc -l )

if [ "$1" = "+" ]; then

    newBright=$(echo "$currBright + 0.1" | bc -l )

fi

echo "Setting from $currBright to $newBright..."

`xrandr --output eDP-1 --brightness $newBright`
