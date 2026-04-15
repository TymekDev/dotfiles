#!/usr/bin/env bash

set -euo pipefail

: "${GITHUB_TOKEN:?GITHUB_TOKEN is missing}"

USERNAME=$(id -un)

export NIX_CONFIG="experimental-features = flakes nix-command
access-tokens = github.com=${GITHUB_TOKEN}
use-xdg-base-directories = true"

sh <(curl -L https://nixos.org/nix/install) --no-daemon

# shellcheck disable=SC1090
source ~/.local/state/nix/profiles/profile/etc/profile.d/nix.sh

nix run github:nix-community/home-manager -- \
  switch --flake "git+https://code.tymek.dev/TymekDev/dotfiles#${USERNAME}"

sudo chsh "${USERNAME}" --shell "/home/${USERNAME}/.local/state/nix/profile/bin/fish"

nvim --headless '+lua vim.pack.update({}, { version = "offline", target = "lockfile" })' '+qa'
nvim --headless '+lua require("nvim-treesitter").install({ "r", "markdown", "rnoweb", "yaml", }):wait(3 * 60 * 1000)' '+qa'

C_RED="\e[0;31m"
C_RESET="\e[0m"
echo -e "\n${C_RED}Please log out and log back in to apply the changes.${C_RESET}"
