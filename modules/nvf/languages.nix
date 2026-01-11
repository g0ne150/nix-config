{ ... }:
{
  programs.nvf.settings = {
    vim.languages = {

      enableTreesitter = true;
      enableFormat = true;

      bash.enable = true;
      nix.enable = true;
      markdown.enable = true;
      lua.enable = true;
      json.enable = true;
      yaml.enable = true;
      java.enable = true;

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
