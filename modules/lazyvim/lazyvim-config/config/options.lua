-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.o.completeopt = "menuone,noselect,preview"

-- LazyVim auto formart
vim.g.autoformat = false

-- Enable the option to require a Prettier config file
-- If no prettier config file is found, the formatter will not be used
vim.g.lazyvim_prettier_needs_config = false

LazyVim.terminal.setup("bash")

local opt = vim.opt

-- opt.guifont = "UbuntuMono Nerd Font Mono:h14"
-- opt.guifont = "FiraCode Nerd Font:h12"

opt.spell = false
opt.spelllang = { "en", "cjk" }
opt.shiftwidth = 4 -- Size of an indent
opt.tabstop = 4 -- Number of spaces tabs count for
opt.wrap = true
opt.mouse = ""
-- opt.clipboard = ""
