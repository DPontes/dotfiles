#!/usr/bin/env bash

# File: tmux/tmux-bluetooth.sh
# Description: Check if Bluetooth is powered on and a device is connected for tmux status line.
# Dependencies: bluetoothctl

set -euo pipefail

# Check for required dependencies
if ! command -v bluetoothctl &> /dev/null; then
    exit 0
fi

# Check if Bluetooth is powered on and a device is connected
if bluetoothctl info 2>/dev/null | grep -q 'Connected: yes'; then
    echo "󰂯 On"  # Bluetooth connected icon
elif bluetoothctl show 2>/dev/null | grep -q 'Powered: yes'; then
    echo "󰂲 Off"  # Bluetooth on but not connected icon
fi

