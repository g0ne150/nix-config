{ ... }:
{
  programs.nvf.settings = {
    vim.tabline.nvimBufferline = {
      enable = true;

      mappings = {
        pick = "<leader>bb";
        cyclePrevious = "<S-h>";
        cycleNext = "<S-l>";
        closeCurrent = "<leader>bd";
        movePrevious = "[B";
        moveNext = "]B";
      };
    };

    vim.keymaps = [
      {
        key = "<leader>bp";
        action = "<Cmd>BufferLineTogglePin<CR>";
        mode = "n";
        desc = "Toggle Pin";
      }
      {
        key = "<leader>bP";
        action = "<Cmd>BufferLineGroupClose ungrouped<CR>";
        mode = "n";
        desc = "Delete Non-Pinned Buffers";
      }
      {
        key = "<leader>bl";
        action = "<Cmd>BufferLineCloseLeft<CR>";
        mode = "n";
        desc = "Delete Buffers to the Left";
      }
      {
        key = "<leader>br";
        action = "<Cmd>BufferLineCloseRight<CR>";
        mode = "n";
        desc = "Delete Buffers to the Right";
      }
      {
        key = "[b";
        action = "<Cmd>BufferLineCyclePrev<CR>";
        mode = "n";
        desc = "Prev Buffer";
      }
      {
        key = "]b";
        action = "<Cmd>BufferLineCycleNext<CR>";
        mode = "n";
        desc = "Next Buffer";
      }
    ];
  };
}
