#!/bin/dash

STATUS=$(cat /sys/class/power_supply/BAT0/status);
CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity);

if test "$STATUS" = "Charging" || test "$STATUS" = "Unknown" || test "$STATUS" = "Full";
then
	echo "  $CAPACITY%";
elif test "$STATUS" = "Discharging";
then
	if test "$CAPACITY" -gt "80";
	then
		echo "  $CAPACITY%";
	elif test "$CAPACITY" -gt "60" && test "$CAPACITY" -lt "80";
	then
		echo "  $CAPACITY%";
	elif test "$CAPACITY" -gt "40" && test "$CAPACITY" -lt "60";
	then
		echo "  $CAPACITY%";
	elif test $CAPACITY -gt 20 && test $CAPACITY -lt "40";
	then
		echo "  $CAPACITY%";
	elif test $CAPACITY -lt 20 ;
	then
		echo "  $CAPACITY%";
	fi
fi
