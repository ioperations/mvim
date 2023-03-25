return {
  {
    "kyazdani42/nvim-tree.lua",
    opts = {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },

      auto_reload_on_write = true,
      disable_netrw = false,
      hijack_cursor = false,
      hijack_netrw = true,

      git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 200,
      },

      hijack_unnamed_buffer_when_opening = false,
      ignore_buffer_on_setup = false,
      sort_by = "name",

      view = {
        adaptive_size = true,
        width = 30,
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
      renderer = {
        icons = {
          show = {
            folder_arrow = false,
          },
        },
        highlight_git = true,
        indent_width = 2,
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
        use_system_clipboard = true,
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
