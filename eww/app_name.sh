#!/usr/bin/env bash
#set -x
legendary list-installed --json | jq 'map(if .title == "'"$1"'" then .app_name elif .title == "_" then "_" else "_" end) | map(select(. != "_")) | .[0]' -r
