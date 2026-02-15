return {
    {
        "folke/snacks.nvim",
        opts = {
            picker = {
                ignored = true,
                hidden = true,
                sources = {
                    explorer = {
                        layout = {
                            layout = {
                                width = 25, -- your desired width
                                min_width = 25,
                                -- optional: position = "right" to show on the right
                            },
                        },
                    },
                    files = {
                        hidden = true, -- Show hidden/dotfiles
                        ignored = false, -- Respect .gitignore
                    },
                    grep = {
                        hidden = true, -- Also search in hidden files
                        ignored = false,
                    },
                },
            },
            scroll = { enabled = false }, -- scrolling animations
        },
    },
}
