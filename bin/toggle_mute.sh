#!/bin/bash
sources=$(pamixer --list-sources | /bin/grep -v monitor | /bin/grep -v Sources | cut -d " " -f 1 ) 

while IFS= read -r line; do
	case $(pamixer --get-volume-human --source $line) in
		muted)
			mplayer ~/unmuted.mp3 &
			;;
		*)
			mplayer ~/muted.mp3 &
			;;
	esac
done <<< "$sources"

echo $sources | xargs -I {} pamixer --source {} -t
