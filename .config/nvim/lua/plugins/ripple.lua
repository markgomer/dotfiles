return {
    {
        "Cliffback/ripple-vscode-plugin.nvim",
        config = function()
            require("ripple-lsp").setup({
                -- optional overrides
                -- on_attach = function(client, bufnr) ... end
                treesitter_lang = "tsx",
                set_filetype = true,
            })
        end,
    },
    {
        "Ripple-TS/ripple",
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. "/packages/nvim-plugin")
            require("ripple").setup(plugin)
        end,
    },
}
