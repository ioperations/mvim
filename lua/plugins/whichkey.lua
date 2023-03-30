return {
    {
        "folke/which-key.nvim",
        opts = {
            plugins = {
                spelling = {
                    enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                    suggestions = 20, -- how many suggestions should be shown in the list?
                },
            },
            window = {
                border = "single", -- none, single, double, shadow
                position = "bottom", -- bottom, top
                margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
                padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
                -- winblend = 0,
            },
            triggers_blacklist = {
                -- list of mode / prefixes that should never be hooked by WhichKey
                -- this is mostly relevant for key maps that start with a native binding
                -- most people should not need to change this
                i = { "j", "k" },
                v = { "j", "k" },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            -- register key bindings with <leader> prefix
            wk.register({
                f = {
                    -- mostly Telescope bindings
                    name = "Find with Telescope",
                    f = { [[<cmd> lua require"telescope.builtin".find_files({ hidden = true })<CR>]], "Find File" },
                    b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
                    n = { "<cmd>TodoTelescope<cr>", "Find Notes" },
                    t = { "<cmd>Telescope builtin<cr>", "Telescope builtin" },
                    s = { "<cmd>Telescope live_grep<cr>", "Rg" },
                    r = { "<cmd>Telescope lsp_references<cr>", "Find References" },
                    d = { "<cmd>Telescope diagnostics<cr>", "Document Diagnostics" },
                    m = { "<cmd>Telescope marks<CR>", "Marks" },
                    l = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Line find" },
                    k = { "<cmd>Telescope keymaps<CR>", "Key mappings" },
                    M = { "<cmd>Telescope man_pages<CR>", "Man pages" },
                    a = { "<cmd>Telescope session-lens search_session<CR>", "Search Sessions" },
                    h = { "<cmd>Telescope help_tags<CR>", "Search help" },
                    T = { "<cmd>TodoTelescope<CR>", "Search Todos" },
                    e = { "<cmd>Telescope file_browser<CR>", "Browse Files" },
                },
                h = {
                    name = "Git Gutter",
                    p = "Preview Hunk",
                    s = "Stage Hunk",
                    u = "Undo Changes",
                },
                e = { "<cmd>NvimTreeToggle<CR>", "File Tree" },
                u = { "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>", "Undotree" },
                L = { "<cmd>Lazy<CR>", "Lazy" },
                -- trouble bindings
                t = {
                    name = "Trouble",
                    t = { "<cmd>FloatermNew --width=0.8 --height=0.8 <CR>", "Toggle terminal" },
                    r = { "<cmd>Trouble lsp_references<CR>", "References" },
                    d = { "<cmd>Trouble lsp_definitions<CR>", "Definitions" },
                    q = { "<cmd>Trouble quickfix<CR>", "Quickfix" },
                    T = { "<cmd>TodoTrouble<CR>", "Todos" },
                    w = { "<cmd>Trouble workspace_diagnostics<CR>", "Workspace Diagnostics" },
                    D = { "<cmd>Trouble document_diagnostics<CR>", "Document Diagnostics" },
                },
                d = {
                    o = { require("dapui").toggle, "debug ui toggle" },
                },
                r = { r = { "<cmd>FloatermNew --width=0.8 --height=0.8 ranger<cr>", "ranger" } },
                -- Bufferline
                g = {
                    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
                    b = { "<cmd>Git blame<cr>", "Git blame" },

                    m = { require("gitsigns").blame_line, "git message" },
                },
                S = {
                    name = "Spectre - find and replace",
                    s = { "<cmd>lua require('spectre').open_visual()<CR>", "Open Spectre" },
                    w = {
                        "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
                        "Search for word under cursor",
                    },
                },
                l = {
                    name = "LSP",
                    f = { "lua vim.lsp.buf.format({ async = true })<cr>", "Format File" },
                    R = { vim.lsp.buf.rename, "Rename" },
                    D = { vim.lsp.buf.declaration, "declaration" },
                    d = { "<cmd>Telescope lsp_definitions<cr>", "Definition" },
                    r = { "<cmd>Telescope lsp_references<cr>", "References" },
                    i = { "<cmd>Telescope lsp_implementations<cr>", "Implementations" },
                    a = { "<cmd>CodeActionMenu<cr>", "Code actions" },
                    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "Run codelens" },
                    t = { "<cmd>Telescope lsp_type_definitions<cr>", "Type Definition" },
                    n = { '<cmd>lua vim.diagnostic.goto_next({ float = { border = "rounded" } })<cr>', "next error" },
                    p = { '<cmd>lua vim.diagnostic.goto_prev({ float = { border = "rounded" } })<cr>', "next error" },
                    z = { require("lsp_lines").toggle, "Toggle lsp_lines" },
                },
            }, {
                prefix = "<leader>",
            })
        end,
    },
}
