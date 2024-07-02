home-manager: { config, pkgs, ... }:
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
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = "FiraCode Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "FiraCode Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "FiraCode Nerd Font";
            style = "Italic";
          };
          size = 14.0;
        };
        window = {
          startup_mode = "Maximized";
        };
      };
    };

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      cargo
      rustc
      rustfmt
      nerdfonts
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
