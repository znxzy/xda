#!/bin/bash

# You can call this script like this:
# $./bright.sh up
# $./bright.sh down
# $./bright.sh toggle

ICON="~/.Scripts/Res/Pics/sun.svg"

# Take the first argument
command=$1
# Shift the arguments so we can process the rest
shift

function get_backlight {
	#light -G|awk -F"." '{print $1}'
	brightnessctl -d 'intel_backlight' g
}

function send_notification {
    backlight=`get_backlight`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "∎" $(($backlight / 25)) | sed 's/[0-9]//g')
    # Send the notification

    dunstify -i $ICON  -t 900 -r 2593 -u normal "   $bar"
}

case $command in
	-|down) 
		bright=`get_backlight`
		if [ $bright -le 5 ];then
            brightnessctl -d 'intel_backlight' s 5%- >/dev/null
        else
            brightnessctl -d 'intel_backlight' s 5%+ > /dev/null
        fi
		    send_notification 
		;;
	+|up) 
		brightnessctl -d 'intel_backlight' s 5%+ >/dev/null
		send_notification 
		;;
	toggle)  
		bright=`brightnessctl -d 'intel_backlight' g`
		if [ $bright -le 1 ];then
		
			light -S 50 > /dev/null
		else 
			light -S 0 > /dev/null
		fi
		;;
esac

