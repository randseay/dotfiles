# Rand's Dotfiles

macOS is provisioned declaratively with **nix-darwin + home-manager**, pinned exactly via a flake. Non-macOS devboxes/CI still use a lean bash `setup --slim` + mise, since Nix isn't always available or wanted there.

## Features

- **Declarative macOS provisioning**: One flake (`flake.nix` + `darwin/` + `home/`) builds system settings, Homebrew, and dotfiles as one reproducible closure. `darwin-rebuild rollback` undoes a bad change atomically.
- **Custom Zsh Theme**: Personalized prompt with battery status, git info, and path abbreviation
- **macOS Optimized**: Custom macOS preferences and Apple Silicon support
- **Clean Plugin Selection**: Only essential Oh My Zsh plugins for fast loading
- **Devbox/CI fallback**: `setup --slim` covers non-macOS environments where Nix isn't the right fit

## What's Included

### macOS (via the flake)
- **Git, Vim, Tmux, GitHub CLI, autojump, 1Password CLI**: exact versions pinned by `flake.lock`
- **Python 3.12, Node.js (current LTS), Bun**: same — see `home/packages.nix`
- **Modern CLI Tools**: ripgrep, fd, bat, eza, direnv
- **Fonts**: JetBrains Mono Nerd Font, Powerline fonts — installed via nix-darwin's `fonts.packages`, not a one-time copy
- **Homebrew**: still used for anything not in nixpkgs (managed declaratively via `nix-homebrew`, not manual `brew install`)

### Devbox/CI (`./setup --slim`, no Nix)
- **Modern CLI Tools**: ripgrep, fd, bat, eza, direnv (via system package manager)
- Assumes heavier dev tools (git, vim, tmux, python, node) are already present

### Development Tools (via mise)

