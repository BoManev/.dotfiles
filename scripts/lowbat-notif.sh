#!/bin/sh

CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)

[ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -lt 20 ] && \
/usr/bin/notify-send -u critical "Low Battery" "Capacity: ($CAPACITY%)\n" && \

#paplay ~/some_sound