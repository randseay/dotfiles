{ config, dotfilesDir, ... }:

{
  # Herdr.app is installed via Homebrew cask (see darwin/configuration.nix) - this
  # just links the config. mkOutOfStoreSymlink keeps the file editable in the repo
  # and reloadable at runtime via `herdr server reload-config`, without a rebuild.
  xdg.configFile."herdr/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/herdr/config.toml";
}
