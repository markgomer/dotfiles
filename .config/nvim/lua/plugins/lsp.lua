return {
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            opts.servers = opts.servers or {}
            opts.servers = {
                clangd = {
                    mason = false, -- Don't use Mason's clangd
                },
                nixd = {
                    settings = {
                        nixd = {
                            nixpkgs = {
                                expr = "import <nixpkgs> { }",
                            },
                            formatting = {
                                command = { "alejandra" },
                            },
                        },
                    },
                },
            }
        end,
    },
}
