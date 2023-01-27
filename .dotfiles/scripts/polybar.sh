# Terminate already running bar instances
polybar-msg cmd quit

polybar mybar

# multi monitor setup
# if type "xrandr" > /dev/null; then
#     for x in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#         MONITOR = $m polybar --reload mainbar-i3 -c ~/.config/polybar/config &