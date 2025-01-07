{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
    {
      darwinConfigurations."Worker" = nix-darwin.lib.darwinSystem {
        modules = [
          ./machines/Worker.nix
          ./darwin/homebrew.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            verbose = true;
            users.jan.imports = [
              ./home-manager/home.nix
            ];
            };
          }
        ];
      };
    };
}
