return {
    -- winbar
    "SmiteshP/nvim-navic",
    dependencies = {
        "nvim-web-devicons",
    },
    config = function()
        local navic = require("nvim-navic")
        navic.setup({
            depth_limit = 0,
            depth_limit_indicator = "..",
            highlight = true,
            lsp = {
                attach = true,
            },
            icons = {
                Array = " ",
                Boolean = " ",
                Class = " ",
                Color = " ",
                Constant = " ",
                Constructor = " ",
                Enum = " ",
                EnumMember = " ",
                Event = " ",
                Field = " ",
                File = " ",
                Folder = "󰉋 ",
                Function = " ",
                Interface = " ",
                Key = " ",
                Keyword = " ",
                Method = " ",
                Module = " ",
                Namespace = " ",
                Null = "󰟢 ",
                Number = " ",
                Object = " ",
                Operator = " ",
                Package = " ",
                Property = " ",
                Reference = " ",
                Snippet = " ",
                String = " ",
                Struct = " ",
                Text = " ",
                TypeParameter = " ",
                Unit = " ",
                Value = " ",
                Variable = " ",
            },
            separator = "  ",
        })
    end,
}
