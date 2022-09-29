#!/bin/bash

: "${BAT_TMP:=/tmp/batterytmp}"
: "${THRESHOLD:=20}"

let bat="$(acpi -b | awk -F, '{print gensub(/^.|.$/,"","g",$2)}')"
if [[ -f "$BAT_TMP" ]]; then
        ((bat > THRESHOLD)) && rm -f "$BAT_TMP"
else
        ((bat <= THRESHOLD)) && {
                dunstify -u critical "Low battery" "  $bat%"
                touch "$BAT_TMP"
        }
fi
