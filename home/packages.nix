{ pkgs, isFull, ... }:

{
  # direnv itself: home-manager owns the shell hook, replacing the manual
  # `direnv hook zsh` line added in commit 30fbd29 to fix load order.
  programs.direnv.enable = true;

  home.packages = with pkgs; [
    # Common to both the macOS (full) and Linux (slim) profiles — this is
    # `setup --slim`'s tool list, formerly split across Homebrew and mise.
    eza
    bat
    fd
    ripgrep
    tmux
  ] ++ (if isFull then [
    # Full profile only — formerly `setup`'s full-mode Homebrew list plus
    # mise.toml's global tool pins. mise itself is eliminated; every one of
    # these is now pinned exactly via flake.lock instead of mise's "latest".
    autojump
    gh
    _1password-cli
    vim
    python312
    nodejs_20
    bun
    ffmpeg
  ] else [ ]);
}
