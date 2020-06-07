xrandr --output HDMI-0 --mode 1600x900 --output eDP-1-1 --right-of HDMI-0 --mode 1600x900
xset r rate 300 50
/usr/lib/xfce4/notifyd/xfce4-notifyd &
exec bspwm 
