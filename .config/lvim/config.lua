-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.timeoutlen = 300
vim.opt.updatetime = 50

vim.opt.nu = true -- show line numbers
vim.opt.relativenumber = true

vim.opt.clipboard="unnamed,unnamedplus"

--- 
-- Tabulation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- Use spaces instead of tabs by default

---
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
      vim.opt_local.tabstop = 2
      vim.opt_local.softtabstop = 2
      vim.opt_local.shiftwidth = 2
   end,
})

vim.opt.hlsearch = false -- highlight search
vim.opt.incsearch = true -- incremental search

vim.opt.termguicolors = true

vim.opt.colorcolumn = "80" -- the limit black bar
vim.opt.wrap = true

lvim.colorscheme = "onedark"

lvim.plugins = {
   { "navarasu/onedark.nvim" },
   { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
   { "rebelot/kanagawa.nvim" },
   {
      "lukas-reineke/indent-blankline.nvim",
      enabled = false,
   },
   {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" },
   },
}
