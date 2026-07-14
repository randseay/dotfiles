{ config, pkgs, lib, dotfilesDir, profile, ... }:

let
  isFull = profile == "full";
in
{
  imports = [
    ./zsh.nix
    ./git.nix
    ./tmux.nix
    ./claude.nix
    ./packages.nix
  ] ++ lib.optionals isFull [
    ./vim.nix
    ./ghostty.nix
  ];

  home.username = "rand";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/rand" else "/home/rand";
  home.stateVersion = "24.11";

  home.sessionVariables = {
    EDITOR = "vim";
    DOTFILES = dotfilesDir;
    PYTHONUNBUFFERED = "1";
  };

  # Lets modules read `profile`/`dotfilesDir` via `config._module.args` instead
  # of threading them through every import list by hand.
  _module.args = { inherit dotfilesDir profile isFull; };

  programs.home-manager.enable = true;
}
