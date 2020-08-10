#!/bin/bash
case $1 in
	"restart")
		# Terminate already running picom instances
		killall -q picom

		# Wait until the processes have been shut down
		while pgrep -u $UID -x picom >/dev/null; do sleep 1; done

		# Launch picom, using default config location ~/.config/picom.conf
		picom &

		echo "picom launched...";;
	
	"stop")
		# Terminate all picom instances
		killall -q picom
		echo "picom stopped...";;
	esac
