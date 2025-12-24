#!/usr/bin/env bash

# Exit on error
set -e

# Set timezone as requested in your previous configuration
export TZ=Asia/Jerusalem

echo "Current Timezone: $TZ"
echo "Zola Version: $(zola --version)"

# Build the site using the native zola command
# The --minify flag is used to optimize the output
zola build --minify

echo "Build complete."
