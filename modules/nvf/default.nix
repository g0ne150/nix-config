{ nvf, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  imports = [
    nvf.homeManagerModules.default
    ./options.nix
    ./bufferline.nix
    ./languages.nix
    ./snacks-nvim.nix
    ./blink-cmp.nix
  ];

  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        # 启用 vi/vim 别名
        viAlias = false;
        vimAlias = true;

        globals = {
          mapleader = " ";
          maplocalleader = "\\";
        };

        binds.whichKey = {
          enable = true;
          setupOpts.preset = "helix";
        };

        # 启用 Git 集成
        git = {
          enable = true;
        };

        ui.noice.enable = true;
        # FIXME no macro recording status
        statusline.lualine.enable = true;

        # 主题配置（可选）
        # theme = {
        #   enable = true;
        #   name = "tokyonight";
        # };

      };
    };
  };
}
