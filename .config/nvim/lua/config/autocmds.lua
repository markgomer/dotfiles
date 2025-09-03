-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Autocommand Group for Filetype-Specific Settings
-- We create an autocommand group to ensure that when your Neovim
-- configuration reloads, any old autocommands are cleared first.
-- This prevents duplicate autocommands from being registered.
local filetype_settings_augroup = vim.api.nvim_create_augroup("FileTypeSpecificSettings", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = filetype_settings_augroup,
  -- The 'pattern' accepts a table (list) to target multiple file extensions
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.html" },
  callback = function()
    local tabstop = 4
    vim.opt_local.tabstop = tabstop
    vim.opt_local.softtabstop = tabstop
    vim.opt_local.shiftwidth = tabstop
  end,
})
