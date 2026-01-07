{pkgs, nvf, ...}:{
  imports = [
    nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        # 启用 vi/vim 别名
        viAlias = false;
        vimAlias = true;

        # 启用 LSP
        lsp = {
          enable = true;
        };

        # 启用 Treesitter
        treesitter = {
          enable = true;
          fold = true;
        };

        languages = {
          enableTreesitter = true;
          enableFormat = true;

        };

        languages.nix = {
          enable = true;
        };

        utility.snacks-nvim.enable = true;

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
