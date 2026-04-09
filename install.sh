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

# if command -v fish >/dev/null 2>&1; then
#   fish_path="$(command -v fish)"
#
#   if [[ -w /etc/shells ]] || sudo -n test -w /etc/shells; then
#     if ! grep -qx "$fish_path" /etc/shells 2>/dev/null; then
#       printf '%s\n' "$fish_path" | sudo tee -a /etc/shells >/dev/null
#     fi
#   fi
#
#   if [[ "${SHELL:-}" != "$fish_path" ]]; then
#     if [[ "$(uname)" == "Linux" ]]; then
#       sudo usermod --shell "$fish_path" "$USER"
#     else
#       chsh -s "$fish_path" "$USER"
#     fi
#   fi
# fi
