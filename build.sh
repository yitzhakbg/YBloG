#!/usr/bin/env bash

# Exit on error
set -e

# Set timezone
export TZ=Asia/Jerusalem
echo "Current Timezone: $TZ"

# Install Zola if not found
if ! command -v zola &> /dev/null; then
    echo "Zola not found. Installing..."
    ZOLA_VER="${ZOLA_VERSION:-0.21.0}"
    # Construct the download URL
    ZOLA_URL="https://github.com/getzola/zola/releases/download/v${ZOLA_VER}/zola-v${ZOLA_VER}-x86_64-unknown-linux-gnu.tar.gz"
    
    echo "Downloading Zola $ZOLA_VER from $ZOLA_URL"
    wget -qO zola.tar.gz "$ZOLA_URL"
    tar -xzf zola.tar.gz
    chmod +x zola
    
    # Add current directory to PATH so we can run ./zola as zola
    export PATH="$PWD:$PATH"
fi

echo "Zola Version: $(zola --version)"

# Determine Base URL based on Netlify Context
BASE_URL_FLAG=""

if [ "$CONTEXT" = "deploy-preview" ]; then
    echo "Deploy Preview detected. Using DEPLOY_PRIME_URL: $DEPLOY_PRIME_URL"
    BASE_URL_FLAG="--base-url $DEPLOY_PRIME_URL"
elif [ -n "$URL" ]; then
    # For production or branch deploys, use the main URL or let config.toml decide if we didn't want to override.
    # But usually it's safer to override to match the environment.
    echo "Context: $CONTEXT. Using URL: $URL"
    BASE_URL_FLAG="--base-url $URL"
fi

# Build the site
echo "Building with command: zola build --minify $BASE_URL_FLAG"
zola build --minify $BASE_URL_FLAG

echo "Build complete."