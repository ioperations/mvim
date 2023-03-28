return {
    -- welcome
    {
        "goolord/alpha-nvim",
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.startify")

            -- -- Set header
            dashboard.section.header.val = {
                "                                                     ",
                "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                "                                                     ",
            }

            -- Send config to alpha
            alpha.setup(dashboard.opts)

            -- Disable folding on alpha buffer
            vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
        end,
    },

    -- scrollbar
    {
        "karb94/neoscroll.nvim",
        {
            "petertriho/nvim-scrollbar",
            config = function()
                require("scrollbar").setup({})
            end,
        },
    },

    -- edit enhancement
    "gcmt/wildfire.vim",
    -- multi cursor
    "mg979/vim-visual-multi",
    -- easy align
    "junegunn/vim-easy-align",
    -- surround
    "tpope/vim-surround",
    -- undotree
    {
        "mbbill/undotree",
        config = function()
            vim.cmd([[
        if has("persistent_undo")
           let target_path = expand('~/.undodir')
            " create the directory and any parent directories
            " if the location does not exist.
            if !isdirectory(target_path)
                call mkdir(target_path, "p", 0700)
            endif
            let &undodir=target_path
            set undofile
        endif
        ]])
        end,
    },

    -- autopirs
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    -- easy motion
    {
        "phaazon/hop.nvim",
        opts = {
            as = "hop",
            keys = "etovxqpdygfblzhckisuran",
        },
        config = function(_, opts)
            require("hop").setup(opts)
        end,
    },

    -- indent
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup()
        end,
    },

    -- cursorline
    {
        "yamatsum/nvim-cursorline",
        config = function()
            require("nvim-cursorline").setup({
                cursorline = {
                    enable = true,
                    timeout = 1000,
                    number = false,
                },
                cursorword = {
                    enable = true,
                    min_length = 3,
                    hl = { underline = true },
                },
            })
        end,
    },

    -- looking
    {
        "christianchiarulli/nvim-ts-rainbow",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = {
                    -- ...
                },
                -- ...
                rainbow = {
                    enable = true,
                    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                    max_file_lines = nil, -- Do not enable for files with more than n lines, int
                    -- colors = {}, -- table of hex strings
                    -- termcolors = {} -- table of colour name strings
                },
            })
        end,
    },

    -- colorschema
    {
        "lunarvim/lunar.nvim",
        -- lazy = true,
        priority = 1000,
        opts = {
            style = "night",
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
        config = function(_, opts)
            -- require("tokyonight").setup(opts) -- opts here are passed from above
            -- vim.cmd("highlight WinSeparator guifg=" .. colors.bg_highlight)
            vim.cmd([[colorscheme lunar]])
        end,
    },

    -- notify
    {
        "rcarriga/nvim-notify",
        opt = {
            background_colour = "NotifyBackground",
            fps = 30,
            icons = {
                DEBUG = "",
                ERROR = "",
                INFO = "",
                TRACE = "✎",
                WARN = "",
            },
            level = 2,
            minimum_width = 50,
            render = "default",
            -- stages = "fade_in_slide_out",
            stages = "slide",
            timeout = 5000,
            top_down = true,
        },
        config = function(_, opt)
            require("notify").setup(opt)
            vim.notify = require("notify")
        end,
    },

    -- bufline
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
        opts = {
            options = {
                offsets = {
                    {
                        filetype = "NvimTree",
                        -- text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
                diagnostics = "nvim_lsp",
                max_name_length = 22,
                tab_size = 22,
            },
        },
    },

    -- todo fix etc
    { "numToStr/Comment.nvim", opts = {} },
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup()
        end,
    },

    -- task
    {
        "tpope/vim-dotenv",
        "skywind3000/asyncrun.extra",
        "voldikss/vim-floaterm",
        "skywind3000/asynctasks.vim",
        {
            "skywind3000/asyncrun.vim",
            config = function()
                require("scripts")
            end,
        },
    },
}
