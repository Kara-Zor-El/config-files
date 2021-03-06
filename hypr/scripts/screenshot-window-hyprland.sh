#!/bin/sh

x=0
y=0
w_h="0x0"
window_name="Window"
# generate random number
random_number=$((RANDOM%1000))

## Get window names
window_names=$(hyprctl clients | grep -v "^$" | grep "Window " --color=never)
# get everything after ->
window_names=$(echo "$window_names" | sed 's/^.*-> //')
# remove last : from each line
window_names=$(echo "$window_names" | sed 's/:.*$//')

## Get window position
window_positions=$(hyprctl clients | grep -v "^$" | grep "at: " --color=never)
# get everything after at:
window_positions=$(echo "$window_positions" | sed 's/^.*at: //')

## Get window sizes
window_sizes=$(hyprctl clients | grep -v "^$" | grep "size: " --color=never)
# get everything after size:
window_sizes=$(echo "$window_sizes" | sed 's/^.*size: //')
# replace , with x
window_sizes=$(echo "$window_sizes" | sed 's/,/x/g')

# check how many newlines there are in window_names
newlines=$(echo "$window_names" | wc -l)

# for loop to iterate through each window
# for i in $(seq 1 $newlines); do
#     # get the window name
#     echo "$window_names" | sed -n "$i"p | sed -z 's/\n/ \| /g'
#     # get the window position
#     echo "$window_positions" | sed -n "$i"p | sed -z 's/\n/ \| /g'
#     # get the window size
#     echo "$window_sizes" | sed -n "$i"p
# done

get_selected_window() {
  # use slurp to get a point on the screen
  point=$(~/.config/hypr/scripts/slurp_window.sh)
  point_x=$(echo "$point" | cut -d',' -f1)
  point_y=$(echo "$point" | cut -d',' -f2)
  # compare it to window positions and size to get the window that is selected
  for i in $(seq 1 $newlines); do
    # get the window position
    window_position=$(echo "$window_positions" | sed -n "$i"p)
    window_position_x=$(echo "$window_position" | cut -d',' -f1)
    window_position_y=$(echo "$window_position" | cut -d',' -f2)
    # get the window size
    window_size=$(echo "$window_sizes" | sed -n "$i"p)
    window_size_x=$(echo "$window_size" | cut -d'x' -f1)
    window_size_y=$(echo "$window_size" | cut -d'x' -f2)
    # get the window name
    window_name=$(echo "$window_names" | sed -n "$i"p)
    # check if the point is inside the window
    if [ $point_x -ge $window_position_x ] && [ $point_x -le $(($window_position_x + $window_size_x)) ] && [ $point_y -ge $window_position_y ] && [ $point_y -le $(($window_position_y + $window_size_y)) ]; then
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
  # convert /tmp/hyprland-screenshots/$random_number.png -alpha on -flatten -quality 100% /tmp/hyprland-screenshots/$random_number.final.png
  printf "Screenshot saved to /tmp/hyprland-screenshots/$random_number.final.png\n"
  # copy the screenshot to the clipboard
  wl-copy < /tmp/hyprland-screenshots/$random_number.final.png
  printf "Screenshot copied to clipboard\n"
  # delete the screenshot
  rm /tmp/hyprland-screenshots/$random_number.png
  rm /tmp/hyprland-screenshots/$random_number.final.png
  printf "Screenshots deleted from /tmp/hyprland-screenshots\n"
  notify-send "Screenshot copied to clipboard"
  # convert /tmp/hyprland-screenshot/$random_number.png -bordercolor none -border 5 -background red -alpha background -channel A -blur 0x15 -level 0,0% ./result.png
  # printf "Screenshot taken of $window_name at $x,$y with size $w_h\n"
}

get_selected_window
screenshot_window
