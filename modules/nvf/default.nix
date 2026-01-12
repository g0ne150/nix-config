{ nvf, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  imports = [
    nvf.homeManagerModules.default
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

        # 启用 LSP
        lsp = {
          enable = true;
        };

        binds.whichKey = {
          enable = true;
        };

        # 启用 Git 集成
        git = {
          enable = true;
        };

        # 主题配置（可选）
        # theme = {
        #   enable = true;
        #   name = "tokyonight";
        # };

      };
    };
  };
}
