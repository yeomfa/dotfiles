#!/bin/bash
path="$HOME/Images/screenshots/$(date +%s).png"
maim -s "$path"
xclip -selection clipboard -t image/png "$path"
