return {

  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
  {
    "nvim-telescope/telescope.nvim",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "rmagatti/session-lens",
      "nvim-telescope/telescope-file-browser.nvim",
      "BurntSushi/ripgrep",
    },
    lazy = false,

    opts = {
      defaults = {

        file_ignore_patterns = { ".git/", "node_modules/", "env/", "target/", "build", "cmake-build*/" }, -- ignore git
        winblend = 0,
        prompt_prefix = " ",
        selection_caret = " ",
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/",
        },

        color_devicons = true,
        --      mappings = {
        --         i = {
        --
        --           ["<C-n>"] = require("telescope.actions").move_selection_next,
        --           ["<C-p>"] = require("telescope.actions").move_selection_previous,
        --           ["<C-Down>"] = function(...)
        --             return require("telescope.actions").cycle_history_next(...)
        --           end,
        --           ["<C-Up>"] = function(...)
        --             return require("telescope.actions").cycle_history_prev(...)
        --           end,
        --           ["<C-f>"] = function(...)
        --             return require("telescope.actions").preview_scrolling_down(...)
        --           end,
        --           ["<C-b>"] = function(...)
        --             return require("telescope.actions").preview_scrolling_up(...)
        --           end,
        --         },
        --         n = {
        --           ["q"] = function(...)
        --             return require("telescope.actions").close(...)
        --           end,
        --
        --           ["<C-n>"] = require("telescope.actions").move_selection_next,
        --           ["<C-p>"] = require("telescope.actions").move_selection_previous,
        --         },
        --       },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
    },

    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      telescope.load_extension("session-lens")
      telescope.load_extension("file_browser")
    end,
  },
}
