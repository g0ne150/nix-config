{ ... }:
{
  programs.nvf.settings = {
    vim.languages.markdown = {
      enable = true;
      extraDiagnostics.enable = true;
      format.enable = true; # lsp format 目前无效的，使用命令: `lua require('conform').format()` 可以 format
      lsp.enable = true;
      treesitter.enable = true;
      extensions.render-markdown-nvim.enable = true;
    };
    vim.utility.preview.markdownPreview.enable = true;
  };
}
