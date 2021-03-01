#!/bin/bash
set -x

if pgrep "ffmpeg" > /dev/null 2>&1; then
	giph --stop
else
	giph -s /tmp/recording.webm && curl -F file=@"/tmp/recording.webm" https://0x0.st | xclip -selection c && notify-send "Copied to clipboard!"
fi
