return {
  { "ellisonleao/gruvbox.nvim" },

  {
    "navarasu/onedark.nvim",
    {
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
    },
  },

  { "rebelot/kanagawa.nvim" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
