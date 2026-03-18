{ pkgs, ... }:
{
  home.packages = with pkgs; [ lombok ];
  home.sessionVariables = {
    JDTLS_JVM_ARGS = "-javaagent:${pkgs.lombok}/share/java/lombok.jar";
  };
  programs.nvf.settings = {
    vim.treesitter.fold = true;
    vim.lsp = {
      enable = true;
      formatOnSave = false;
      inlayHints.enable = true;
      lspconfig.enable = true;
    };

    vim.languages = {

      enableTreesitter = true;
      enableFormat = true;

      bash.enable = true;
      python.enable = true;
      nix.enable = true;
      lua.enable = true;
      json.enable = true;
      yaml.enable = true;
      java.enable = true;
      go.enable = true;
      html.enable = true;
      css.enable = true;
      ts.enable = true;
      zig.enable = true;

    };

    vim.debugger.nvim-dap = {
      enable = true;
      ui.enable = true;

      mappings = {
        # continue = "<leader>dc"; # dc
        # goDown = "<leader>dj"; # dvi
        # goUp = "<leader>dk"; # dvo
        # hover = "dh";
        # restart = "dR";
        # runLast = "<leader>dl"; # d.
        # runToCursor = "<leader>dC"; # dgc
        # stepBack = "dgk";
        # stepInto = "<leader>di"; # dgi
        # stepOut = "<leader>do"; # dgo
        # stepOver = "<leader>dO"; # dgj
        # terminate = "<leader>dt"; # dq
        # toggleBreakpoint = "<leader>db"; # db
        # toggleDapUI = "<leader>du"; # du
        # toggleRepl = "<leader>dr"; # dr
      };
    };

    vim.keymaps = [
      # LSP native keymaps (not Snacks-specific)
      {
        key = "K";
        action = "function() return vim.lsp.buf.hover() end";
        mode = "n";
        lua = true;
        desc = "Hover";
      }
      {
        key = "gK";
        action = "function() return vim.lsp.buf.signature_help() end";
        mode = "n";
        lua = true;
        desc = "Signature Help";
      }
      {
        key = "<c-k>";
        action = "function() return vim.lsp.buf.signature_help() end";
        mode = "i";
        lua = true;
        desc = "Signature Help";
      }
      {
        key = "<leader>ca";
        action = "vim.lsp.buf.code_action";
        mode = [
          "n"
          "x"
        ];
        lua = true;
        desc = "Code Action";
      }
      {
        key = "<leader>cc";
        action = "vim.lsp.codelens.run";
        mode = [
          "n"
          "x"
        ];
        lua = true;
        desc = "Run Codelens";
      }
      {
        key = "<leader>cC";
        action = "vim.lsp.codelens.refresh";
        mode = "n";
        lua = true;
        desc = "Refresh & Display Codelens";
      }
      {
        key = "<leader>cr";
        action = "vim.lsp.buf.rename";
        mode = "n";
        lua = true;
        desc = "Rename";
      }
      {
        key = "<leader>cf";
        action = "vim.lsp.buf.format";
        mode = [
          "n"
          "x"
        ];
        lua = true;
        desc = "Format";
      }
    ];
  };
}
