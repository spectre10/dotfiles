{
  description = "Nix Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # use the following for unstable:
    # nixpkgs.url = "nixpkgs/nixos-unstable";

    # or any branch you want:
    # nixpkgs.url = "nixpkgs/{BRANCH-NAME}";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      userInfo = {
        name = "Ghanshyam Thakkar";
        username = "sp";
        email = "shyamthakkar001@gmail.com";
        homeDirectory = "/home/sp";
      };
      stateVersion = "24.05";
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          modules = [
            (import ./configuration.nix {
              inherit userInfo stateVersion;
            })
            home-manager.nixosModules.home-manager
            {
              imports = [
                (import ./home.nix {
                  inherit userInfo stateVersion;
                })
              ];
            }
          ];
        };
      };
    };
}
