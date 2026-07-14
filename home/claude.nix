{ config, dotfilesDir, ... }:

{
  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/claude/CLAUDE.md";
  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/claude/settings.json";

  # agent/skills/* is a dynamic, growing set (globbed at run time), not a
  # fixed list — port the existing glob/symlink/warn-and-skip script as-is
  # rather than re-expressing it as a static Nix attribute set.
  home.activation.linkAgentSkills = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    DOTFILES="${dotfilesDir}" run /bin/bash "${dotfilesDir}/agent/setup"
  '';
}
