#!/usr/bin/env bash

# File: tools/dap-debug.sh
# Description: This script launches GDB in DAP interpreter mode.
# Dependencies: gdb

set -euo pipefail

if ! command -v gdb &> /dev/null; then
    echo "Error: gdb is not installed." >&2
    exit 1
fi

gdb --interpreter=dap
