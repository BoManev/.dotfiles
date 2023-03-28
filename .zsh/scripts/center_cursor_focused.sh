#!/usr/bin/env zsh
#

focused_window=$(xdotool getwindowfocus -f)
output=$(xdotool getwindowgeometry --shell $focused_window)
eval $output
move_x=$((X / 2))
move_y=$(((WIDTH / 2) + Y))
echo $move_x
echo $move_y
xdotool mousemove --window $focused_window $move_y $move_x
