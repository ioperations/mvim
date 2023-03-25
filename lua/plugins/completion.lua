return {
  {

    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lua", -- nvim config completions
      "saadparwaiz1/cmp_luasnip", -- snippets completions
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hhrsh7th/cmp-buffer",
      "hhrsh7th/cmp-path",
      "hhrsh7th/cmp-cmdline",

      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind-nvim",
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true }, -- tailwind color in suggesions
    },
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")

      local lspkind = require("lspkind")
      local luasnip = require("luasnip")

      -- html snippets in javascript and javascriptreact
      luasnip.filetype_extend("javascriptreact", { "html" })
      luasnip.filetype_extend("typescriptreact", { "html" })

      local loader = require("luasnip/loaders/from_snipmate")
      loader.lazy_load()

      -- load snippets from path/of/your/nvim/config/my-cool-snippets
      loader.lazy_load({ path = vim.fn.expand("$HOME") .. "/.config/nvim/snippets/" })

      require("luasnip/loaders/from_vscode").lazy_load()

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            ellipsis_char = "...",
            maxwidth = 50,
            before = function(entry, vim_item)
              vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
              return vim_item
            end,
          }),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-k>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "c", "s" }),
          ["<C-j>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "c", "s" }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              -- cmp.complete()
              fallback()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),

          ["<C-e>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({
            -- behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        experimental = {
          ghost_text = true,
        },
        window = {
          documentation = cmp.config.window.bordered(),
        },
      })

      -- only enable nvim_lsp in lua files
      vim.cmd(
        [[ autocmd FileType lua lua require'cmp'.setup.buffer { sources = { { name = 'buffer' },{ name = 'nvim_lua'},{name = "nvim_lsp"}},} ]]
      )

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}
