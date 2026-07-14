{ config, pkgs, dotfilesDir, ... }:

{
  home.packages = [ pkgs.tmux ];
  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/tmux/.tmux.conf";
}
