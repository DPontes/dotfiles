#!/bin/bash

# Script to generate and fix compile_commands.json with error handling
# Usage: ./script.sh <target-name>

set -e  # Exit on any error
set -u  # Exit on undefined variables

# Configuration
SRC_PATH="$HOME/src"  # Adjust this path as needed
COMPILE_COMMANDS_FILE="compile_commands.json"

# Function to display usage
usage() {
    echo "Usage: $0 <target-name>"
    echo "Example: $0 //my/target:name"
    exit 1
}

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Function to handle errors
error_exit() {
    log "ERROR: $1"
    exit 1
}

# Check if target name is provided
if [ $# -ne 1 ]; then
    log "ERROR: Target name is required"
    usage
fi

TARGET_NAME="$1"

log "Starting compile commands generation for target: $TARGET_NAME"
log "Source path: $SRC_PATH"

# Step 1: Run bazel compile_commands
log "Running bazel compile_commands..."
if ! ./bazel.py run compile_commands -- --absolute --absolute_external --skip_failed_targets --target "$TARGET_NAME"; then
    error_exit "Failed to run bazel compile_commands"
fi

# Check if compile_commands.json was created
if [ ! -f "$COMPILE_COMMANDS_FILE" ]; then
    error_exit "compile_commands.json was not generated"
fi

log "Bazel compile_commands completed successfully"

# Step 2: Fix file paths in compile_commands.json
log "Fixing relative file paths..."
if ! sed -r -i "s|(\"file\": \")([^/])|\1$SRC_PATH/\2|g" "$COMPILE_COMMANDS_FILE"; then
    error_exit "Failed to fix file paths in compile_commands.json"
fi

log "File paths fixed successfully"

# Step 3: Fix directory paths in compile_commands.json
log "Fixing directory paths..."
if ! sed -r -i "s|(\"directory\": \")[^\"]*|\1$SRC_PATH|g" "$COMPILE_COMMANDS_FILE"; then
    error_exit "Failed to fix directory paths in compile_commands.json"
fi

log "Directory paths fixed successfully"

# Verify the output file
if [ ! -s "$COMPILE_COMMANDS_FILE" ]; then
    error_exit "compile_commands.json is empty or corrupted"
fi

log "✅ Script completed successfully!"
log "Generated: $COMPILE_COMMANDS_FILE"
log "Total entries: $(jq length "$COMPILE_COMMANDS_FILE" 2>/dev/null || echo "unknown (jq not available)")"
