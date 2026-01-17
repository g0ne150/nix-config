{ ... }:
{
  programs.nvf.settings = {
    vim.statusline.lualine = {
      enable = true;
      activeSection = {
        a = [ ''{ "mode" }'' ];
        b = [ ''{ "branch" }'' ];
        c = [
          ''
            {
              "diagnostics",
              sources = { 'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp', 'coc' },
              symbols = { error = '󰅙 ', warn = ' ', info = ' ', hint = '󰌵 ' },
              colored = true,
              update_in_insert = false,
              always_visible = false,
              diagnostics_color = {
                color_error = { fg = 'red' },
                color_warn = { fg = 'yellow' },
                color_info = { fg = 'cyan' },
              },
            }
          ''
          ''{ "filetype", colored = true, icon_only = true, icon = { align = 'left' } } ''
          ''{ "filename", symbols = {modified = ' ', readonly = ' '}, separator = {right = ''} } ''
        ];

        x = [
          "require('snacks').profiler.status()"
          ''
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = require('snacks').util.color("Statement") } end,
            }
          ''
          ''
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = require('snacks').util.color("Constant") } end,
            }
          ''
          ''
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = require('snacks').util.color("Debug") } end,
            }
          ''
          # ''
          #   -- stylua: ignore
          #   {
          #     require("lazy.status").updates,
          #     cond = require("lazy.status").has_updates,
          #     color = function() return { fg = require('snacks').util.color("Special") } end,
          #   }
          # ''
          ''
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " ",
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            }
          ''
        ];
        y = [
          ''{ "progress", separator = " ", padding = { left = 1, right = 0 } }''
          ''{ "location", padding = { left = 0, right = 1 } }''
        ];
        z = [ ''function() return " " .. os.date("%R") end'' ];
      };
    };
  };
}
