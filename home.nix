{ userInfo, stateVersion }: { config, pkgs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.${userInfo.username} = { ... }: {

    programs.zsh.enable = true;
    programs.bash.enable = true;
    programs.starship.enable = true;

    programs.git = {
      enable = true;
      userName = userInfo.name;
      userEmail = userInfo.email;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    programs.neovim = {
      enable = true;
      plugins = [
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      ];
      defaultEditor = true;
    };

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
          size = 12.0;
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

    home.username = userInfo.username;
    home.homeDirectory = userInfo.homeDirectory;

    # home.sessionVariables = { };

    xdg.configFile."nvim" = {
      source = ./config/nvim;
      # recursive = true;
    };
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = stateVersion;
  };
}
