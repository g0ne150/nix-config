return {
  "bufferline.nvim",
  keys = {
    {
      "<leader>bb",
      function()
        require("bufferline").pick()
      end,
      desc = "Pick buffers",
    },
  },

  ---@param opts bufferline.Config
  opts = function(_, opts)
    -- bufferline 一直显示
    opts.options.always_show_bufferline = true

    -- 下划线高亮
    opts.options.indicator = {
      -- icon = "▎", -- this should be omitted if indicator style is not 'icon'
      style = "underline",
    }

    -- 数字前缀
    opts.options.numbers = "ordinal"

    -- 指定 pick 命令时使用的字母
    opts.options.pick = { alphabet = "1234567890" }
  end,
}
