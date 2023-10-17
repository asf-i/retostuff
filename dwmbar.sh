#!/bin/sh
# Script wurde heruntergeladen von https://github.com/IanLeCorbeau/dotfiles/blob/master/.local/bin/statusbar.sh

space="     "

ram() {
	mem=$(free -h | awk '/Mem:/ { print $3 }' | cut -f1 -d 'i')
	echo  "$mem"
}

cpu() {
	read -r cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 0.5
	read -r cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
	echo " $cpu"%
}

volume_alsa() {

	mono=$(amixer -M sget Master | grep Mono: | awk '{ print $2 }')

	if [ -z "$mono" ]; then
		muted=$(amixer -M sget Master | awk 'FNR == 6 { print $7 }' | sed 's/[][]//g')
		vol=$(amixer -M sget Master | awk 'FNR == 6 { print $5 }' | sed 's/[][]//g; s/%//g')
	else
		muted=$(amixer -M sget Master | awk 'FNR == 5 { print $6 }' | sed 's/[][]//g')
		vol=$(amixer -M sget Master | awk 'FNR == 5 { print $4 }' | sed 's/[][]//g; s/%//g')
	fi

	if [ $(pulsemixer --get-mute) == 1 ]; then
		echo " $vol%"
	else
		if [ "$vol" -ge 60 ]; then
			echo " $vol%"
		elif [ "$vol" -ge 20 ]; then
			echo " $vol%"
		elif [ "$vol" -ge 0 ]; then
			echo " $vol%"	
		fi
	fi
}

clock() {
	dte=$(date +"%d.%m.%Y")
	time=$(date +"%H:%M")

	echo " $time$space $dte"
}

battery() {
	cap=$(cat /sys/class/power_supply/BAT0/capacity)

	if [ $cap -gt 90 ]; then
		symbol=""
	elif [ $cap -gt 65 ]; then
		symbol=""
	elif [ $cap -gt 35 ]; then
		symbol=""
	elif [ $cap -gt 10 ]; then
		symbol=""
	else
		symbol=""
	fi

	if [[ $(cat /sys/class/power_supply/BAT0/status) == "Charging" ]]; then
		echo " $cap%"
	else
		echo "$symbol $cap%"
	fi
}

brightness() {
	screenBrightness=$(cat /sys/class/backlight/nvidia_wmi_ec_backlight/brightness)
	echo " $screenBrightness"
}

main() {
	while true; do
		xsetroot -name "$(volume_alsa)$space$(brightness)$space$(cpu)$space$(battery)$space$(clock) "
		sleep 5
	done
}

main
