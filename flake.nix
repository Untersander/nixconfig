{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      # url = "github:nix-darwin/nix-darwin/master";
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
    }:
    {
      darwinConfigurations =
        let
          system = "aarch64-darwin";
          pkgs = import inputs.nixpkgs { inherit system; };
          pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
        in
        {
          "Worker" = nix-darwin.lib.darwinSystem {
            inherit system;
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
                  extraSpecialArgs = { inherit pkgs pkgs-unstable; };
                };
              }
            ];
          };
        };
    };
}
