return {
    "snacks.nvim",
    opts = {
        indent = { enabled = true },
        picker = {
            ignored = true,
            hidden = true,
            sources = {
                explorer = {
                    layout = {
                        layout = {
                            width = 25,
                            min_width = 25,
                        },
                    },
                },
                files = {
                    hidden = true, -- Show hidden/dotfiles
                    ignored = false, -- Don't respect .gitignore
                },
                grep = {
                    hidden = true, -- Also search in hidden files
                    ignored = false,
                },
            },
        },
        scroll = { enabled = false }, -- scrolling animations
    },
}
