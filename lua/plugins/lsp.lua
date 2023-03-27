return {
  {
    {
      "j-hui/fidget.nvim",
      opts = {
        window = {
          -- border = "rounded",
          blend = 0,
        },
      },
    },
    { "nvim-lua/lsp-status.nvim", lazy = true },

    -- winbar
    {
      "utilyre/barbecue.nvim",
      name = "barbecue",
      version = "*",
      dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-web-devicons", -- optional dependency
      },
      opts = {
        -- configurations go here
      },
    },
    -- rust
    {
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
    },
    "p00f/clangd_extensions.nvim",
    {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
      end,
    },
    {
      "weilbith/nvim-code-action-menu",
      cmd = "CodeActionMenu",
      config = function()
        vim.g.code_action_menu_window_border = "single"
      end,
    },
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup({})
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup({})

        -- automatic_installation is handled by lsp-manager
        local settings = require("mason-lspconfig.settings")
        settings.current.automatic_installation = true
      end,
    },
    { "tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/neodev.nvim" },
    config = function()
      -- Setup neovim lua configuration
      require("neodev").setup()
      require("servers")

      -- require all language server modules
      -- rounded border on :LspInfo
      require("lspconfig.ui.windows").default_options.border = "rounded"

      -- Customization and appearance -----------------------------------------
      -- change gutter diagnostic symbols
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config({
        virtual_text = {
          source = "if_many",
          prefix = " ", -- Could be '●', '▎', 'x'
          only_current_line = true,
        },
        float = {
          source = "always",
        },
        severity_sort = true,
      })
      local function hover_wrapper(err, request, ctx, config)
        local fun = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
        local bufnr, winnr = fun(err, request, ctx, config)
        if bufnr == nil or winnr == nil then
          return
        end
        local contents = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        contents = vim.tbl_map(function(line)
          return string.gsub(line, "&emsp;", "")
        end, contents)
        vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
        vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
        vim.api.nvim_win_set_height(winnr, #contents)

        return bufnr, winnr
      end

      vim.lsp.handlers["textDocument/hover"] = hover_wrapper

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })
    end,
  },
}
