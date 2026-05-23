return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "tokyonight",
        },
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
            on_highlights = function(hl, _)
                hl["@variable"] = { fg = "#FF5599" }
                hl["@tag.tsx"] = { fg = "#FF5599" }
                -- hl["@variable.builtin"]   = { fg = dark_red }
                -- hl["@variable.member"]    = { fg = dark_red }
                -- hl["@variable.parameter"] = { fg = dark_red }
                -- hl["Identifier"]          = { fg = dark_red }
            end,
        },
    },
}
