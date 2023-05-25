M = {}
local llvm_version = "16"

local fallbackFlags = {
    "-L/usr/local/lib/",
    "-isystem/usr/local/include",
    "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../include/c++/v1",
    "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/14.0.3/include",
    "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include",
    "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include",
    "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks",
    "-O3",
    "-isystem/usr/local/include",
    "-isystem/opt/homebrew/opt/llvm/bin/../include/c++/v1",
    "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include",
    "-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks",
    "-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include",
    "-isystem/opt/homebrew/opt/llvm/" .. "/lib/clang/" .. llvm_version .. "/include",
    "-I/opt/homebrew/opt/llvm/" .. "/lib/clang/" .. llvm_version .. "/include",
    "-I/opt/homebrew/opt/llvm/" .. llvm_version .. "/include",
    "-Wall",
    "-DTEST_ADQ",
    "-Wall",
    "-Wpedantic",
    "-std=c++20",
}

if vim.fn.has("mac") == 1 then
    -- darwin: libc++ + lldb
    -- linux : libstdc++ + gdb
    table.insert(fallbackFlags, "-stdlib=libc++")
end

M.enable = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.offsetEncoding = "utf-8"

    local on_attach = function(client, bufnr)
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
            --sources = {
            --    { name = "nvim_lsp" },
            --    { name = "path" },
            --    { name = "luasnip" },
            --    { name = "cmp_tabnine" },
            --    { name = "nvim_lua" },
            --    { name = "buffer" },
            --    { name = "calc" },
            --    { name = "emoji" },
            --    { name = "treesitter" },
            --    { name = "crates" },
            --    { name = "tmux" },
            --},
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
            init_options = {
                fallbackFlags = fallbackFlags,
            },
        },
        extensions = {
            -- defaults:
            -- Automatically set inlay hints (type hints)
            autoSetHints = true,
            -- These apply to the default ClangdSetInlayHints command
            inlay_hints = {
                inline = vim.fn.has("nvim-0.10") == 1,
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
end

return M
