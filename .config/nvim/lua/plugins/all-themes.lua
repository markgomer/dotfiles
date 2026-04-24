return {
    -- Load all theme plugins but don't apply them
    -- This ensures all colorschemes are available for hot-reloading
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "tokyonight",
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
        "bjarneo/ethereal.nvim",
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
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        priority = 1000,
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        -- priority = 1000,
        opts = {
            transparent = true,
            style = "moon",
            styles = {
                sidebars = "transparent",
                floats = "transparent",
                -- Style to be applied to different syntax groups
                -- Value is any valid attr-list value for `:help nvim_set_hl`
                comments = { italic = true },
                keywords = { italic = true },
                functions = {},
                variables = {},
            },
            on_highlights = function(hl, c)
                hl["@variable"]           = { fg = "#FF5599" }
                hl["@tag.tsx"]            = { fg = "#FF5599"}
                -- hl["@variable.builtin"]   = { fg = dark_red }
                -- hl["@variable.member"]    = { fg = dark_red }
                -- hl["@variable.parameter"] = { fg = dark_red }
                -- hl["Identifier"]          = { fg = dark_red }
            end,
        },
    },
    {
        "navarasu/onedark.nvim",
        config = function()
            require("onedark").setup({
                term_colors = true, -- Change terminal color as per the selected theme style
                ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
                style = "cool", -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
                -- Change code style ---
                -- Options are italic, bold, underline, none
                -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
                code_style = {
                    comments = "italic",
                    keywords = "none",
                    functions = "bold",
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
