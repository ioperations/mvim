return {
  -- NOTE: plugins here require little to no configuratin

  "nvim-lua/plenary.nvim",
  "mfussenegger/nvim-dap",
  "rust-lang/rust.vim",
  "simrat39/rust-tools.nvim",
  {
    "saecki/crates.nvim",
    version = "v0.3.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      })
    end,
  },

  "tpope/vim-fugitive",
  "tpope/vim-surround",

  -- NOTE: disabled for now as not working with nvim window bindings
  -- "knubie/vim-kitty-navigator",
  "windwp/nvim-spectre", -- Spectre for find and replace
  "mhartington/formatter.nvim",
  "delphinus/vim-firestore",
  "goolord/alpha-nvim",
  "andweeb/presence.nvim",
  "kyazdani42/nvim-web-devicons",

  { "ray-x/lsp_signature.nvim" },
  {
    "ErichDonGubler/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },

  -- task

  "tpope/vim-dotenv",
  "skywind3000/asynctasks.vim",
  "skywind3000/asyncrun.vim",
  "skywind3000/asyncrun.extra",
  "voldikss/vim-floaterm",

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

  "gcmt/wildfire.vim",
  "p00f/clangd_extensions.nvim",
  -- Useful status updates for LSP
  { "j-hui/fidget.nvim", opts = { window = { border = "rounded", blend = 0 } } },
  { "numToStr/Comment.nvim", opts = {} },
  "rmagatti/auto-session",
  "airblade/vim-gitgutter",
  "weilbith/nvim-code-action-menu",
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup()
    end,
  },
}
