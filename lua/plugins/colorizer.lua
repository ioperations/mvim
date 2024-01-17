return {
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure({
                providers = {
                    "lsp",
                    "treesitter",
                    "regex",
                },
                delay = 0,
            })

            vim.api.nvim_exec2([[hi IlluminatedWordText guibg=#3b5eaa guifg=None gui=underline,bold ]], {})
            vim.api.nvim_exec2([[hi illuminatedWord guibg=#3b5eaa guifg=None gui=underline,bold ]], {})
            vim.api.nvim_exec2([[hi IlluminatedWordRead  guibg=#3b5eaa guifg=None gui=underline,bold ]], {})
            vim.api.nvim_exec2([[hi IlluminatedWordWrite  guibg=#3b5eaa guifg=None gui=underline,bold ]], {})
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            filetypes = { "*" },
            user_default_options = {
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                -- Available modes for `mode`: foreground, background,  virtualtext
                mode = "background", -- Set the display mode.
                -- Available methods are false / true / "normal" / "lsp" / "both"
                -- True is same as normal
                tailwind = true, -- Enable tailwind colors
                -- parsers can contain values used in |user_default_options|
                sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
                virtualtext = "■",
            },
            -- all the sub-options of filetypes apply to buftypes
            buftypes = {},
        },
    },
}
