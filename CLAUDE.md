# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles repo for macOS. Manages zsh configuration, a custom Oh My Zsh theme, Python prompt scripts, git config, vim config, and AI agent skills. Uses [mise-en-place](https://mise.jdx.dev/dev-tools/) for tool version management.

## Key Architecture

### Zsh Prompt System

The custom prompt (`zsh/rand2.zsh-theme`) is an Oh My Zsh theme that assembles its display from three Python 3 helper scripts:

- `zsh/batcharge.py` - Battery status (RPROMPT right side). Uses `ioreg` on macOS, `/sys/class/power_supply` on Linux. Outputs zsh color escape sequences directly.
- `zsh/abbr_path.py` - Abbreviates long working directory paths. Takes max width as CLI argument.
- `zsh/zsh_day_time.py` - Day and time display (RPROMPT right side).

These scripts are invoked as shell aliases defined in `zsh/.zshrc` and called from the theme's `precmd()` function. They write directly to stdout with zsh prompt escape sequences (`%{$FG[...]%}`).

**Theme structure**: The left prompt (`PROMPT`) shows git/hg info + user@host + abbreviated path. The right prompt (`RPROMPT`) shows day/time + battery. The `precmd()` function in the theme rebuilds `RPROMPT` and `PWD_PROMPT` before each command.

### Setup System

Single `setup` script at repo root with two modes:
- `./setup` - Full mode (macOS only): Homebrew, mise, all dev tools, fonts, vim, macOS prefs
- `./setup --slim` - Config-only mode (cross-platform): Oh My Zsh, direnv, modern CLI tools, zsh/git config

The setup script symlinks config files into place: `zsh/.zshrc` to `~/.zshrc`, the theme to `~/.oh-my-zsh/custom/themes/`, and `claude/CLAUDE.md` to `~/.claude/CLAUDE.md` (along with vim, tmux, ghostty, and git config). Because these are symlinks, edits to the repo files take effect immediately. Any pre-existing real file is backed up to `dotfile_backups/` before linking.

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
- The `mise.toml` at repo root defines global tool versions (Python 3.12 is required for prompt scripts)
