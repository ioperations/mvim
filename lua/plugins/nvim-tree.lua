return {
  {
    "kyazdani42/nvim-tree.lua",
    opts = {
      auto_reload_on_write = false,
      disable_netrw = false,
      hijack_cursor = false,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      ignore_buffer_on_setup = false,
      sort_by = "name",

      view = {
        adaptive_size = true,
        mappings = {
          list = {
            { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
            { key = "h", action = "close_node" },
            { key = "v", action = "vsplit" },
            { key = "C", action = "cd" },
          },
        },
      },
      diagnostics = {
        enable = true,
        icons = {
          hint = " ",
          info = " ",
          warning = " ",
          error = " ",
        },
      },
      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      renderer = {
        icons = {
          show = {
            folder_arrow = false,
          },
        },
        highlight_git = true,
        highlight_opened_files = "all",
        indent_markers = {
          enable = true,
          icons = {
            corner = "└ ",
            edge = "│ ",
            none = "  ",
          },
        },
      },
      actions = {
        change_dir = {
          enable = false,
        },
        open_file = {
          quit_on_open = false,
        },
      },
    },
  },
}
