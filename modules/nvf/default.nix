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
    ./markdown.nix
    ./snacks-nvim.nix
    ./blink-cmp.nix
    ./lualine.nix
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

        ui.noice = {
          enable = true;
          setupOpts.lsp.signature.enabled = true;
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "macchiato";
        };

      };
    };
  };
}
