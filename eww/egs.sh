#!/bin/env sh
#set -x
echo '<box>'
# with the command subsitition, does the xargs -I {} thing work? it seems like it, tho
# this is a painful oneliner :(
list=$(legendary list-installed --json | jq '.[].title' -r) # | xargs -n1 -p -d "\n" -I {} echo 'button onclick="'$(./app_name.sh {})'">'{}'</button>'
while IFS= read -r line; do
#    echo '<button onclick="legendary launch '$(./app_name.sh "$line")'">'$line'</button>'
    echo '<button onclick="legendary launch '$(/home/legendofmiracles/eww/app_name.sh "$line")'">'$line'</button>'
done <<< "$list"
echo '</box>'
