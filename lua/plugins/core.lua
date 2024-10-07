local colorscheme = require("lazyvim.plugins.colorscheme")
return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
            transparent = true,
        },
    },
    {
        "xiyaowong/transparent.nvim",
    },
    {
        "habamax/vim-godot",
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                gleam = {},
            },
        },
    },
}
