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
  "airblade/vim-gitgutter",
  "tpope/vim-fugitive",
}
