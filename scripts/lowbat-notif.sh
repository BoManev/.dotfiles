#!/bin/sh

CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)

if [ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -lt 20 ]; then
    /usr/bin/notify-send --expire-time 30000 -u critical "Low Battery" "Capacity: ($CAPACITY%)\n"
fi

if [ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -lt 10 ]; then
    /usr/bin/notify-send -u critical "Low Battery: suspending..."
    sleep 1
    systemctl suspend
fi