return {

    -- git
    -- "f-person/git-blame.nvim",
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
        event = "User FileOpened",
        cmd = "Gitsigns",
    },
    {
        "akinsho/git-conflict.nvim",
        config = function()
            vim.api.nvim_exec([[ hi my_gitdiffadd guibg=#333c3e ]], false)
            require("git-conflict").setup({
                highlights = { -- They must have background color, otherwise the default color will be used
                    incoming = "DiffText",
                    current = "my_gitdiffadd",
                },
            })
        end,
    },

    "airblade/vim-gitgutter",
    "tpope/vim-fugitive",
}
