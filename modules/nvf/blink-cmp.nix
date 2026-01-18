{ ... }:
{
  programs.nvf.settings = {
    vim.autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      setupOpts = {
        signature.enabled = true;
      };

      # 快捷键映射（默认值）
      # mappings = {
      #   complete = "<C-Space>"; # 触发补全
      #   confirm = "<CR>"; # 确认选择
      #   next = "<Tab>"; # 选择下一项
      #   previous = "<S-Tab>"; # 选择上一项
      #   close = "<C-e>"; # 关闭补全菜单
      #   scrollDocsUp = "<C-d>"; # 向上滚动文档
      #   scrollDocsDown = "<C-f>"; # 向下滚动文档
      # };
    };
  };
}
