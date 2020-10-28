#!/usr/bin/env bash
#set -x
legendary list-games --json | jq 'map(if .app_title == "'"$1"'" then .app_name elif .title == "_" then "_" else "_" end) | map(select(. != "_")) | .[0]' -r
