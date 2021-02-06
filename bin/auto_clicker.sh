#!/bin/bash

while :

do
	xdotool mousedown $1
	xdotool mouseup $1
  sleep $2

done
