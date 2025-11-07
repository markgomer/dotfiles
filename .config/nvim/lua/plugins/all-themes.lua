return {
  -- Load all theme plugins but don't apply them
  -- This ensures all colorschemes are available for hot-reloading
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "ribru17/bamboo.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
  },
  {
    "sainnhe/everforest",
    lazy = true,
    priority = 1000,
  },
  {
    "kepano/flexoki-neovim",
    lazy = true,
    priority = 1000,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "tahayvr/matteblack.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "shaunsingh/nord.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    priority = 1000,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        term_colors = true, -- Change terminal color as per the selected theme style
        ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
        style = "deep", -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
        code_style = {
          comments = "italic",
          keywords = "none",
          functions = "none",
          strings = "none",
          variables = "none",
        },
        highlights = {
          ["@lsp.type.variable"] = { fg = "$red" },
          ["@variable"] = { fg = "$red" },
        },
      })
    end,
  },
}
