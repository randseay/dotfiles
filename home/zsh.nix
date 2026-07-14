{ config, pkgs, dotfilesDir, ... }:

let
  outOfStore = config.lib.file.mkOutOfStoreSymlink;
in
{
  # Deliberately NOT using `programs.zsh.enable`/`.oh-my-zsh`/`.autosuggestion`:
  # those options work by having home-manager generate ~/.zshrc itself, which
  # conflicts with linking the existing hand-written .zshrc unmodified below
  # (home-manager can't both generate a file's content and raw-symlink it).
  # This keeps today's zsh.zshrc/OMZ/plugin setup exactly as-is for now — a
  # deliberate scope cut from the original plan sketch, flagged for a
  # follow-up pass once the rest of the migration is stable.
  home.packages = [ pkgs.zsh ];

  home.file.".zshrc".source = outOfStore "${dotfilesDir}/zsh/.zshrc";
  home.file.".oh-my-zsh/custom/themes/rand2.zsh-theme".source =
    outOfStore "${dotfilesDir}/zsh/rand2.zsh-theme";
}
