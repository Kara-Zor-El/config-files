#!/bin/sh

# This script will be a wrapper for the color selector `hyprpicker`

color=$(hyprpicker --no-fancy)

# Copy the color to the clipboard
echo $color | xclip -selection clipboard

# RGB value
rgb=$(printf "rgb(%d, %d, %d)" 0x${color:1:2} 0x${color:3:2} 0x${color:5:2})

# Send a notification with the color, rgb value and a image of the color
convert -size 100x100 xc:$color /tmp/color.png
notify-send -i /tmp/color.png "Hex color $color copied to clipboard" "RGB: $rgb"
rm /tmp/color.png

# # Notification
# notify-send "Hex Color $color copied to clipboard" "$rgb" 
