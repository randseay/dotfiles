{
  description = "Rand's dotfiles: nix-darwin + home-manager";

  inputs = {
    # Track a stable release branch, not nixpkgs-unstable, to match this repo's
    # "pin everything exactly" convention (see OPINIONS.md). Bump deliberately.
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, nix-homebrew }:
    let
      user = "rand";
      dotfilesDir = "/Users/rand/dotfiles";
    in
    {
      darwinConfigurations."rands-mac-mini" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit user dotfilesDir; };
        modules = [
          ./darwin/configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit dotfilesDir; profile = "full"; };
            home-manager.users.${user} = import ./home/home.nix;
          }
        ];
      };

      # Standalone home-manager for Linux devboxes/CI — replaces `setup --slim`.
      # Activate with: home-manager switch --flake .#rand@linux
      homeConfigurations."${user}@linux" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        extraSpecialArgs = { inherit dotfilesDir; profile = "slim"; };
        modules = [ ./home/home.nix ];
      };
    };
}
