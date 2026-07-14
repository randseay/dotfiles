#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
HOST="rands-mac-mini"
exec sudo darwin-rebuild switch --flake "$DIR#${HOST}"
