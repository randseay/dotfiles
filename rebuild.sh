#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
HOST="$(scutil --get LocalHostName)"
exec sudo darwin-rebuild switch --flake "$DIR#${HOST}"
