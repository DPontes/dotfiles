#!/bin/bash
# Check if Bluetooth is powered on and a device is connected
if bluetoothctl info | grep -q 'Connected: yes'; then
    echo "󰂯 On"  # Bluetooth connected icon (or your preferred icon)
elif bluetoothctl show | grep -q 'Powered: yes'; then
    echo "󰂲 Off"  # Bluetooth on but not connected icon
fi

