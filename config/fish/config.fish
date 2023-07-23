if status is-interactive
  # Commands to run in interactive sessions can go here
  set fish_greeting
  starship init fish | source
  fish_config theme choose None
  xmodmap -e "keycode  59 = comma semicolon comma semicolon less multiply U2022" && xmodmap -e "keycode  60 = period colon period colon greater division periodcentered" && xmodmap -e "keycode  51 = braceright bracketright ccedilla Ccedilla grave braceright braceright dead_breve"
end
