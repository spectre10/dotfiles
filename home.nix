home-manager:{config, pkgs, ...}:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.sp = { pkgs, ... }: {
    programs.zsh.enable = true;
    programs.bash.enable = true;
    programs.starship.enable = true;
    programs.git = {
      enable = true;
      userName = "Ghanshyam Thakkar";
      userEmail = "shyamthakkar001@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    programs.neovim.enable = true;
    programs.neovim.plugins = [
      pkgs.vimPlugins.nvim-treesitter
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
    home.packages = with pkgs; [
      cargo
      rustc
      rustfmt
    ];
    home.username = "sp";
    home.homeDirectory = "/home/sp";
    
    home.sessionVariables = {
      EDITOR = "nvim";
    };
    xdg.configFile."nvim" = {
      source = ./config/nvim;
      recursive = true;
    };
  # The state version is required and should stay at the version you
  # originally installed.
    home.stateVersion = "24.05";
  };
}


