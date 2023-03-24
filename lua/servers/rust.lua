local codelldb_path
local liblldb_path

if vim.fn.has("mac") == 1 then
  local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/"
  codelldb_path = extension_path .. "adapter/codelldb"
  liblldb_path = extension_path .. "lldb/lib/liblldb.dylib" -- MacOS: This may be .dylib
else
  local extension_path = vim.env.HOME .. "/.vscode-server/extensions/vadimcn.vscode-lldb-1.8.1/"
  codelldb_path = extension_path .. "adapter/codelldb"
  liblldb_path = extension_path .. "lldb/lib/liblldb.so" -- MacOS: This may be .dylib
end

-- local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
-- local codelldb_adapter = {
--   type = "server",
--   port = "${port}",
--   executable = {
--     command = mason_path .. "bin/codelldb",
--     args = { "--port", "${port}" },
--   },
-- }

vim.g.cargo_run_current_test = "cargo test"

local M = {}
function M.execute_command(command, args, _)
  local args_flatten = " "
  for _, v in pairs(args) do
    args_flatten = args_flatten .. " "
    args_flatten = args_flatten .. v
  end

  local com = command .. args_flatten
  local running = com:gsub("cargo", "make")
  vim.g.cargo_run_current_test = com

  vim.notify("\n running command " .. running, vim.log.levels.INFO)

  vim.cmd("set makeprg=cargo")

  vim.cmd(running)
end

pcall(function()
  require("rust-tools").setup({
    tools = {
      -- executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
      executor = M,
      reload_workspace_from_cargo_toml = true,
      runnables = {
        use_telescope = true,
      },
      inlay_hints = {
        auto = true,
        only_current_line = false,
        show_parameter_hints = true,
        only_current_line_autocmd = "CursorHold",
        show_variable_name = true,
        parameter_hints_prefix = "<-",
        other_hints_prefix = "=>",
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
        highlight = "Comment",
      },
      hover_actions = {
        border = {
          { "╭", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╮", "FloatBorder" },
          { "│", "FloatBorder" },
          { "╯", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╰", "FloatBorder" },
          { "│", "FloatBorder" },
        },
      },
      on_initialized = function()
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
          pattern = { "*.rs" },
          callback = function()
            local _, _ = pcall(vim.lsp.codelens.refresh)
          end,
        })
      end,
    },
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
    server = {
      on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        local wk = require("which-key")

        -- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>") -- or

        --         require("lsp_signature").on_attach({
        -- bind = true, -- This is mandatory, otherwise border config won't get registered.
        --          -- handler_opts = { border = "rounded" },
        --          hint_prefix = "🐶 ",
        --          -- hi_parameter = "Comment",
        --          hi_parameter = "GruvboxOrange",
        --          -- LspSignatureActiveParameter
        --          debug = false, -- set to true to enable debug logging
        --          log_path = vim.fn.stdpath "cache" .. "/lsp_signature.log", -- log dir when debug is on
        --          -- default is  ~/.cache/nvim/lsp_signature.log
        --          verbose = false, -- show debug line number
        --          bind = true, -- This is mandatory, otherwise border config won't get registered.
        --          -- If you want to hook lspsaga or other signature handler, pls set to false
        --          doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
        --          -- set to 0 if you DO NOT want any API comments be shown
        --          -- This setting only take effect in insert mode, it does not affect signature help in normal
        --          -- mode, 10 by default
        --
        --          max_height = 12, -- max height of signature floating_window
        --          max_width = 80, -- max_width of signature floating_window
        --          wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
        --          floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
        --          floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
        --          -- will set to true when fully tested, set to false will use whichever side has more space
        --          -- this setting will be helpful if you do not want the PUM and floating win overlap
        --
        --          floating_window_off_x = 1, -- adjust float windows x position.
        --          floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
        --          close_timeout = 4000, -- close floating window after ms when laster parameter is entered
        --          fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
        --          hint_enable = true, -- virtual hint enable
        --          -- hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
        --          hint_scheme = "String",
        --          -- hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
        --          handler_opts = {
        --            border = "rounded", -- double, rounded, single, shadow, none
        --          },
        --          always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
        --          auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
        --          extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"", ","}
        --          zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
        --          padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
        --          transparency = nil, -- disabled by default, allow floating win transparent value 1~100
        --          shadow_blend = 36, -- if you using shadow as border use this set the opacity
        --          shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
        --          timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
        --          toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
        --          select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
        --          move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
        --        }, bufnr)

        wk.register({
          l = {
            name = "Lsp",
            --            r = { "<cmd>Telescope lsp_references<cr>", "references" },
            --           d = { "<cmd>Telescope lsp_definitions<cr>", "defination" },
            --           D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "declaration" },
            --           i = { "<cmd>Telescope lsp_implementations<cr>", "implementation" },
            --           t = { "<cmd>Telescope lsp_type_definitions<cr>", "type Implementation" },
            --           R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename" },
            --           a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "code action" },
            --           f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "format" },
            --           w = { "<cmd>TroubleToggle<cr>", "trouble" },
            x = { require("rust-tools").expand_macro.expand_macro, "expand macro" },
          },
        }, { prefix = "<leader>" })

        -- lvim.lsp.on_attach_callback(client, bufnr)
      end,
      -- capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          lens = {
            enable = true,
          },
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true,
          },
          diagnostics = {
            disabled = { "unresolved-proc-macro" },
            experimental = {
              enable = true,
            },
          },
          checkOnSave = {
            enable = true,
            command = "clippy",
          },
        },
      },
    },
  })
end)
