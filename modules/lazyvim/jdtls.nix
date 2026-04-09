{ pkgs, ... }:
{
  programs.lazyvim = {
    extraPackages = with pkgs; [
      jdt-language-server
      vscode-extensions.vscjava.vscode-java-dependency
    ];
    extras = {
      lang = {
        java.enable = true;
      };
    };

    plugins.jdtls = ''
      local bundles = {}
      local jar_patterns = {
        "${pkgs.vscode-extensions.vscjava.vscode-java-dependency}/share/vscode/extensions/vscjava.vscode-java-dependency/server/com.microsoft.jdtls.ext.core-*.jar",
      }
      for _, jar_pattern in ipairs(jar_patterns) do
        for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
          table.insert(bundles, bundle)
        end
      end
      return {
        "mfussenegger/nvim-jdtls",
        opts = function(_, opts)
          opts.jdtls = {
            settings = {
              java = {
                configuration = {
                  runtimes = {
                    { name = "JavaSE-1.8", path = "/usr/lib/jvm/java-8-openjdk" },
                    { name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk", default = true },
                  },
                },
              },
            },
          }
          opts.init_options = {
            bundles = bundles,
          }
        end,
      }
    '';
  };

  # plugins.java-deps = ''
  #   return {
  #     {
  #       "g0ne150/java-deps.nvim",
  #       -- dir = "~/myspace/neovim/java-deps.nvim/",
  #       dependencies = {
  #         "folke/snacks.nvim",
  #         # {
  #         #   "mason-org/mason.nvim",
  #         #   opts = { ensure_installed = { "vscode-java-dependency" } },
  #         # },
  #       },
  #       config = function()
  #         -- require("java-deps").setup()
  #       end,
  #     },
  #   }
  # '';
}
