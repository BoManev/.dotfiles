#!/bin/bash                                                                                                                                                                                                                                                    
# This script is intended to make switching between laptop and external displays easier when using i3+dmenu                                                                                                                                                                                                                                                                                                                                         
# bindsym $mod+p exec --no-startup-id $config/display.sh                                                                                                                                                                                                       
                                                                                                                                                                                      
                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                               
# This is your default laptop screen, detect by running `xrandr`                                                                                                                                                                                               
INTERNAL_OUTPUT="eDP-1-1"                                                                                                                                                                                                                                       
                                                                                                                                                                                                                                                               
# choices will be displayed in dmenu                                                                                                                                                                                                                           
choices="laptop\ndual\nexternal\nclone"                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                               
# Your choice in dmenu will determine what xrandr command to run                                                                                                                                                                                               
chosen=$(echo -e $choices | dmenu -i -b -fn "MesloLGS NF-13")                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                               
# This is used to determine which external display you have connected
# This may vary between OS. e.g VGA1 instead of VGA-1
if [ `xrandr | grep VGA-1 | grep -c ' connected '` -eq 1 ]; then
        EXTERNAL_OUTPUT="VGA-1"
fi
if [ `xrandr | grep DVI-1 | grep -c ' connected '` -eq 1 ]; then
        EXTERNAL_OUTPUT="DVI-1"
fi
if [ `xrandr | grep HDMI-1 | grep -c ' connected '` -eq 1 ]; then
        EXTERNAL_OUTPUT="HDMI-1"
fi
if [ `xrandr | grep HDMI-2 | grep -c ' connected '` -eq 1 ]; then
        EXTERNAL_OUTPUT="HDMI-2"
fi
if [ `xrandr | grep HDMI-3 | grep -c ' connected '` -eq 1 ]; then
        EXTERNAL_OUTPUT="HDMI-3"
fi
if [ `xrandr | grep DP1 | grep -c ' connected '` -eq 1 ]; then
        EXTERNAL_OUTPUT="DP-1-1"
fi
if [ `xrandr | grep DP-2 | grep -c ' connected '` -eq 1 ]; then
        EXTERNAL_OUTPUT="DP-1-2"
fi
if [ `xrandr | grep DP-3 | grep -c ' connected '` -eq 1 ]; then
        EXTERNAL_OUTPUT="DP-3"
fi
if [ `xrandr | grep DP-1-3 | grep -c ' connected '` -eq 1 ]; then
        EXTERNAL_OUTPUT="DP-1-3"
fi

# xrander will run and turn on the display you want, if you have an option for 3 displays, this will need some modifications
case "$chosen" in
    external) xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --mode 3440x1440 --pos 0x0 --rotate normal --primary ;;
    laptop) xrandr --output $INTERNAL_OUTPUT --auto --primary --output $EXTERNAL_OUTPUT --off ;;
    clone) xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --same-as $INTERNAL_OUTPUT ;;
    dual) xrandr --output $EXTERNAL_OUTPUT --mode 3440x1440 --pos 0x0 --rotate normal --primary --output $INTERNAL_OUTPUT --auto --below $EXTERNAL_OUTPUT ;;
esac