#!/usr/bin/env bash

# File: tools/check-connection.sh
# Description: Prints a nerd-font icon for the current network connection type.
# Dependencies: nmcli

set -euo pipefail

# Check for required dependencies
if ! command -v nmcli &> /dev/null; then
    echo "󰖪 no nmcli"
    exit 0
fi

ethernet=false
wifi=false

while IFS=: read -r _ type state; do
    case "$state" in
        connected)
            case "$type" in
                ethernet) ethernet=true ;;
                wifi)     wifi=true ;;
            esac
            ;;
    esac
done < <(nmcli -t -f DEVICE,TYPE,STATE device status 2>/dev/null)

if $ethernet; then
    echo "󰈀 on"
elif $wifi; then
    echo "󰖩 on"
else
    echo "󰖪 off"
fi
