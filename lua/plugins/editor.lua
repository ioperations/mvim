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
        --       local colors = require("tokyonight.colors").setup()
        --
        --       local opt = {
        --         handle = {
        --           color = colors.bg_highlight,
        --         },
        --         marks = {
        --           Search = { color = colors.orange },
        --           Error = { color = colors.error },
        --           Warn = { color = colors.warning },
        --           Info = { color = colors.info },
        --           Hint = { color = colors.hint },
        --           Misc = { color = colors.purple },
        --         },
        --       }
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

  -- colorschema
  {
    "folke/tokyonight.nvim",
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
      require("tokyonight").setup(opts) -- opts here are passed from above
      local colors = require("tokyonight.colors").setup({})
      vim.cmd("highlight WinSeparator guifg=" .. colors.bg_highlight)
      vim.cmd([[colorscheme tokyonight]])
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
    "skywind3000/asynctasks.vim",
    "skywind3000/asyncrun.vim",
    "skywind3000/asyncrun.extra",
    "voldikss/vim-floaterm",
  },
}
