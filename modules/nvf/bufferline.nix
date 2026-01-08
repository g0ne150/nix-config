{...}: {
  programs.nvf.settings = {
    vim.tabline.nvimBufferline = {
      enable = true;

      mappings = {
        pick = "<leader>bb";
        cyclePrevious = "<S-h>";
        cycleNext = "<S-l>";
        closeCurrent = "<leader>bd";
      };
    };
  };
}
