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

if [ "$DISCONNECT_FLAG" = true ]; then
    # Explicit disconnect requested
    if [ -z "$IS_CONNECTED" ]; then
        echo "Device $DEVICE_NAME is already disconnected"
        exit 0
    fi
    
    echo "Disconnecting from $DEVICE_NAME..."
    echo -e "disconnect $MAC_ADDRESS\nquit" | bluetoothctl > /dev/null 2>&1
    
    sleep 2
    
    # Verify disconnection
    IS_STILL_CONNECTED=$(bluetoothctl info "$MAC_ADDRESS" 2>/dev/null | grep "Connected: yes")
    
    if [ -z "$IS_STILL_CONNECTED" ]; then
        echo "✓ Successfully disconnected from $DEVICE_NAME"
        exit 0
    else
        echo "✗ Failed to disconnect from $DEVICE_NAME"
        exit 1
    fi
else
    # Toggle mode (default behavior)
    if [ -n "$IS_CONNECTED" ]; then
        echo "Device $DEVICE_NAME is already connected"
        echo "Use --disconnect flag to disconnect"
        exit 0
    fi
    
    # Device is not connected, so connect it
    echo "Connecting to $DEVICE_NAME..."
    echo -e "connect $MAC_ADDRESS\nquit" | bluetoothctl > /dev/null 2>&1
    
    sleep 2
    
    # Verify connection
    IS_NOW_CONNECTED=$(bluetoothctl info "$MAC_ADDRESS" 2>/dev/null | grep "Connected: yes")
    
    if [ -n "$IS_NOW_CONNECTED" ]; then
        echo "✓ Successfully connected to $DEVICE_NAME"
        exit 0
    else
        echo "✗ Failed to connect to $DEVICE_NAME"
        echo "Make sure the device is powered on and in range"
        exit 1
    fi
fi


