{ pkgs, user, ... }:

{
  # Determinate Systems' installer already manages the Nix daemon; letting
  # nix-darwin manage it too would conflict.
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";

  system.primaryUser = user;
  users.users.${user}.home = "/Users/${user}";
  system.stateVersion = 6;

  environment.shells = [ pkgs.zsh ];

  system.defaults = {
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
      KeyRepeat = 1;
      InitialKeyRepeat = 1.5; # verify at build time: nix-darwin may require an int here
    };
    # verify at build time: attribute names/types here (autohide-delay,
    # expose-animation-duration) match nix-darwin's dock module as of
    # nix-darwin-26.05 to the best of my knowledge, but weren't build-checked
    # on this machine (no local Nix installation to run `nix flake check`).
    dock = {
      autohide-delay = 0.0;
      expose-animation-duration = 0.1;
    };
  };

  # No typed nix-darwin option exists for these — ported verbatim from the
  # old `setup` script's raw `defaults write`/`chflags` calls.
  system.activationScripts.extraActivation.text = ''
    chflags nohidden "/Users/${user}/Library/"
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
    defaults write com.todesktop.230313mzl4w4u92 ApplePressAndHoldEnabled -bool false
  '';

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.powerline-fonts
  ];

  nix-homebrew = {
    enable = true;
    inherit user;
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
