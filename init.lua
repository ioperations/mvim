-- basic settings and options
vim.opt.rtp:remove(vim.fn.expand("$HOME") .. "/.config/nvim")
vim.opt.rtp:remove(vim.fn.expand("$HOME") .. "/.config/nvim/after")

vim.opt.rtp:append(vim.fn.expand("$HOME") .. "/.config/mvim")
require("options")

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy_opts = {
    ui = { border = "rounded" },
    lockfile = vim.fn.expand("$HOME") .. "/.config/mvim/lazy-lock.json",
    performance = { rtp = { reset = false } },
}

require("lazy").setup("plugins", lazy_opts)

-- keymappings
require("keymappings")
