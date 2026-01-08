{...}: {
  programs.nvf.settings = {
    vim.tabline.nvimBufferline = {
      enable = true;

      mappings = {
        pick = "<leander>bb";
        cyclePrevious = "<S-h>";
        cycleNext = "<S-l>";
        closeCurrent = "<leader>bd";
      };
    };
  };
}
