local get_package_install_path = function(package_name)
  return vim.fn.expand("$MASON/packages/" .. package_name)
end

return {
  "mfussenegger/nvim-jdtls",
  opts = function(_, opts)
    opts.jdtls = {
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-1.8",
                path = "/usr/lib/jvm/java-8-openjdk",
              },
              {
                name = "JavaSE-21",
                path = "/usr/lib/jvm/java-21-openjdk",
                default = true,
              },
            },
          },
        },
      },
    }

    local bundles = {}
    if LazyVim.has("mason.nvim") then
      local mason_registry = require("mason-registry")
      local jar_patterns = {}
      if mason_registry.has_package("vscode-java-dependency") then
        local java_deps_path = get_package_install_path("vscode-java-dependency")
        vim.list_extend(jar_patterns, {
          java_deps_path .. "/extension/server/com.microsoft.jdtls.ext.core-*.jar",
        })
      end
      if mason_registry.has_package("vscode-spring-boot-tools") then
        vim.list_extend(jar_patterns, require("spring_boot").java_extensions())
      end

      for _, jar_pattern in ipairs(jar_patterns) do
        for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
          table.insert(bundles, bundle)
        end
      end
    end

    opts.init_options = {
      bundles = bundles,
    }
  end,
}
