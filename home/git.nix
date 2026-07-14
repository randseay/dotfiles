{ ... }:

{
  programs.git = {
    enable = true;

    # Untracked, per-machine overrides — same escape hatch as today, just
    # declared through home-manager's `includes` instead of a manual
    # `[include] path = ...` line. home-manager never manages this file, so
    # it stays a normal writable file on disk.
    includes = [ { path = "~/.gitconfig.local"; } ];

    settings = {
      user = {
        name = "Rand Seay";
        email = "rand.seay@gmail.com";
        # TODO: replace with the real signing key path once it exists on this
        # machine (see README's manual SSH-signing setup steps).
        signingkey = "~/.ssh/id_ed25519_signing";
      };
      core = {
        editor = "vim";
        excludesfile = "~/dotfiles/git/.gitignore_global";
      };
      push.default = "simple";
      pull.rebase = true;
      fetch.prune = true;
      gpg.format = "ssh";
      commit.gpgsign = true;
      tag.gpgsign = true;
      "gpg \"ssh\"".allowedSignersFile = "~/.config/git/allowed_signers";
      color.ui = true;
      init.defaultBranch = "main";
    };
  };
}
