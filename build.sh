#!/usr/bin/env bash

main() {
  ZOLA_VERSION=0.21.0

  export TZ=Asia/Jerusalem

  # Install Zola if not already in PATH
  if ! command -v zola &> /dev/null; then
    echo "Installing Zola ${ZOLA_VERSION}..."
    curl -sLJO "https://github.com/getzola/zola/releases/download/v${ZOLA_VERSION}/zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
    mkdir "${HOME}/.local/zola"
    tar -C "${HOME}/.local/zola" -xf "zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
    rm "zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
    export PATH="${HOME}/.local/zola:${PATH}"
  else
    echo "Zola already installed, skipping installation..."
  fi

  # Verify installations
  echo "Verifying installations..."
  echo Zola: "$(zola --version)"

  # Build the site
  echo "Building the site..."
  zola build --minify
}

set -euo pipefail
main "$@"
