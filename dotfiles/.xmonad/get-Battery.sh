#!/bin/bash

# -- Battery
#
BatStatus=`cat ~/BAT1/capacity`
Status=`cat ~/BAT1/status`
TimeLeft=`acpi -b | cut -d "," -f3 | cut -d " " -f2`
TimeLeftStr=""

case $Status in

    "Full")
        PercStatus="$Status <fc=#00cc00></fc>"
    ;;

    "Charging")
        PercStatus="<fc=#ffff00>⚡</fc>"
        TimeLeftStr="<fc=#00ff00>$TimeLeft</fc>"
    ;;


    "Discharging")

        if [ $BatStatus -gt 10 ]; then
            PercStatus="<fc=#ff0000></fc>"
            TimeLeftStr="<fc=#ff0000>$TimeLeft</fc>"
        fi

        if [ $BatStatus -gt 20 ]; then
            PercStatus="<fc=#ff9933></fc>"
            TimeLeftStr="<fc=#ff9933>$TimeLeft</fc>"
        fi

        if [ $BatStatus -gt 40 ]; then
            PercStatus="<fc=#009933></fc>"
            TimeLeftStr="<fc=#009933>$TimeLeft</fc>"
        fi

        if [ $BatStatus -gt 60 ]; then
            PercStatus="<fc=#00cc00></fc>"
            TimeLeftStr="<fc=#00cc00>$TimeLeft</fc>"
        fi

        if [ $BatStatus -gt 95 ]; then
            PercStatus="<fc=#00cc00></fc>"
            TimeLeftStr="<fc=#00cc00>$TimeLeft</fc>"
        fi

    ;;

esac


echo "$PercStatus  $BatStatus% $TimeLeftStr"
