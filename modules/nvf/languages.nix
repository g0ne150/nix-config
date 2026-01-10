{ ... }:
{
  programs.nvf.settings = {

    vim.languages = {
      enableTreesitter = true;
      enableFormat = true;

    };

    vim.languages.nix = {
      enable = true;
    };

    vim.languages.markdown = {
      enable = true;
    };
  };
}
