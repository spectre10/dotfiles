{config, pkgs, ...}:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.sp = { pkgs, ... }: {
    programs.zsh.enable = true;
    programs.starship.enable = true;
    programs.git = {
      enable = true;
      userName = "Ghanshyam Thakkar";
      userEmail = "shyamthakkar001@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    home.packages = [
      pkgs.hello
    ];
    home.username = "sp";
    home.homeDirectory = "/home/sp";
    
    home.sessionVariables = {
      EDITOR = "nvim";
    };
    
  # The state version is required and should stay at the version you
  # originally installed.
    home.stateVersion = "24.05";
  };
}


