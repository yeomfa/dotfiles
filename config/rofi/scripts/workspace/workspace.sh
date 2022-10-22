#!/bin/sh
 
icon=""
data=~/dotfiles/config/rofi/scripts/workspace/data.txt
no_empty="-s $data"

if [ $1 == "add" ]; then
  folder=$(pwd)
  echo $folder >> $data
elif [ $1 == "rm" ]; then
  if [ $no_empty ]; then
    folder=$(pwd)
    grep -v -x $folder $data > tmpfile && mv tmpfile $data
  else
      echo "No folders"
  fi
elif [ $no_empty ]; then
  declare -a array_lines
  i=0
  while read line; do
    array_lineas[$i]="$line"
  ((i++))
  done < ~/dotfiles/config/rofi/scripts/workspace/data.txt

  if [ $i -gt 1 ]; then
    workspace=$(
    for((f=1;f<=$i-1;f+=1)); do echo "$icon $(basename ${array_lineas[f]})"; done | rofi -dmenu\
                      -i\
                      -p "Projects")
          # -theme "~/dotfiles/config/rofi/scripts/workspace/workspace.rasi")

    if [ "$workspace" ]; then
      workspace=$(echo ${workspace##* })
      echo $workspace
      for((f=0;f<=$i;f+=1)); do 
        path=$(basename "${array_lineas[f]}")
        if [ $path == $workspace ]; then
          kitty -e nvim "${array_lineas[f]}"
        fi
      done
    else
      echo "No match"
    fi
  else
    workspace=$( echo "No folders" | rofi -dmenu\
                      -i\
                      -p "Projects")
          # -theme "~/dotfiles/config/rofi/scripts/workspace/workspace.rasi")
  fi
fi 

