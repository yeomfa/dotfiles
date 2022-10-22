#!/bin/sh
 
lock=""
logout=""
shutdown=""
reboot=""
sleep=""
 
selected_option=$(echo "$lock
$logout
$sleep
$reboot
$shutdown" | rofi -dmenu\
                  -i\
                  -p "Power"\
		  -theme "~/dotfiles/config/rofi/scripts/powermenu/powermenu.rasi")

if [ "$selected_option" == "$lock" ]
then
    betterlockscreen -l dim
elif [ "$selected_option" == "$logout" ]
then
    loginctl terminate-user `whoami`
elif [ "$selected_option" == "$shutdown" ]
then
    systemctl poweroff
elif [ "$selected_option" == "$reboot" ]
then
    systemctl reboot
elif [ "$selected_option" == "$sleep" ]
then
    systemctl suspend
else
    echo "No match"
fi
