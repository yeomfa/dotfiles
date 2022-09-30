#!/bin/bash

dir=~/dotfiles                    # dotfiles directory
confif=~/.config
files="zshrc"    # list of files/folders to symlink in homedir

ln -s ~/dotfiles/config/polybar ~/.config/polybar 
