#!/usr/bin/env bash

# Terminate script on error
set -e

# Get the source directory
# (This may not be portable.)
src_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "=== Newsboat ==="

echo "Cleaning out old outogenerated content..."
rm "$src_dir/autogenerated-opml/"* || true
echo "Exporting Newsboat RSS subscriptions to OPML..."
newsboat -e > "$src_dir/autogenerated-opml/ORIGINAL.xml"
echo "Running tag splitting script..."
python3 "$src_dir/split-opml-by-tags.py" "$src_dir"

echo "DONE!"
printf "\n"
