#!/bin/bash
glava -m radial -d > /dev/null & 
disown
picom --blur-method dual_kawase --blur-strength 4 --experimental-backends &
disown
