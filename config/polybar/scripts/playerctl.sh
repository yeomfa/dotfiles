#!/usr/bin/sh

playerctlstatus=$(playerctl status 2> /dev/null)

if [[ $playerctlstatus ==  "Stopped" ]]; then
    echo ""
fi
if [[ $playerctlstatus == "Playing" ]]; then
    echo "%{A1:playerctl pause:} %{A}$(playerctl metadata title)"
fi
if [[ $playerctlstatus == "Paused" ]]; then
    echo "%{A1:playerctl play:} %{A}$(playerctl metadata title)"
fi
