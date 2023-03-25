local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(
  _, -- client
  bufnr
)
  local opt = require("plugins.lsp_signatures").opt
  require("lsp_signature").on_attach(opt, bufnr)

  --   local wk = require("which-key")
  --  wk.register({
  --    l = {
  --      name = "Lsp",
  --      x = { require("rust-tools").expand_macro.expand_macro, "expand macro" },
  --    },
  --  }, { prefix = "<leader>" })
end

require("clangd_extensions").setup({
  server = {
    -- options to pass to nvim-lspconfig
    on_attach = on_attach,
    sources = {
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "luasnip" },
      { name = "cmp_tabnine" },
      { name = "nvim_lua" },
      { name = "buffer" },
      { name = "calc" },
      { name = "emoji" },
      { name = "treesitter" },
      { name = "crates" },
      { name = "tmux" },
    },
    cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",

      "--all-scopes-completion",
      "--completion-style=detailed",
    },
    --    "--compile-commands-dir=" .. vim.g.cmake_build_dir }, -- custom build dir
    capabilities = capabilities,
    trace = "verbose",
    -- FIXME: seems not working in current lspconfig , should add to ~/.local/share/lunarvim/site/pack/lazy/opt/nvim-lspconfig/lua/lspconfig/server_configurations/clangd.lua
    init_options = {
      fallbackFlags = {
        "-isystem/usr/local/include",
        "-isystem/opt/homebrew/opt/llvm/bin/../include/c++/v1",
        "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include",
        "-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX13.sdk/System/Library/Frameworks",
        "-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX13.sdk/usr/include",
        "-isystem/opt/homebrew/Cellar/llvm/15.0.7_1/lib/clang/15.0.7_1/include",
        "/opt/homebrew/Cellar/llvm/15.0.7_1/lib/clang/15.0.7_1/include",
        "-I/opt/homebrew/Cellar/llvm/15.0.7_1/include",
        "-Wall",
        "-DTEST_ADQ",
        "-Wall",
        "-Wpedantic",
        "-std=c++20",
      },
    },
  },
  extensions = {
    -- defaults:
    -- Automatically set inlay hints (type hints)
    autoSetHints = true,
    -- These apply to the default ClangdSetInlayHints command
    inlay_hints = {
      -- Only show inlay hints for the current line
      only_current_line = false,
      -- Event which triggers a refersh of the inlay hints.
      -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
      -- not that this may cause  higher CPU usage.
      -- This option is only respected when only_current_line and
      -- autoSetHints both are true.
      only_current_line_autocmd = "CursorHold",
      -- whether to show parameter hints with the inlay hints or not
      show_parameter_hints = true,
      -- prefix for parameter hints
      parameter_hints_prefix = "<- ",
      -- prefix for all the other hints (type, chaining)
      other_hints_prefix = "=> ",
      -- whether to align to the length of the longest line in the file
      max_len_align = false,
      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,
      -- whether to align to the extreme right or not
      right_align = false,
      -- padding from the right if right_align is true
      right_align_padding = 7,
      -- The color of the hints
      highlight = "Comment",
      -- The highlight group priority for extmark
      priority = 100,
    },
    ast = {
      role_icons = {
        type = "",
        declaration = "",
        expression = "",
        specifier = "",
        statement = "",
        ["template argument"] = "",
      },
      kind_icons = {
        Compound = "",
        Recovery = "",
        TranslationUnit = "",
        PackExpansion = "",
        TemplateTypeParm = "",
        TemplateTemplateParm = "",
        TemplateParamObject = "",
      },
      highlights = {
        detail = "Comment",
      },
      memory_usage = {
        border = "none",
      },
      symbol_info = {
        border = "none",
      },
    },
  },
})
