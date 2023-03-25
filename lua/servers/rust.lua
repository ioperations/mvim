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
        local opt = require("plugins.lsp_signatures").opt
        require("lsp_signature").on_attach(opt, bufnr)

        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        local wk = require("which-key")
        wk.register({
          l = {
            name = "Lsp",
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
