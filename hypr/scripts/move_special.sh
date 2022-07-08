#!/bin/sh

activewindow=$(hyprctl activewindow | sed '4q;d')
substr="-99"
printf "$activewindow \n"
if [[ $activewindow == *"$substr"* ]]; then
  printf "moving to normal \n"
  hyprctl dispatch movetoworkspace $(hyprctl activewindow | sed '4q;d' | grep -Po '.(?=.{1}$)' --color=never)
  # hyprctl dispatch moveactive exact 20 20
else
  printf "moving to special \n"
  hyprctl dispatch movetoworkspace special
fi
