{ pkgs, lib, user, ... }:

{
  # Determinate Systems' installer already manages the Nix daemon; letting
  # nix-darwin manage it too would conflict.
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";

  # `_1password-cli` is licensed `unfree`, so nixpkgs blocks it by default.
  # Allow just this package by name rather than a blanket `allowUnfree = true`,
  # so any *other* unfree package added later still needs a deliberate opt-in.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "1password-cli" ];

  system.primaryUser = user;
  users.users.${user}.home = "/Users/${user}";
  system.stateVersion = 6;

  environment.shells = [ pkgs.zsh ];

  system.defaults = {
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
      # 2 / 15 are the fastest values Apple's System Settings sliders expose; the
      # old script's 1 / 1.5 was faster than the UI allows and only seemed to work
      # because a shell `defaults write` needed a logout to fully take effect.
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      _HIHideMenuBar = true;
    };
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      expose-animation-duration = 0.1;
      orientation = "left";
    };
  };

  # No typed nix-darwin option exists for these — ported verbatim from the
  # old `setup` script's raw `defaults write`/`chflags` calls.
  system.activationScripts.extraActivation.text = ''
    chflags nohidden "/Users/${user}/Library/"
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
    defaults write com.todesktop.230313mzl4w4u92 ApplePressAndHoldEnabled -bool false
  '';

  # Unlike Dock, nix-darwin never restarts anything for `_HIHideMenuBar` — the
  # value gets written but the menu-bar-owning process keeps its old cached
  # decision until reloaded. Killall'ing it (no logout needed) is the documented fix.
  system.activationScripts.postActivation.text = ''
    killall -qu ${user} SystemUIServer || true
    killall -qu ${user} Finder || true
  '';

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.powerline-fonts
  ];

  nix-homebrew = {
    enable = true;
    inherit user;
    # This machine already has a real Homebrew install at /opt/homebrew.
    # autoMigrate hands its management over to nix-homebrew instead of
    # deleting and reinstalling from scratch — installed packages (herdr,
    # ghostty, ngrok, orbstack) are kept, only the Homebrew installation
    # itself is replaced.
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # removes anything not listed below — see the repo's migration plan for the pre-cutover audit this depends on
    onActivation.autoUpdate = true;
    brews = [
      "herdr" # not in nixpkgs (niche/personal tool)
    ];
    casks = [
      # 1password-cli deliberately NOT here — migrated to home.packages'
      # _1password-cli (nixpkgs) instead of the Homebrew cask.
      "ghostty"
      "ngrok"
      "orbstack" # proprietary, no nixpkgs package
    ];
  };
}
