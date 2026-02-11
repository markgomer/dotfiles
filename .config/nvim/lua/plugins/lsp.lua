return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          mason = false,  -- Don't use Mason's clangd
        },
      },
    },
  },
}
