return {

  -- NOTE: plugins here require little to no configuratin

  "nvim-lua/plenary.nvim",

  -- NOTE: disabled for now as not working with nvim window bindings
  -- "knubie/vim-kitty-navigator",
  "windwp/nvim-spectre", -- Spectre for find and replace
  "mhartington/formatter.nvim",
  "delphinus/vim-firestore",
  "goolord/alpha-nvim",
  "andweeb/presence.nvim",

  -- looking
  "christianchiarulli/nvim-ts-rainbow",
  "kyazdani42/nvim-web-devicons",

  -- edit enhancement
  "gcmt/wildfire.vim",
  "mg979/vim-visual-multi",
  "junegunn/vim-easy-align",

  -- TODO: this should be refactoed
  "rmagatti/auto-session",

  -- git
  -- "f-person/git-blame.nvim",
  "airblade/vim-gitgutter",
  "tpope/vim-fugitive",
  "tpope/vim-surround",

  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end,
  },

  { "numToStr/Comment.nvim", opts = {} },
  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup()
    end,
  },
}
