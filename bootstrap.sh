#!/usr/bin/env bash
# Takes this Mac from nothing (no Nix) to a built nix-darwin config.
# Run this once. After it finishes, use ./rebuild.sh for every later change.
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
HOST="rands-mac-mini"

echo "==> Step 1: Determinate Nix"
if command -v nix >/dev/null 2>&1; then
  echo "    nix already installed, skipping"
else
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix \
    | sh -s -- install --no-confirm
  # shellcheck disable=SC1091
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

echo "==> Step 2: validate the flake builds before touching the system"
nix flake check --no-build "$DIR"
nix build "$DIR#darwinConfigurations.${HOST}.system" --dry-run

echo "==> Step 3: first darwin-rebuild switch"
# darwin-rebuild doesn't exist yet on a fresh machine, so run it straight
# from the flake this once. After this, rebuild.sh works normally.
# sudo resets PATH to a secure default that excludes /nix/.../bin, so a
# freshly installed `nix` would not be found under sudo even though it's
# on PATH here. Resolve the absolute path first and invoke that instead.
NIX_BIN="$(command -v nix)"
sudo "$NIX_BIN" run nix-darwin -- switch --flake "$DIR#${HOST}"
# If this still fails with "nix: command not found", open a new terminal
# (Determinate adds nix to new shells' PATH) and re-run ./bootstrap.sh.

echo "==> Done. Use ./rebuild.sh for future changes."
