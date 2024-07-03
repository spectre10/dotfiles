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

    home = {
      username = userInfo.username;
      homeDirectory = userInfo.homeDirectory;
      packages = with pkgs; [
        cargo
        rustc
        rustfmt
        nerdfonts
      ];
      shellAliases = {
        gl = "git log";
        gs = "git status";
        n = "nvim";
      };
      # The state version is required and should stay at the version you
      # originally installed.
      stateVersion = stateVersion;
    };

    fonts.fontconfig.enable = true;

    xdg.configFile."nvim" = {
      source = ./config/nvim;
      # recursive = true;
    };
  };
}
