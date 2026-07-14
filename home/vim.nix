{ config, pkgs, dotfilesDir, ... }:

{
  home.packages = [ pkgs.vim ];

  home.file.".vimrc".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/vim/.vimrc";

  # Static data — a symlink is fine, no reason this still needs to be a real
  # copy the way the old `setup` script did it.
  home.file.".vim/spell/en.utf-8.spl".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/vim/spell/en.utf-8.spl";
}
