#!/bin/bash

# Ensure a root directory is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <root_directory>"
  exit 1
fi

# Set the root directory
ROOT_DIR="$1"

# Check if the directory exists
if [ ! -d "$ROOT_DIR" ]; then
  echo "Error: Directory '$ROOT_DIR' does not exist."
  exit 1
fi

# Find all files with .wav extension in the root directory and its subdirectories
find "$ROOT_DIR" -type f -name "*.wav" | while read -r file; do
  # Get file properties using sox
  props=$(sox --i "$file" 2>/dev/null)
  if [[ $props == *"Sample Rate    : 44100"* && $props == *"Precision      : 16-bit"* ]]; then
    echo "Keeping: $file"
  else
    echo "Removing: $file"
    rm "$\'file\'"
  fi
done

echo "Cleanup completed."

