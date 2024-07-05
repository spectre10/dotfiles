{
  description = "Nix Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
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
          inherit system;
          specialArgs = { inherit userInfo stateVersion; };
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              home-manager.users.${userInfo.username} = import ./home.nix;
              home-manager.extraSpecialArgs = { inherit userInfo stateVersion pkgs-unstable; };
            }
          ];
        };
      };
    };
}
