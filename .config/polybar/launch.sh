#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

if "$HAS_SECOND_MONITOR" = "true"
then
  export BAR_WIDTH="1600"
else
  export BAR_WIDTH="1920"
fi

# Launch bar1 and bar2
polybar example -r >>/tmp/polybar1.log 2>&1 & disown

echo "Bars launched..."
