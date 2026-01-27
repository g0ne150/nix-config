{ ... }:
{
  programs.nvf.settings = {
    vim.options = {
      cmdheight = 0;

      expandtab = true;
      smartindent = true;
      copyindent = true;

      # n - normal
      # v - visual
      # i - insert
      # c - command-line
      # h - all modes when editing a help file
      # a - all modes
      # r - for hit-enter and more-prompt prompt
      # change: `:set mouse = "a"`
      mouse = "";
    };
  };
}