mise is no longer used for this machine's global tools — that moved to `home/packages.nix`. It's kept for **per-project** tool pinning (see [Project-Specific Configuration](#project-specific-configuration) below) — `~/dev/ai-agents`, for example, pins its own `bun`/`pm2`/`uv` versions this way.

### Custom Zsh Theme
- Battery status with charging indicator
- Git repository information
- Path abbreviation for long directories
- Time display

### Python Scripts for Prompt
- `batcharge.py`: Battery status display
- `abbr_path.py`: Path abbreviation
- `zsh_day_time.py`: Time display

### Essential Oh My Zsh Plugins
- `autojump`: Smart directory jumping
- `direnv`: Environment management
- `git`: Git integration
- `zsh-autosuggestions`: Command suggestions
- `zsh-syntax-highlighting`: Syntax highlighting

### Modern CLI Tool Aliases
The setup includes enhanced aliases for common commands:
- **`ls` → `eza`**: Modern `ls` replacement with colors, icons, and tree views
- **`cat` → `bat`**: Enhanced `cat` with syntax highlighting and paging
- **`find` → `fd`**: Fast, user-friendly alternative to `find`
- **`grep` → `ripgrep`**: Fast, recursive grep with smart defaults

### Agent Skills & Claude Code

- AI agent capabilities directory (`agent/skills/`)
- Automatically linked to:
  - `~/.agent/skills` (legacy location)
  - `~/.gemini/antigravity/skills` (Antigravity/Gemini)
  - `~/.claude/skills` (Claude Code)
- Custom skills can be added to `agent/skills/` directory
- Global Claude Code configuration in `claude/CLAUDE.md` linked to `~/.claude/CLAUDE.md`
- See [Agent Skills Specification](https://agentskills.io/) for more info
- See [Claude Code Best Practices](https://code.claude.com/docs/en/best-practices) for Claude configuration

## Quick Start

### macOS

1. **Clone the repository**:
   ```bash
   git clone git@github.com:randseay/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **First time on this Mac** — installs Nix (Determinate Systems installer) and does the first `darwin-rebuild switch`:
   ```bash
   ./bootstrap.sh
   ```
   If this is a *new* machine (not `rands-mac-mini`), add its hostname to `knownHosts` in `flake.nix` first — see [Adding a New Mac](#adding-a-new-mac).

3. **Every change after that**:
   ```bash
   ./rebuild.sh
   ```

4. **Open a new terminal** — your current shell predates the switch and won't pick up the new `PATH`.

`bootstrap.sh`/`rebuild.sh` both auto-detect the current hostname via `scutil`, so neither needs editing per-machine.

### Devbox / CI (no Nix)

```bash
./setup --slim
source ~/.zshrc
```

### Help and Options
```bash
./setup --help          # Show all available options
./setup --slim          # Configuration-only mode, no Nix (devbox/CI)
```

## Adding a New Mac

1. Add the machine's hostname to `knownHosts` in `flake.nix` (one line).
2. **Before running `bootstrap.sh` there**: audit that machine's existing Homebrew state (`brew leaves`, `brew list --cask`) and add anything worth keeping to `homebrew.brews`/`casks` in `darwin/configuration.nix`. `homebrew.onActivation.cleanup = "zap"` removes anything installed but not declared — on the *first* switch, that means anything from that machine's prior life that isn't already accounted for.
3. If the macOS username differs from `rand`, update `user` in `flake.nix`.
4. Run `./bootstrap.sh`.

## Validating Without Applying

Check that the flake builds before touching the system — useful after any edit:
```bash
nix flake check --no-build
nix build ".#darwinConfigurations.$(scutil --get LocalHostName).system" --dry-run
```

## Rolling Back

nix-darwin and home-manager keep generations, so a bad `./rebuild.sh` is reversible:
```bash
darwin-rebuild rollback
```

## Tool Management

### Using mise

**List installed tools**:
```bash
mise ls
```

**Use a specific tool version in current directory**:
```bash
mise use node@20
mise use python@3.12
mise use bun@latest
```

**Run a tool with current directory's version**:
```bash
mise x -- node --version
mise x -- python --version
mise x -- bun --version
```

**Install all tools from configuration**:
```bash
mise sync
```

### Adding New Tools

Edit `mise.toml` to add new tools:

```toml
[tools]
# Add new tools here
terraform = "latest"
docker = "latest"
```

Then run:
```bash
mise sync
```

## Project-Specific Configuration

Create a `mise.toml` in your project directory:

```toml
[tools]
node = "18"
python = "3.11"
bun = "1.0"
```

mise will automatically use these versions when you're in that directory. This is the still-current way to pin per-project tool versions — the machine's own global tools moved to Nix, but project-level mise usage is unaffected.

## Uninstalling

**macOS**: there's no single "uninstall" — `darwin-rebuild rollback` reverts the last `./rebuild.sh`. To fully remove Nix itself, see the [Determinate Nix uninstaller](https://determinate.systems/nix-installer/). `./uninstall` only undoes the legacy bash `setup` script and doesn't know about anything nix-darwin/home-manager manage — don't use it on a Nix-provisioned Mac.

**Devbox/CI** (`./setup --slim` only, no Nix involved):
```bash
./uninstall
```

## Customization

### Adding New Aliases

Edit `zsh/.zshrc` and add your aliases in the aliases section. Takes effect immediately (live-linked), no rebuild needed.

### Modifying the Theme

Edit `zsh/rand2.zsh-theme` to customize your prompt appearance. Also live-linked.

### Adding New Tools (macOS)

1. Add the package to `home/packages.nix`
2. Run `./rebuild.sh`

### Adding New Tools (devbox/CI, no Nix)

1. Add to `mise.toml`
2. Run `mise sync`
3. Add any necessary configuration to `zsh/.zshrc`

## Git Configuration

### Global Gitignore

The setup includes a global gitignore file at `git/.gitignore_global` that automatically excludes common files from all your repositories:
- macOS system files (`.DS_Store`)
- Editor temporary files
- Common build artifacts

This is automatically configured during setup.

### SSH Signing Setup

The dotfiles include Git commit and tag signing with SSH keys. You'll need to set this up on each fresh installation:

#### 1. Generate SSH Signing Key

```bash
# Generate a new SSH key for signing (different from your main SSH key)
ssh-keygen -t ed25519 -C "your-email@example.com" -f ~/.ssh/id_ed25519_signing

# Add the key to your SSH agent
ssh-add ~/.ssh/id_ed25519_signing
```

#### 2. Create Allowed Signers File

```bash
# Create the git config directory
mkdir -p ~/.config/git

# Add your signing key to the allowed signers file
echo "your-email@example.com ssh-ed25519 $(cat ~/.ssh/id_ed25519_signing.pub)" > ~/.config/git/allowed_signers
```

#### 3. Update Git Config

**macOS**: `~/.gitconfig` is generated by home-manager's `programs.git` module now — edit `home/git.nix`'s `settings.user.signingkey` instead, then run `./rebuild.sh`. Editing `~/.gitconfig` directly won't stick.

**Devbox/CI** (`./setup --slim`): edit `~/.gitconfig` (symlinked from `git/.gitconfig`) directly:

```ini
[user]
    name = Your Name
    email = your-email@example.com
    signingkey = ~/.ssh/id_ed25519_signing
```

#### 4. Test Signing

```bash
# Test commit signing
echo "test" > test.txt
git add test.txt
git commit -m "Test signed commit"
git log --show-signature

# Test tag signing
git tag -s v1.0.0 -m "Test signed tag"
git show v1.0.0
```

#### 5. Add to GitHub (Optional)

If you're using GitHub, add your signing public key:

```bash
# Copy your public key
cat ~/.ssh/id_ed25519_signing.pub

# Add this to GitHub: Settings > SSH and GPG keys > New SSH key
# Mark it as a "Signing key"
```

### Git Configuration Features

- **SSH Signing**: All commits and tags are automatically signed
- **Modern Settings**: `pull.rebase = true` for clean history, `fetch.prune = true` for clean remotes
- **Color Output**: Enhanced readability with colored git output
- **Global Gitignore**: Automatically excludes common files from all repositories
- **Clean Setup**: Removed unused tools and aliases for a lean configuration

## Git Submodules

This repository includes the **powerline-fonts** submodule for the custom zsh theme.

Submodules are automatically initialized during git clone with `--recursive` flag, but if you need to update them:

```bash
git submodule update --init --recursive
```

## Requirements

- **macOS** (Apple Silicon; Intel needs one line changed — `nixpkgs.hostPlatform` in `darwin/configuration.nix`)
  - `./bootstrap.sh` installs Nix (Determinate Systems installer) and everything else via the flake
- **Slim setup** (`./setup --slim`, no Nix): any Unix-like system
  - Installs essential tools (Oh My Zsh, direnv, modern CLI tools) via package manager
  - Assumes heavy development tools (git, vim, tmux, python, node) are pre-installed
- Internet connection for initial setup
- Package manager access (apt, snap, brew) for slim mode

## Troubleshooting

### Python Scripts Not Working
**macOS**: confirm `python312` is in `home/packages.nix` and run `./rebuild.sh`.
**Devbox/CI**: ensure Python 3.12+ is installed via mise:
```bash
mise use python@3.12
```

### Fonts Not Displaying
**macOS**: fonts come from nix-darwin's `fonts.packages` in `darwin/configuration.nix` — run `./rebuild.sh`, then check `fc-list | grep -i jetbrains`. If they're not there, the package name/attribute may have changed upstream in nixpkgs.
**Devbox/CI or manual fallback**: install fonts directly:
```bash
cp -r fonts/powerline-fonts/* ~/Library/Fonts/
```

### Tool Not Found
**macOS**: check whether the tool is in `home/packages.nix` (or a `programs.*` module), add it, and run `./rebuild.sh`.
**Devbox/CI**: check if the tool is installed:
```bash
mise ls
```
Install missing tools:
```bash
mise sync
```

### Zsh Plugins Not Working
Oh My Zsh itself and the `zsh-autosuggestions`/`zsh-syntax-highlighting` plugins are **not** yet nix-managed (a deliberate scope cut — see `home/zsh.nix`'s comment) — they still come from the same Oh My Zsh installer / plugin git-clones as before, on both macOS and devbox/CI. Ensure plugins are installed in the custom directory:
```bash
ls ~/.oh-my-zsh/custom/plugins/
```

Reinstall if needed:
```bash
./setup --slim  # For slim mode
# or
./setup         # For full mode (macOS pre-Nix-migration path — still installs Oh My Zsh/plugins)
```

### Shell Configuration Issues
If you get errors about Oh My Zsh not loading or direnv not found:

1. **Check your current shell**:
   ```bash
   echo $SHELL
   ```

2. **Switch to zsh temporarily**:
   ```bash
   zsh
   ```

3. **Change default shell** (recommended):
   ```bash
   chsh -s $(which zsh)
   ```

4. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
   ```

**Note**: The zsh configuration will only work when running zsh, not bash.

**Pro tip**: The setup script will offer to change your default shell to zsh automatically!

### Common Setup Issues

#### **Commands Not Found After Setup**
If you see errors like "Command 'eza' not found" after running `./bootstrap.sh`/`./rebuild.sh` on macOS:

**Problem**: Your current shell predates the switch and still has the old `PATH`.

**Solution**: Open a new terminal window/tab.

If you see the same thing after `./setup --slim` on a devbox: you're still in bash, but the setup script linked your zsh configuration with aliases — switch to zsh:
```bash
zsh
```

#### **Cannot Change Default Shell**
If you get permission errors when trying to change your default shell:

**Problem**: The `chsh` command requires elevated privileges on some systems.

**Solutions**:
1. **Switch to zsh manually** (recommended for now):
   ```bash
   zsh
   ```

2. **Change shell with sudo** (if you have sudo access):
   ```bash
   sudo chsh -s $(which zsh) $USER
   ```

3. **Restart your terminal** - it may pick up the new shell automatically



## Contributing

Feel free to submit issues and enhancement requests!
