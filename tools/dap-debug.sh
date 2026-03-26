#!/usr/bin/env bash

# This script launches GDB in DAP interpreter mode.
# It is designed to be used by an agent to send JSON-based DAP messages via stdin.

if ! command -v gdb &> /dev/null; then
    echo "Error: gdb is not installed."
    exit 1
fi

gdb --interpreter=dap
