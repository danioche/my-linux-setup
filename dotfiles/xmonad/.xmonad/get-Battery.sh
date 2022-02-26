#!/bin/bash

# -- Battery
#
# BatStatus=`cat ~/BAT1/capacity`
# Status=`cat ~/BAT1/status`
#
BatStatus=`acpi | cut -d, -f2 | cut -d% -f1 | xargs`
Status=`acpi | cut -d, -f1 | cut -d: -f2 | xargs`


case $Status in

    "Full")
        PercStatus="$Status <fc=#00cc00></fc>"
    ;;

    "Charging")
        PercStatus="<fc=#ffff00>⚡</fc>"
    ;;

    "Discharging")

        if [ $BatStatus -gt 10 ]; then
            PercStatus="<fc=#ff0000></fc>"
        fi

        if [ $BatStatus -gt 20 ]; then
            PercStatus="<fc=#ff9933></fc>"
        fi

        if [ $BatStatus -gt 40 ]; then
            PercStatus="<fc=#009933></fc>"
        fi

        if [ $BatStatus -gt 60 ]; then
            PercStatus="<fc=#00cc00></fc>"
        fi

        if [ $BatStatus -gt 95 ]; then
            PercStatus="<fc=#00cc00></fc>"
        fi

    ;;

esac


echo "$PercStatus  $BatStatus%"
