#!/bin/bash

# Get the directory where this script is located.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# Set the source directory relative to the script directory.
SRC_DIR="$SCRIPT_DIR/../terraform/hardlink"

# Check if the destination directory argument is provided.
if [ -z "$1" ]; then
    echo "Usage: $(basename "$0") <destination_directory>"
    exit 1
fi

DEST_DIR="$1"

# Check if the source directory exists.
if [ ! -d "$SRC_DIR" ]; then
    echo "Source directory does not exist: $SRC_DIR"
    exit 1
fi

# Create the destination directory if it doesn't exist.
if [ ! -d "$DEST_DIR" ]; then
    mkdir -p "$DEST_DIR"
fi

# Loop through files in the source directory and create hard links in the destination.
for file in "$SRC_DIR"/*; do
    if [ -f "$file" ]; then
        FILENAME=$(basename "$file")
        ln "$file" "$DEST_DIR/$FILENAME"
    fi
done

echo "Hard links created successfully."
exit 0