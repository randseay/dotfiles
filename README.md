# Rand's Dotfiles

A lean, modern dotfiles configuration using [mise-en-place](https://mise.jdx.dev/dev-tools/) for tool management.

## Features

- **Custom Zsh Theme**: Personalized prompt with battery status, git info, and path abbreviation
- **Modern Tool Management**: Uses [mise-en-place](https://mise.jdx.dev/dev-tools/) instead of outdated version managers
- **macOS Optimized**: Custom macOS preferences and Apple Silicon support
- **Easy Management**: Simple setup and uninstall scripts
- **Clean Plugin Selection**: Only essential Oh My Zsh plugins for fast loading
- **Flexible Installation**: Choose between full setup or lean setup

## What's Included

### Core Tools (via mise)
- **Git**: Latest version
- **Vim**: Latest version  
- **Tmux**: Latest version
- **Python**: 3.12 (for prompt scripts)
- **JavaScript Runtimes**: Node.js 20 with corepack, Bun latest
- **Modern CLI Tools**: ripgrep, fd, bat, eza
- **direnv**: Environment management

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

### Agent Skills
- AI agent capabilities directory (`agent/skills/`)
- Automatically linked to `~/.agent/skills` and `~/.gemini/antigravity/skills`
- Custom skills can be added to `agent/skills/` directory
- See [Agent Skills Specification](https://agentskills.io/) for more info

## Quick Start

1. **Clone the repository**:
   ```bash
   git clone git@github.com:randseay/dotfiles.git ~/dotfiles
   ```

2. **Navigate into the dotfiles**
   ```bash
   cd ~/dotfiles
   ```

3. **Choose your setup mode**:
   
   **Full setup (recommended for fresh machines):**
   ```bash
   ./setup
   ```
   
   **Slim setup (for devbox/deterministic environments):**
   ```bash
   ./setup --slim
   ```

4. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
   ```

## Setup Modes

### Full Setup (`./setup`)
Installs everything needed for a complete development environment:
- Homebrew package manager
- mise-en-place for tool management
- All development tools (git, vim, tmux, python, node, bun, etc.)
- Fonts for custom prompt
- Vim configuration
- macOS preferences
- Zsh and git configuration

### Slim Setup (`./setup --slim`)
Configuration-only mode for environments where heavy development tools are already available:
- **Installs**: Oh My Zsh (required for zsh configuration)
- **Installs**: direnv (required for zsh configuration)
- **Installs**: Modern CLI tools (eza, bat, fd, ripgrep) for enhanced aliases
- **Installs**: Custom zsh theme and plugins
- **Configures**: Zsh and git settings
- **Skips**: Heavy development tools (git, vim, tmux, python, node, etc.), fonts, vim config, macOS preferences
- **Perfect for**: devbox, Docker containers, CI/CD environments

### Help and Options
```bash
./setup --help          # Show all available options
./setup --slim          # Configuration-only mode
./setup                 # Full setup mode (default)
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

mise will automatically use these versions when you're in that directory.

## Uninstalling

To remove the dotfiles setup:

```bash
./uninstall
```

## Customization

### Adding New Aliases

Edit `zsh/.zshrc` and add your aliases in the aliases section.

### Modifying the Theme

Edit `zsh/rand2.zsh-theme` to customize your prompt appearance.

### Adding New Tools

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

Edit `~/.gitconfig` and update the signing key path:

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

- **Full setup**: macOS (tested on Apple Silicon and Intel)
  - Installs all tools via Homebrew and mise-en-place
- **Slim setup**: Any Unix-like system
  - Installs essential tools (Oh My Zsh, direnv, modern CLI tools) via package manager
  - Assumes heavy development tools (git, vim, tmux, python, node) are pre-installed
- Internet connection for initial setup
- Package manager access (apt, snap, brew) for slim mode

## Troubleshooting

### Python Scripts Not Working
Ensure Python 3.12+ is installed via mise:
```bash
mise use python@3.12
```

### Fonts Not Displaying
Install fonts manually:
```bash
cp -r fonts/powerline-fonts/* ~/Library/Fonts/
```

### Tool Not Found
Check if the tool is installed:
```bash
mise ls
```

Install missing tools:
```bash
mise sync
```

### Zsh Plugins Not Working
Ensure plugins are installed in the custom directory:
```bash
ls ~/.oh-my-zsh/custom/plugins/
```

Reinstall if needed:
```bash
./setup --slim  # For slim mode
# or
./setup         # For full mode
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
If you see errors like "Command 'eza' not found" after running the setup:

**Problem**: You're still in bash, but the setup script linked your zsh configuration with aliases.

**Solution**: Switch to zsh to use your configuration:
```bash
zsh
```

**Why this happens**: The setup script configures zsh, but you need to actually be running zsh for those configurations to take effect.

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
