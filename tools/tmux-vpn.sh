#!/usr/bin/env bash

# File: tools/tmux-vpn.sh
# Description: Shows active VPN connection for tmux status line.
# Dependencies: nmcli, grep, head, cut

set -euo pipefail

# Check for required dependencies
if ! command -v nmcli &> /dev/null; then
    echo "󰒄 no nmcli"
    exit 0
fi

vpn=$(nmcli -t -f NAME,TYPE con show --active 2>/dev/null | grep ':vpn\|:wireguard' | head -1 | cut -d: -f1)
if [ -n "$vpn" ]; then
  echo "󰒄 $vpn"
else
  echo "󰒄 off"
fi
