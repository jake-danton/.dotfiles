#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname)" == "Linux" ]]; then
  echo "Linux detected — installing Homebrew build deps..."
  sudo apt-get update -qq
  sudo apt-get install -y build-essential procps curl file git
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x "/opt/homebrew/bin/brew" ]]; then # macOS Apple Silicon
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then # macOS Intel
  eval "$(/usr/local/bin/brew shellenv)"
elif [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then # Linux / DevPod
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

cd "$(dirname "$0")"

brew bundle install --file="./brew/.Brewfile"

stow --restow --target="$HOME" */ --verbose
