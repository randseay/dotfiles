# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles repo for macOS. Manages zsh configuration, a custom Oh My Zsh theme, Python prompt scripts, git config, vim config, and AI agent skills. Machine provisioning is a flake (`flake.nix` + `darwin/` + `home/`) using nix-darwin and home-manager. mise-en-place is still used for per-project tool pinning (e.g. `~/dev/ai-agents`'s own `mise.toml`), but no longer manages this machine's global tools — that's `home/packages.nix` now.

## Key Architecture

### Zsh Prompt System

The custom prompt (`zsh/rand2.zsh-theme`) is an Oh My Zsh theme that assembles its display from three Python 3 helper scripts:

- `zsh/batcharge.py` - Battery status (RPROMPT right side). Uses `ioreg` on macOS, `/sys/class/power_supply` on Linux. Outputs zsh color escape sequences directly.
- `zsh/abbr_path.py` - Abbreviates long working directory paths. Takes max width as CLI argument.
- `zsh/zsh_day_time.py` - Day and time display (RPROMPT right side).

These scripts are invoked as shell aliases defined in `zsh/.zshrc` and called from the theme's `precmd()` function. They write directly to stdout with zsh prompt escape sequences (`%{$FG[...]%}`).

**Theme structure**: The left prompt (`PROMPT`) shows git/hg info + user@host + abbreviated path. The right prompt (`RPROMPT`) shows day/time + battery. The `precmd()` function in the theme rebuilds `RPROMPT` and `PWD_PROMPT` before each command.

### Setup System

**macOS (current):** `flake.nix` defines `darwinConfigurations` (nix-darwin + home-manager, one entry per `knownHosts` hostname) and `homeConfigurations."rand@linux"` (standalone home-manager, no nix-darwin — for devbox/CI use, not yet exercised). `darwin/configuration.nix` holds system-level config (macOS defaults, fonts, declarative Homebrew via `nix-homebrew`). `home/*.nix` holds one module per concern (`zsh.nix`, `git.nix`, `tmux.nix`, `vim.nix`, `ghostty.nix`, `claude.nix`, `packages.nix`); `home.nix` is the entry point and wires them together per `profile` ("full" on macOS, "slim" on Linux). Run `./bootstrap.sh` once on a new Mac (installs Nix, does the first `darwin-rebuild switch`); `./rebuild.sh` for every change after that — both auto-detect the current hostname via `scutil`.

Every raw dotfile link (`.zshrc`, `.vimrc`, `.tmux.conf`, ghostty config, Claude config) uses home-manager's `config.lib.file.mkOutOfStoreSymlink`, which points straight at this repo rather than copying into the Nix store — edits to the repo files still take effect immediately, no rebuild needed, matching the old setup script's behavior.

**Legacy bash `setup`/`uninstall`/`lib/utils.sh`** still exist at repo root but are no longer used on macOS — pending deletion once the migration fully settles (tracked in GitHub issues). `agent/setup` is still live, just retargeted: home-manager invokes it as an activation hook (`home/claude.nix`) instead of the old `setup` script calling it directly.

### Agent Skills

Skills in `agent/skills/` are symlinked to `~/.claude/skills/` and `~/.agent/skills/` during setup. See [Agent Skills spec](https://agentskills.io/).

## After Modifying Files

- **Theme changes** (`zsh/rand2.zsh-theme`): Symlinked, so edits are live. Start a new shell (or `source ~/.zshrc`) to see them.
- **Zshrc changes** (`zsh/.zshrc`): Symlinked, so edits are live. Run `source ~/.zshrc` or open a new terminal for running shells to pick them up.
- **Python prompt scripts**: Changes take effect immediately (invoked by path from aliases)
- **Test prompt changes**: Run `source ~/.zshrc` in a terminal after editing

## Conventions

- Python scripts use `#!/usr/bin/env python3` and write output via `sys.stdout.write()` (no trailing newline)
- Zsh color codes use Oh My Zsh's `$FG[nnn]` 256-color format
- Prompt scripts require Python 3.12, provided by `home/packages.nix` (full profile) now, not mise. The repo-root `mise.toml` is legacy — kept only because `~/dev/ai-agents` still depends on the `mise` binary being installed, not because anything in this repo reads it anymore
