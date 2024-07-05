{ config, pkgs, pkgs-unstable, pkgs-master, userInfo, stateVersion, ... }:
{
  programs.zsh.enable = true;
  programs.bash.enable = true;
  programs.starship = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = userInfo.name;
    userEmail = userInfo.email;
    extraConfig = {
      init.defaultBranch = "main";
    };
    package = pkgs-master.git;
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
        padding = {
          x = 20;
          y = 10;
        };
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
      protonvpn-gui
      protonvpn-cli
    ];
    shellAliases = {
      gl = "git log";
      gs = "git status";
      n = "nvim";
      cl = "clear";
      ls = "ls -lah";
      ".." = "cd ..";
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
}
