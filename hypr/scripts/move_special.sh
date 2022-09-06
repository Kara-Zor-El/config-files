#!/bin/sh

activewindow=$(hyprctl activewindow -j | jq '.workspace.id')
substr="-99"
if [[ $activewindow == $substr ]]; then
  printf "moving to normal \n"
  monitor=$(hyprctl activewindow -j | jq '.monitor')
  workspace=$(hyprctl monitors -j | jq ".[$monitor] .activeWorkspace.id")
  hyprctl dispatch movetoworkspace $workspace
else
  printf "moving to special \n"
  hyprctl dispatch movetoworkspace special
fi
