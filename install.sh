#!/bin/bash

homeFiles="zshrc"
configFiles="bspwm dunst kitty picom polybar rofi starship.toml sxhkd betterlockscreenrc"

# Backup
echo "::: Welcome to installation script"

echo ":: Creating backup of your files..."


echo "Enter the name for the backup folder (will be created in ~/.config):"
read backupName
mkdir ~/.config/$backupName
mkdir ~/.config/$backupName/configFiles ~/.config/$backupName/homeFiles

echo ":: Moving your files to backup folder [~/.config/$backupName]..."

# Backup config
echo "[.config]"
for cfile in $configFiles; do
  if [ -f ~/.config/$cfile ] || [ -d ~/.config/$cfile ]; then
    mv ~/.config/$cfile ~/.config/$backupName/configFiles
    echo "-> $cfile moved to ~/.config/$backupName/configFiles"
  fi
done

echo "done..."

echo "~/"
# Backup home
for hfile in $homeFiles; do
  if [ -f ~/$hfile ] || [ -d ~/$hfile ]; then
    mv ~/$hfile ~/.config/$backupName/homeFiles
    echo "-> $hfile moved to ~/.config/$backupName/homeFiles"
  fi
done

echo "done..."

# Font

echo ":: Installing font"
echo ": Copying font..."
cp -r ~/dotfiles/fonts/JetBrainsMonoNF ~/.fonts
echo "done..."

echo ": Granting permissions..."
chmod +w ~/.fonts/JetBrainsMonoNF/JetBrains\ Mono\ Italic\ Nerd\ Font\ Complete\ Mono.ttf
chmod +w ~/.fonts/JetBrainsMonoNF/JetBrains\ Mono\ Medium\ Italic\ Nerd\ Font\ Complete.ttf
chmod +w ~/.fonts/JetBrainsMonoNF/JetBrains\ Mono\ Medium\ Nerd\ Font\ Complete\ Mono.ttf
chmod +w ~/.fonts/JetBrainsMonoNF/JetBrains\ Mono\ Regular\ Nerd\ Font\ Complete\ Mono.ttf
echo "Installed fonts"

# Symlink's

echo ":: Creating symlink files"

echo "[.config]"
for cfile in $configFiles; do
  ln -s ~/dotfiles/config/$cfile ~/.config/$cfile
  echo "-> Symlink created to $cfile"
done

echo "done..."

echo "[~/]"
for hfile in $homeFiles; do
  ln -s ~/dotfiles/$hfile ~/.$hfile
  echo "-> Symlink created to $hfile"
done

echo "done..."

echo "::: That's all, enjoy!"
