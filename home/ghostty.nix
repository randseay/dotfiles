{ config, dotfilesDir, ... }:

{
  # Ghostty.app itself is installed via Homebrew cask (see darwin/configuration.nix)
  # — this just links the config. Ghostty's own `config-file = ?config.local`
  # include keeps working untouched, since it reads its own directory at runtime.
  xdg.configFile."ghostty/config".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/ghostty/config";
}
