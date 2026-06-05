return {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
        -- Ensure servers table exists
        opts.servers = opts.servers or {}
        opts.inlay_hints = { enabled = false }

        -- Inject clangd config without wiping other servers
        opts.servers.clangd = {
            mason = false, -- Tell LazyVim skip Mason install
            cmd = { "clangd" },
        }
        opts.servers.nixd = {
            settings = {
                nixd = {
                    nixpkgs = { expr = "import <nixpkgs> { }" },
                    formatting = { command = { "alejandra" } },
                },
            },
        }
    end,
}
