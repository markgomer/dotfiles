-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.timeoutlen = 300
vim.opt.updatetime = 50

vim.opt.nu = true -- show line numbers
vim.opt.relativenumber = true

-- vim.opt.clipboard = "unnamed,unnamedplus"

-- Tabulation
local tabstop = 2
vim.opt.tabstop = tabstop
vim.opt.softtabstop = tabstop
vim.opt.shiftwidth = tabstop
vim.opt.expandtab = true -- Use spaces instead of tabs by default

vim.opt.hlsearch = false -- highlight search
vim.opt.incsearch = true -- incremental search

vim.opt.termguicolors = true

vim.opt.colorcolumn = "80" -- the limit black bar
vim.opt.wrap = true
