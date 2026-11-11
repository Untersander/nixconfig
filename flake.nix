{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-oldstable.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      # url = "github:nix-darwin/nix-darwin/master";
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nixpkgs-oldstable,
      nixpkgs-unstable,
      home-manager,
      nix-index-database,
    }:
    {
      darwinConfigurations =
        let
          system = "aarch64-darwin";
          pkgs-oldstable = import inputs.nixpkgs-oldstable {
            inherit system;
            config.allowUnfree = true;
          };
          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
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
                    nix-index-database.homeModules.nix-index
                  ];
                  extraSpecialArgs = { inherit pkgs-oldstable pkgs-unstable; };
                };
              }
            ];
          };
        };
    };
}
