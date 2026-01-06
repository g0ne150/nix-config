{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      markdown-preview-nvim
    ];
    extraPackages = with pkgs; [ tree-sitter marksman lua-language-server ];
  };
}
