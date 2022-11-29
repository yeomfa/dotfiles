#!/bin/sh

# CONFIG VARIABLES
icon=""
addIcon=""
data=~/dotfiles/config/rofi/scripts/workspace/data.txt
terminal=kitty
run=nvim

# READ DATA FILE
i=0
declare -a array_lines
while read line; do
  folders[$i]="$line"
((i++))
done < ~/dotfiles/config/rofi/scripts/workspace/data.txt

# FUNCTIONS
existFolder(){
  exist="false"
  for((f=0;f<=$i;f+=1)); do 
    foldertest=$(grep -x "${folders[$f]}" $data)
    if [ "$foldertest" == $folder ]; then
      exist="true"
      break
    fi
  done
  echo $exist
}

showFolders(){
  workspace=$( \
    for((f=1;f<=$i-1;f+=1)); do 
      echo "$icon $(basename ${folders[f]})";
    done | \
    rofi \
    -dmenu \
    -application-fallback-icon "$icon" \
    -i \
    -p "Projects" \
    -theme "~/dotfiles/config/rofi/scripts/workspace/workspace.rasi" \
  )

  if [ "$workspace" ]; then
    workspace=$(echo ${workspace##* })
    echo $workspace
    for((f=0;f<=$i;f+=1)); do 
      path=$(basename "${folders[$f]}")
      if [ $path == $workspace ]; then
        $terminal -e $run "${folders[$f]}"
      fi
    done
  else
    echo "No match"
  fi
}

noFolders(){
  workspace=$( echo "$addIcon Add folders" | \
    rofi -dmenu\
    -i\
    -p "Projects" \
    -theme "~/dotfiles/config/rofi/scripts/workspace/workspaceNF.rasi" \
  )
}

addFolder(){
  if [ $existFolder == "true" ]; then
    echo "$(basename $folder) --> Folder exist. Not added"
  else
    echo $folder >> $data
    echo "$(basename $folder) --> Folder added"
  fi
}

removeFolder(){
  if [ $existFolder == "true" ]; then
    grep -v -x $folder $data > tmpfile && mv tmpfile $data
    echo "$(basename $folder) --> Folder removed"
  else
    echo "$(basename $folder) --> The folder does not exist"
  fi
}

# CHECK FILE
folder=$(pwd)
existFolder=$( existFolder )

# MAIN
if [ "$1" == "add" ]; then
  addFolder 
elif [ "$1" == "rm" ]; then
  removeFolder
elif [ $i -gt 1 ]; then
  showFolders 
else
  noFolders
fi 

