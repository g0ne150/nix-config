{ ... }:
{
  programs.nvf.settings = {
    vim.utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        bigfile = {
          enabled = true;
        };
        dashboard = {
          enabled = true;
          sections = [
            { section = "header"; }
            {
              section = "keys";
              gap = 1;
              padding = 1;
            }
          ];
        };
        explorer = {
          enabled = true;
        };
        indent = {
          enabled = true;
        };
        input = {
          enabled = true;
        };
        notifier = {
          enabled = true;
          timeout = 3000;
        };
        picker = {
          enabled = true;
        };
        quickfile = {
          enabled = true;
        };
        scope = {
          enabled = true;
        };
        scroll = {
          enabled = true;
        };
        statuscolumn = {
          enabled = true;
        };
        words = {
          enabled = true;
        };
        styles = {
          notification = {
            #  wo = { wrap = true; }; -- Wrap notifications
          };
        };
      };
    };

    vim.keymaps = [
      # Top Pickers & Explorer
      {
        key = "<leader><space>";
        action = "function() Snacks.picker.smart() end";
        mode = "n";
        lua = true;
        desc = "Smart Find Files";
      }
      {
        key = "<leader>,";
        action = "function() Snacks.picker.buffers() end";
        mode = "n";
        lua = true;
        desc = "Buffers";
      }
      {
        key = "<leader>/";
        action = "function() Snacks.picker.grep() end";
        mode = "n";
        lua = true;
        desc = "Grep";
      }
      {
        key = "<leader>:";
        action = "function() Snacks.picker.command_history() end";
        mode = "n";
        lua = true;
        desc = "Command History";
      }
      {
        key = "<leader>n";
        action = "function() Snacks.picker.notifications() end";
        mode = "n";
        lua = true;
        desc = "Notification History";
      }
      {
        key = "<leader>e";
        action = "function() Snacks.explorer() end";
        mode = "n";
        lua = true;
        desc = "File Explorer";
      }
      # find
      {
        key = "<leader>fb";
        action = "function() Snacks.picker.buffers() end";
        mode = "n";
        lua = true;
        desc = "Buffers";
      }
      {
        key = "<leader>fc";
        action = "function() Snacks.picker.files({ cwd = vim.fn.stdpath(\"config\") }) end";
        mode = "n";
        lua = true;
        desc = "Find Config File";
      }
      {
        key = "<leader>ff";
        action = "function() Snacks.picker.files() end";
        mode = "n";
        lua = true;
        desc = "Find Files";
      }
      {
        key = "<leader>fg";
        action = "function() Snacks.picker.git_files() end";
        mode = "n";
        lua = true;
        desc = "Find Git Files";
      }
      {
        key = "<leader>fp";
        action = "function() Snacks.picker.projects() end";
        mode = "n";
        lua = true;
        desc = "Projects";
      }
      {
        key = "<leader>fr";
        action = "function() Snacks.picker.recent() end";
        mode = "n";
        lua = true;
        desc = "Recent";
      }
      # git
      {
        key = "<leader>gb";
        action = "function() Snacks.picker.git_branches() end";
        mode = "n";
        lua = true;
        desc = "Git Branches";
      }
      {
        key = "<leader>gl";
        action = "function() Snacks.picker.git_log() end";
        mode = "n";
        lua = true;
        desc = "Git Log";
      }
      {
        key = "<leader>gL";
        action = "function() Snacks.picker.git_log_line() end";
        mode = "n";
        lua = true;
        desc = "Git Log Line";
      }
      {
        key = "<leader>gs";
        action = "function() Snacks.picker.git_status() end";
        mode = "n";
        lua = true;
        desc = "Git Status";
      }
      {
        key = "<leader>gS";
        action = "function() Snacks.picker.git_stash() end";
        mode = "n";
        lua = true;
        desc = "Git Stash";
      }
      {
        key = "<leader>gd";
        action = "function() Snacks.picker.git_diff() end";
        mode = "n";
        lua = true;
        desc = "Git Diff (Hunks)";
      }
      {
        key = "<leader>gf";
        action = "function() Snacks.picker.git_log_file() end";
        mode = "n";
        lua = true;
        desc = "Git Log File";
      }
      # gh
      {
        key = "<leader>gi";
        action = "function() Snacks.picker.gh_issue() end";
        mode = "n";
        lua = true;
        desc = "GitHub Issues (open)";
      }
      {
        key = "<leader>gI";
        action = "function() Snacks.picker.gh_issue({ state = \"all\" }) end";
        mode = "n";
        lua = true;
        desc = "GitHub Issues (all)";
      }
      {
        key = "<leader>gp";
        action = "function() Snacks.picker.gh_pr() end";
        mode = "n";
        lua = true;
        desc = "GitHub Pull Requests (open)";
      }
      {
        key = "<leader>gP";
        action = "function() Snacks.picker.gh_pr({ state = \"all\" }) end";
        mode = "n";
        lua = true;
        desc = "GitHub Pull Requests (all)";
      }
      # Grep
      {
        key = "<leader>sb";
        action = "function() Snacks.picker.lines() end";
        mode = "n";
        lua = true;
        desc = "Buffer Lines";
      }
      {
        key = "<leader>sB";
        action = "function() Snacks.picker.grep_buffers() end";
        mode = "n";
        lua = true;
        desc = "Grep Open Buffers";
      }
      {
        key = "<leader>sg";
        action = "function() Snacks.picker.grep() end";
        mode = "n";
        lua = true;
        desc = "Grep";
      }
      {
        key = "<leader>sw";
        action = "function() Snacks.picker.grep_word() end";
        mode = [
          "n"
          "x"
        ];
        lua = true;
        desc = "Visual selection or word";
      }
      # search
      {
        key = "<leader>s\"";
        action = "function() Snacks.picker.registers() end";
        mode = "n";
        lua = true;
        desc = "Registers";
      }
      {
        key = "<leader>s/";
        action = "function() Snacks.picker.search_history() end";
        mode = "n";
        lua = true;
        desc = "Search History";
      }
      {
        key = "<leader>sa";
        action = "function() Snacks.picker.autocmds() end";
        mode = "n";
        lua = true;
        desc = "Autocmds";
      }
      {
        key = "<leader>sc";
        action = "function() Snacks.picker.command_history() end";
        mode = "n";
        lua = true;
        desc = "Command History";
      }
      {
        key = "<leader>sC";
        action = "function() Snacks.picker.commands() end";
        mode = "n";
        lua = true;
        desc = "Commands";
      }
      {
        key = "<leader>sd";
        action = "function() Snacks.picker.diagnostics() end";
        mode = "n";
        lua = true;
        desc = "Diagnostics";
      }
      {
        key = "<leader>sD";
        action = "function() Snacks.picker.diagnostics_buffer() end";
        mode = "n";
        lua = true;
        desc = "Buffer Diagnostics";
      }
      {
        key = "<leader>sh";
        action = "function() Snacks.picker.help() end";
        mode = "n";
        lua = true;
        desc = "Help Pages";
      }
      {
        key = "<leader>sH";
        action = "function() Snacks.picker.highlights() end";
        mode = "n";
        lua = true;
        desc = "Highlights";
      }
      {
        key = "<leader>si";
        action = "function() Snacks.picker.icons() end";
        mode = "n";
        lua = true;
        desc = "Icons";
      }
      {
        key = "<leader>sj";
        action = "function() Snacks.picker.jumps() end";
        mode = "n";
        lua = true;
        desc = "Jumps";
      }
      {
        key = "<leader>sk";
        action = "function() Snacks.picker.keymaps() end";
        mode = "n";
        lua = true;
        desc = "Keymaps";
      }
      {
        key = "<leader>sl";
        action = "function() Snacks.picker.loclist() end";
        mode = "n";
        lua = true;
        desc = "Location List";
      }
      {
        key = "<leader>sm";
        action = "function() Snacks.picker.marks() end";
        mode = "n";
        lua = true;
        desc = "Marks";
      }
      {
        key = "<leader>sM";
        action = "function() Snacks.picker.man() end";
        mode = "n";
        lua = true;
        desc = "Man Pages";
      }
      {
        key = "<leader>sp";
        action = "function() Snacks.picker.lazy() end";
        mode = "n";
        lua = true;
        desc = "Search for Plugin Spec";
      }
      {
        key = "<leader>sq";
        action = "function() Snacks.picker.qflist() end";
        mode = "n";
        lua = true;
        desc = "Quickfix List";
      }
      {
        key = "<leader>sR";
        action = "function() Snacks.picker.resume() end";
        mode = "n";
        lua = true;
        desc = "Resume";
      }
      {
        key = "<leader>su";
        action = "function() Snacks.picker.undo() end";
        mode = "n";
        lua = true;
        desc = "Undo History";
      }
      {
        key = "<leader>uC";
        action = "function() Snacks.picker.colorschemes() end";
        mode = "n";
        lua = true;
        desc = "Colorschemes";
      }
      # LSP
      {
        key = "gd";
        action = "function() Snacks.picker.lsp_definitions() end";
        mode = "n";
        lua = true;
        desc = "Goto Definition";
      }
      {
        key = "gD";
        action = "function() Snacks.picker.lsp_declarations() end";
        mode = "n";
        lua = true;
        desc = "Goto Declaration";
      }
      {
        key = "gr";
        action = "function() Snacks.picker.lsp_references() end";
        mode = "n";
        lua = true;
        desc = "References";
      }
      {
        key = "gI";
        action = "function() Snacks.picker.lsp_implementations() end";
        mode = "n";
        lua = true;
        desc = "Goto Implementation";
      }
      {
        key = "gy";
        action = "function() Snacks.picker.lsp_type_definitions() end";
        mode = "n";
        lua = true;
        desc = "Goto T[y]pe Definition";
      }
      {
        key = "gai";
        action = "function() Snacks.picker.lsp_incoming_calls() end";
        mode = "n";
        lua = true;
        desc = "C[a]lls Incoming";
      }
      {
        key = "gao";
        action = "function() Snacks.picker.lsp_outgoing_calls() end";
        mode = "n";
        lua = true;
        desc = "C[a]lls Outgoing";
      }
      {
        key = "<leader>ss";
        action = "function() Snacks.picker.lsp_symbols() end";
        mode = "n";
        lua = true;
        desc = "LSP Symbols";
      }
      {
        key = "<leader>sS";
        action = "function() Snacks.picker.lsp_workspace_symbols() end";
        mode = "n";
        lua = true;
        desc = "LSP Workspace Symbols";
      }
      # Other
      {
        key = "<leader>z";
        action = "function() Snacks.zen() end";
        mode = "n";
        lua = true;
        desc = "Toggle Zen Mode";
      }
      {
        key = "<leader>Z";
        action = "function() Snacks.zen.zoom() end";
        mode = "n";
        lua = true;
        desc = "Toggle Zoom";
      }
      {
        key = "<leader>.";
        action = "function() Snacks.scratch() end";
        mode = "n";
        lua = true;
        desc = "Toggle Scratch Buffer";
      }
      {
        key = "<leader>S";
        action = "function() Snacks.scratch.select() end";
        mode = "n";
        lua = true;
        desc = "Select Scratch Buffer";
      }
      {
        key = "<leader>bd";
        action = "function() Snacks.bufdelete() end";
        mode = "n";
        lua = true;
        desc = "Delete Buffer";
      }
      {
        key = "<leader>cR";
        action = "function() Snacks.rename.rename_file() end";
        mode = "n";
        lua = true;
        desc = "Rename File";
      }
      {
        key = "<leader>gB";
        action = "function() Snacks.gitbrowse() end";
        mode = [
          "n"
          "v"
        ];
        lua = true;
        desc = "Git Browse";
      }
      {
        key = "<leader>gg";
        action = "function() Snacks.lazygit() end";
        mode = "n";
        lua = true;
        desc = "Lazygit";
      }
      {
        key = "<leader>un";
        action = "function() Snacks.notifier.hide() end";
        mode = "n";
        lua = true;
        desc = "Dismiss All Notifications";
      }
      {
        key = "<c-/>";
        action = "function() Snacks.terminal() end";
        mode = "n";
        lua = true;
        desc = "Toggle Terminal";
      }
      {
        key = "<c-_>";
        action = "function() Snacks.terminal() end";
        mode = "n";
        lua = true;
        desc = "which_key_ignore";
      }
      {
        key = "]]";
        action = "function() Snacks.words.jump(vim.v.count1) end";
        mode = [
          "n"
          "t"
        ];
        lua = true;
        desc = "Next Reference";
      }
      {
        key = "[[";
        action = "function() Snacks.words.jump(-vim.v.count1) end";
        mode = [
          "n"
          "t"
        ];
        lua = true;
        desc = "Prev Reference";
      }
    ];
  };
}
