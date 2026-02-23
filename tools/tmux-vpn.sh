#!/bin/bash
vpn=$(nmcli -t -f NAME,TYPE con show --active 2>/dev/null | grep ':vpn\|:wireguard' | head -1 | cut -d: -f1)
if [ -n "$vpn" ]; then
  echo "󰒄 $vpn"
else
  echo "󰒄 off"
fi
