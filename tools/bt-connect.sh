#!/bin/bash

# Bluetooth device connect/disconnect script
# Usage: ./bt-toggle.sh [--disconnect] "Device Name"

DISCONNECT_FLAG=false

# Parse arguments
if [ "$1" = "--disconnect" ]; then
    DISCONNECT_FLAG=true
    shift
fi

if [ -z "$1" ]; then
    echo "Error: No device name provided"
    echo "Usage: $0 [--disconnect] \"Device Name\""
    echo ""
    echo "Available devices:"
    bluetoothctl devices
    exit 1
fi

DEVICE_NAME="$1"

# Get the MAC address for the device name
MAC_ADDRESS=$(bluetoothctl devices | grep -i "$DEVICE_NAME" | awk '{print $2}')

if [ -z "$MAC_ADDRESS" ]; then
    echo "Error: Device '$DEVICE_NAME' not found"
    echo ""
    echo "Available devices:"
    bluetoothctl devices
    exit 1
fi

echo "Found device: $DEVICE_NAME ($MAC_ADDRESS)"

# Check if device is currently connected
IS_CONNECTED=$(bluetoothctl info "$MAC_ADDRESS" | grep "Connected: yes")

# Spinner helper
show_spinner() {
    local -r sp='/-\|'
    local -r timeout=$1
    local -r check_cmd=$2
    local -r success_msg=$3
    local -r fail_msg=$4
    
    for i in $(seq 1 $((timeout * 4))); do
        printf "\b${sp:i%4:1}"
        if eval "$check_cmd"; then
            printf "\b \n"
            echo "✓ $success_msg"
            exit 0
        fi
        sleep 0.25
    done
    
    printf "\b \n"
    echo "✗ $fail_msg"
    exit 1
}

if [ "$DISCONNECT_FLAG" = true ]; then
    # Explicit disconnect requested
    if [ -z "$IS_CONNECTED" ]; then
        echo "Device $DEVICE_NAME is already disconnected"
        exit 0
    fi
    
    echo -n "Disconnecting from $DEVICE_NAME...  "
    echo -e "disconnect $MAC_ADDRESS\nquit" | bluetoothctl > /dev/null 2>&1
    
    show_spinner 10 \
        "! bluetoothctl info '$MAC_ADDRESS' 2>/dev/null | grep -q 'Connected: yes'" \
        "Successfully disconnected from $DEVICE_NAME" \
        "Failed to disconnect from $DEVICE_NAME"
else
    # Toggle mode (default behavior)
    if [ -n "$IS_CONNECTED" ]; then
        echo "Device $DEVICE_NAME is already connected"
        echo "Use --disconnect flag to disconnect"
        exit 0
    fi
    
    # Device is not connected, so connect it
    echo -n "Connecting to $DEVICE_NAME...  "
    echo -e "connect $MAC_ADDRESS\nquit" | bluetoothctl > /dev/null 2>&1
    
    show_spinner 10 \
        "bluetoothctl info '$MAC_ADDRESS' 2>/dev/null | grep -q 'Connected: yes'" \
        "Successfully connected to $DEVICE_NAME" \
        "Failed to connect to $DEVICE_NAME. Make sure the device is powered on and in range"
fi
