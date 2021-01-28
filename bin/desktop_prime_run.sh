#!/bin/env bash
readarray -d '' array < <(find /usr/share/applications/ ~/.local/share/applications/ /usr/local/share/applications/ -maxdepth 1 -mindepth 1 -type f -name '*.desktop' 2> /dev/null -print0)
while IFS= read -r file; do
	sudo sed -i s/Exec=/"Exec=prime-run "/ $file
done <<< $(printf '%s\n' "${array[@]}" | fzf -m)
