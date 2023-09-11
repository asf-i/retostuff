#!/bin/sh
# Script wurde heruntergeladen von https://github.com/IanLeCorbeau/dotfiles/blob/master/.local/bin/statusbar.sh

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
	echo "CPU: $cpu"%
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
		echo "VOL: muted"
	else
		if [ "$vol" -ge 65 ]; then
			echo "VOL: $vol%"
		elif [ "$vol" -ge 40 ]; then
			echo "VOL: $vol%"
		elif [ "$vol" -ge 0 ]; then
			echo "VOL: $vol%"	
		fi
	fi
}

clock() {
	dte=$(date +"%d.%m.%Y")
	time=$(date +"%H:%M")

	echo "$time   $dte"
}

battery() {
	cap=$(cat /sys/class/power_supply/BAT0/capacity)
	
	if [[ $(cat /sys/class/power_supply/BAT0/status) == "Charging" ]]; then
		echo "BAT: $cap% (+)"
	elif [[ $(cat /sys/class/power_supply/BAT0/status) == "Discharging" ]]; then
		echo "BAT: $cap% (-)"
	else
		echo "BAT: $cap%"
	fi
}

brightness() {
	screenBrightness=$(cat /sys/class/backlight/nvidia_wmi_ec_backlight/brightness)
	echo "SCR: $screenBrightness"
}

main() {
	while true; do
		xsetroot -name " $(volume_alsa) // $(brightness) // $(cpu) // $(battery) // $(clock) "
		sleep 5
	done
}

main
