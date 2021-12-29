#!/bin/bash
#
# @author danioche
# Personal Weather info for Xmobar
#  - Temperature Humidity WindDirection WindHeading WindForce 

# Using weather from http://fungi.yuggoth.org/weather/

# We get Weather info iif the info is more than one hour old

# Latest execution date vs. current 
LastInfoDate=`tail -n 1 ~/.xmonad/get-Weather.history`
SystemDate=`date +"%Y-%m-%d %H:%M:%S"`

HourDiff=$(($(date -d "$SystemDate" '+%s') - $(date -d "$LastInfoDate" '+%s')))

# If we have some time elapsed we will get new info from the sources
if [ $HourDiff -gt 3600 ]; then
    echo " $LastInfoDate, since $HourDiff secs not updated. Getting new data" >> ~/.xmonad/get-Weather.log
    # General Weather
    `weather LEAL > ~/.xmonad/weather-status.info`
    # Sailing conditions (local to Alicante)
    `curl -X POST -d 'point=2079100&name=Alicante' https://bancodatos.puertos.es/TablaAccesoSimplificado/util/get_wanadata.php | html2text > ~/.xmonad/sailing-conditions.info`
fi

# Parsing the Weather info
Temp=`cat ~/.xmonad/weather-status.info | egrep -o "([0-9]+ C)" | cut -d' ' -f 1`
Humidity=`cat ~/.xmonad/weather-status.info | egrep -o "[0-9]+%"`
WinDir=`cat ~/.xmonad/weather-status.info | grep -e Wind | cut -d ' ' -f 7`
WindHeading=`cat ~/.xmonad/weather-status.info | egrep -o "([0-9]+ degrees)" | cut -d' ' -f 1`
WindForce=`cat ~/.xmonad/weather-status.info | egrep -o "[0-9]+ KT" | head -n 1`

TempIco="<fc=#ffd700>☼</fc>"
if [ $Temp -lt 15 ]; then
    TempIco="<fc=#378be5>☁</fc>"
fi
if [ $Temp -lt 10 ]; then
    TempIco="<fc=#378be5>☃</fc>"
fi 

# ~ ~ ~ ~ ~ ~ ~ ~~ ~ ~ ~~ ~ ~ ~~ ~ ~ ~~ ~ ~ ~~ ~ ~ ~~ ~ ~ ~~ ~ ~ ~~ ~ ~ ~~ ~ ~ ~~ ~ ~ ~~ ~ ~ ~ 
# Now Sailing info for wind in Puerto de Alicante, this is forecast, to contrast with current forecast

# Today + Current Hour for sailing predictions
CurrentDate=`date +"%F %H"`  
# Getting forecasted data for current date
WindMS=`cat ~/.xmonad/sailing-conditions.info | grep -e "$CurrentDate" | cut -d\| -f3`
WindDirFore=`cat ~/.xmonad/sailing-conditions.info | grep -e "$CurrentDate" | cut -d\| -f4`
SailCondFore="`cat ~/.xmonad/sailing-conditions.info | grep -e "$CurrentDate" | cut -d\| -f5`m"
WindKntFore=`echo $WindMS*1.94 | bc`

# Result for Template string in the Bar
echo "$TempIco $TempºC  $Humidity  $WinDir $WindHeading f:$WindDirFore  $WindForce f: $WindKntFore ~ $SailCondFore"

# Everything is fine, c u soon!
# Store the current execution
echo `date +"%Y-%m-%d %H:%M:%S"` >> ~/.xmonad/get-Weather.history
# byez
exit 0
