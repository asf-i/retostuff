setxkbmap ch &
udiskie --no-notify &
feh --randomize --bg-fill ~/Pictures/Wallpapers/ &
dwmbar.sh &
picom --config /home/Reto/.config/picom/picom.conf &
xrdb -merge ~/.Xresources
exec dwm
