#!/bin/bash
#
# @author danioche
# Personal Weather info for Xmobar
#  - Temperature Humidity WindDirection WindHeading WindForce


# We get Weather info iif the info is more than one hour old
# TODO This is lazy...improve this: 23 and 00 hours will have more than 2 hours delayed info
LastInfoHour=`ls -l ~/.xmonad/weather-status.info | cut -d " " -f 9 | cut -d ":" -f 1`
CurrentHour=`date | cut -d " " -f 5 | cut -d ":" -f 1`

HourDiff=$( echo "$CurrentHour - $LastInfoHour" | bc -l)

if [ $HourDiff -gt 1 ]; then

    `weather LEAL > ~/.xmonad/weather-status.info`
fi

# Parsing the Weather info
Temp=`cat ~/.xmonad/weather-status.info | egrep -o "([0-9]+ C)" | cut -d' ' -f 1`
Humidity=`cat ~/.xmonad/weather-status.info | egrep -o "[0-9]+%"`
WinDir=`cat ~/.xmonad/weather-status.info | grep -e Wind | cut -d ' ' -f 7`
WindHeading=`cat ~/.xmonad/weather-status.info | egrep -o "([0-9]+ degrees)" | cut -d' ' -f 1`
WindForce=`cat ~/.xmonad/weather-status.info | egrep -o "[0-9]+ KT"`

TempIco="<fc=#ffd700>☀</fc>"
if [ $Temp -lt 15 ]; then
    TempIco="<fc=#378be5> </fc>"
fi

# Result for Template string in the Bar
echo "$TempIco $TempºC  $Humidity  $WinDir $WindHeading   $WindForce"

# Everything is fine, c u soon!
exit 0
