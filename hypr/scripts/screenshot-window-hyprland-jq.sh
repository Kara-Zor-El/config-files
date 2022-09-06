#!/bin/sh

x=0
y=0
w_h="0x0"
window_name="Window"
# generate random number
random_number=$((RANDOM%1000))

## Get window names
window_names=$(hyprctl clients -j | jq '.[] .title')

## Get window position
window_positions=$(hyprctl clients -j | jq '.[] .at[]' | paste -d 'x' - -)

## Get window sizes
window_sizes=$(hyprctl clients -j | jq '.[] .size[]' | paste -d 'x' - -)

## Get workspace window is on
workspaces=$(hyprctl clients -j | jq '.[] .workspace.id')

## Get current workspaces
current_workspaces=$(hyprctl workspaces -j | jq '.[] .id')

# check how many newlines there are in window_names
newlines=$(echo "$window_names" | wc -l)

get_selected_window() {
  # use slurp to get a point on the screen
  point=$(~/.config/hypr/scripts/slurp_window.sh)
  point_x=$(echo "$point" | cut -d',' -f1)
  point_y=$(echo "$point" | cut -d',' -f2)
  # compare it to window positions and size to get the window that is selected
  for i in $(seq 1 $newlines); do
    # get the window position
    window_position=$(echo "$window_positions" | sed -n "$i"p)
    window_position_x=$(echo "$window_position" | cut -d'x' -f1)
    window_position_y=$(echo "$window_position" | cut -d'x' -f2)
    # get the window size
    window_size=$(echo "$window_sizes" | sed -n "$i"p)
    window_size_x=$(echo "$window_size" | cut -d'x' -f1)
    window_size_y=$(echo "$window_size" | cut -d'x' -f2)
    # get the window name
    window_name=$(echo "$window_names" | sed -n "$i"p)
    # check if the point is inside the window
    if [ $point_x -ge $window_position_x ] && [ $point_x -le $(($window_position_x + $window_size_x)) ] && [ $point_y -ge $window_position_y ] && [ $point_y -le $(($window_position_y + $window_size_y)) ]; then
      # check if the window is on any line of the current workspace
      printf "Window: $window_name\n"
      x=$window_position_x
      y=$window_position_y
      w_h="$window_size"
      break
    fi
  done
}

screenshot_window() {
  if [ ! -d /tmp/hyprland-screenshots ]; then
    mkdir /tmp/hyprland-screenshots
  fi
  sleep 0.5
  grim -g "$x,$y $w_h" /tmp/hyprland-screenshots/$random_number.png
  printf "Screenshot saved to /tmp/hyprland-screenshots/$random_number.png\n"
  # wait for a bit to make sure the screenshot is properly taken
  printf "Screenshot taken. Waiting for a bit"
  sleep 0.08
  printf "."
  sleep 0.08
  printf "."
  sleep 0.08
  printf ". Done!\n"
  # round the corners of the screenshot
  convert /tmp/hyprland-screenshots/$random_number.png \( +clone -alpha extract  -draw 'fill black polygon 0,0,0,11 11,0 fill white circle 11,11 11,0' \( +clone -flip \) -compose Multiply -composite  \( +clone -flop \) -compose Multiply -composite \) -alpha off -compose CopyOpacity -composite /tmp/hyprland-screenshots/$random_number.final.png
  mogrify -bordercolor transparent -border 5 /tmp/hyprland-screenshots/$random_number.final.png
  printf "Screenshot saved to /tmp/hyprland-screenshots/$random_number.final.png\n"
  # copy the screenshot to the clipboard
  wl-copy < /tmp/hyprland-screenshots/$random_number.final.png
  printf "Screenshot copied to clipboard\n"
  convert /tmp/hyprland-screenshots/$random_number.final.png -resize 75x75 /tmp/hyprland-screenshots/$random_number.final.small.png
  notify-desktop -i /tmp/hyprland-screenshots/$random_number.final.small.png "Screenshot copied to clipboard"
  # delete the screenshot
  rm /tmp/hyprland-screenshots/$random_number.png
  rm /tmp/hyprland-screenshots/$random_number.final.png
  rm /tmp/hyprland-screenshots/$random_number.final.small.png
  printf "Screenshots deleted from /tmp/hyprland-screenshots\n"
}

get_selected_window
screenshot_window
