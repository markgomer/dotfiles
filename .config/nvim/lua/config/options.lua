-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.nu = true -- show line numbers
vim.opt.hlsearch = false -- highlight search
vim.opt.colorcolumn = "80" -- the limit black bar
vim.opt.wrap = true

-- Tabulation
local tabstop = 4
vim.opt.tabstop = tabstop
vim.opt.softtabstop = tabstop
vim.opt.shiftwidth = tabstop

vim.g.autoformat = false
