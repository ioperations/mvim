return {
    {
        "kyazdani42/nvim-tree.lua",
        opts = {
            auto_reload_on_write = true,
            disable_netrw = false,
            hijack_cursor = true,
            hijack_netrw = true,
            hijack_unnamed_buffer_when_opening = false,
            -- ignore_buffer_on_setup = false,
            sort_by = "name",
            root_dirs = {},
            prefer_startup_root = false,
            sync_root_with_cwd = true,
            reload_on_bufenter = true,
            respect_buf_cwd = true,
            on_attach = "disable",
            remove_keymaps = false,
            select_prompts = false,
            view = {
                adaptive_size = false,
                centralize_selection = false,
                width = 30,
                hide_root_folder = false,
                side = "left",
                preserve_window_proportions = false,
                number = false,
                relativenumber = false,
                signcolumn = "yes",
                mappings = {
                    custom_only = false,
                    list = {
                        { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
                        { key = "h", action = "close_node" },
                        { key = "v", action = "vsplit" },
                        { key = "C", action = "cd" },
                    },
                },
                float = {
                    enable = false,
                    quit_on_focus_loss = true,
                    open_win_config = {
                        relative = "editor",
                        border = "rounded",
                        width = 30,
                        height = 30,
                        row = 1,
                        col = 1,
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
            filesystem_watchers = {
                enable = true,
                debounce_delay = 50,
                ignore_dirs = {},
            },
            update_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = true,
                update_cwd = true,
            },
            renderer = {
                icons = {
                    show = {
                        folder_arrow = true,
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
                        item = "│",
                        none = "  ",
                    },
                },
                special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
                symlink_destination = true,
            },
            actions = {
                use_system_clipboard = true,
                change_dir = {
                    enable = true,
                },
                open_file = {
                    quit_on_open = false,
                },
            },
        },
    },
}
