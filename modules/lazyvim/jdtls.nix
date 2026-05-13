# jdtls 相关问题，记得先运行 `:JdtWipeDataAndRestart` 重试
{ pkgs, lib, ... }:
let
  vscode-extension-path = "share/vscode/extensions";
  vscode-spring-boot = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    # https://open-vsx.org/api/VMware/vscode-spring-boot/2.2.2026040900/file/VMware.vscode-spring-boot-2.2.2026040900.vsix
    mktplcRef = {
      name = "vscode-spring-boot";
      publisher = "VMware";
      version = "2.2.2026040900";
      sha256 = "sha256-SgR31YlrMd09RhDIPxx9J5Y8WZ6H9cO6qvRoOULsZ6A=";
      # sha256 = lib.fakeSha256;
    };
  };
  vscode-spring-boot-path = "${vscode-spring-boot}/${vscode-extension-path}/VMware.vscode-spring-boot";
  vscode-spring-boot-path-jars = "${vscode-spring-boot-path}/jars";
in
{
  programs.lazyvim = {
    extraPackages =
      with pkgs;
      [
        jdt-language-server
        vscode-extensions.vscjava.vscode-java-dependency
      ]
      ++ [ vscode-spring-boot ];
    extras = {
      lang = {
        java.enable = true;
      };
    };

    plugins.jdtls = ''
      local bundles = {}
      local jar_patterns = {
        "${pkgs.vscode-extensions.vscjava.vscode-java-dependency}/${vscode-extension-path}/vscjava.vscode-java-dependency/server/com.microsoft.jdtls.ext.core-*.jar",
        "${vscode-spring-boot-path-jars}/io.projectreactor.reactor-core.jar",
        "${vscode-spring-boot-path-jars}/org.reactivestreams.reactive-streams.jar",
        "${vscode-spring-boot-path-jars}/jdt-ls-commons.jar",
        "${vscode-spring-boot-path-jars}/jdt-ls-extension.jar",
        "${vscode-spring-boot-path-jars}/sts-gradle-tooling.jar",
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

    plugins.spring-boot = ''
      return {
        {
          "JavaHello/spring-boot.nvim",
          ft = { "java", "yaml", "jproperties" },
          dependencies = {
            "mfussenegger/nvim-jdtls", -- or nvim-java, nvim-lspconfig
          },
          ---@type bootls.Config
          opts = function()
            return {
              ls_path = require("spring_boot").get_boot_ls("${vscode-spring-boot-path}/language-server"),
            }
          end,
        },
      }
    '';
  };
}
