# Rand's Dotfiles

A lean, modern dotfiles configuration using [mise-en-place](https://mise.jdx.dev/dev-tools/) for tool management.

## Features

- **Custom Zsh Theme**: Personalized prompt with battery status, git info, and path abbreviation
- **Modern Tool Management**: Uses [mise-en-place](https://mise.jdx.dev/dev-tools/) instead of outdated version managers
- **Lean Setup**: Removed outdated tools (Ruby, old Python, Mercurial, Sublime, etc.)
- **macOS Optimized**: Custom macOS preferences and Apple Silicon support
- **Easy Management**: Simple setup and uninstall scripts
- **Clean Plugin Selection**: Only essential Oh My Zsh plugins for fast loading

## What's Included

### Core Tools (via mise)
- **Git**: Latest version
- **Vim**: Latest version  
- **Tmux**: Latest version
- **Python**: 3.12 (for prompt scripts)
- **JavaScript Runtimes**: Node.js 20 with corepack, Bun latest
- **Modern CLI Tools**: ripgrep, fd, bat, exa
- **direnv**: Environment management

### Custom Zsh Theme
- Battery status with charging indicator
- Git repository information
- Path abbreviation for long directories
- Time display
- Virtual environment support

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

## Quick Start

1. **Clone the repository**:
   ```bash
   git clone <your-repo> ~/dotfiles
   cd ~/dotfiles
   ```

2. **Run the setup script**:
   ```bash
   ./setup
   ```

3. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
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

## What Was Removed

- **Ruby environment**: rbenv, ruby-build
- **Python environment**: pyenv, virtualenvwrapper  
- **Mercurial**: hg configuration
- **Sublime**: Sublime Text configuration
- **Ford**: Custom tool
- **Outdated Node.js tools**: bower, grunt, gulp
- **Old Homebrew installation method**: Updated to modern approach
- **Antigen**: Replaced with standard Oh My Zsh plugin system
- **Excessive plugins**: Streamlined to only essential ones

## Requirements

- macOS (tested on Apple Silicon and Intel)
- Internet connection for initial setup
- Homebrew (installed automatically if needed)

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
./setup
```

## Contributing

Feel free to submit issues and enhancement requests!
