local function register_mappings(mappings, default_options)
  for mode, mode_mappings in pairs(mappings) do
    for _, mapping in pairs(mode_mappings) do
      local options = #mapping == 3 and table.remove(mapping) or default_options
      local prefix, cmd = unpack(mapping)
      pcall(vim.keymap.set, mode, prefix, cmd, options)
    end
  end
end

local function telescope_find_files()
  require("telescope.builtin").find_files({ hidden = true })
end

-- NOTE<cmd> <leader> prefixed mappings are in whichkey-settings.lua

local show_documentation = function()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand("<cword>"))
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand("<cword>"))
  elseif vim.fn.expand("%:t") == "Cargo.toml" then
    require("crates").show_popup()
  else
    vim.lsp.buf.hover()
  end
end

local mappings = {
  i = {
    -- Insert mode
    { "kk", "<ESC>" },
    { "jj", "<ESC>" },
    { "jk", "<ESC>" },
    -- Terminal window navigation
    { "<C-h>", "<C-\\><C-N><C-w>h" },
    { "<C-j>", "<C-\\><C-N><C-w>j" },
    { "<C-k>", "<C-\\><C-N><C-w>k" },
    { "<C-l>", "<C-\\><C-N><C-w>l" },
    -- moving text
    { "<C-j>", "<esc><cmd>m .+1<CR>==" },
    { "<C-k>", "<esc><cmd>m .-2<CR>==" },
    -- Ctrl single quote for backtick
    { "<C-'>", "``<esc>i" },
  },
  n = {
    -- Normal mode
    -- Better window movement
    -- NOTE: replaced with Navigator for Wezterm and Tmux
    -- { "<C-h>", "<C-w>h", { silent = true } },
    -- { "<C-j>", "<C-w>j", { silent = true } },
    -- { "<C-k>", "<C-w>k", { silent = true } },
    -- { "<C-l>", "<C-w>l", { silent = true } },
    -- Resize with arrows

    -- window management
    { "<up>", ":res +5<cr>" },
    { "<down>", ":res -5<cr>" },
    { "<left>", ":vertical resize -5<cr>" },
    { "<right>", ":vertical resize +5<cr>" },

    -- Ctrl + p fuzzy files
    { "<C-p>", telescope_find_files },
    { "<C-g>", "<cmd>Telescope live_grep<cr>" },
    -- escape clears highlighting
    { "<leader>n", "<cmd>noh<cr><esc>" },
    -- hop words
    { "S", "<cmd>HopWord<cr>" },
    { "F", "<cmd>HopLine<cr>" },
    -- yank to end of line on Y
    { "Y", "y$" },
    -- lsp mappings
    { "K", show_documentation },

    { "<leader>dd", "<cmd>call CompileRunGcc()<cr>" },

    { "ga", "<Plug>(LiveEasyAlign)" },

    -- Resize with arrows
    { "<C-Up>", ":resize -2<CR>" },
    { "<C-Down>", ":resize +2<CR>" },
    { "<C-Left>", ":vertical resize -2<CR>" },
    { "<C-Right>", ":vertical resize +2<CR>" },

    -- window management
    { "<c-j>", "<c-d>" },
    { "<c-k>", "<c-u>" },
    --
    -- window management
    { "<leader>v", ":vsplit<cr>" },
    { "<leader>h", ":split<cr>" },

    { "n", "nzz" },
    { "N", "Nzz" },
    { "*", "*zz" },
    { "#", "#zz" },
    { "g*", "g*zz" },
    { "g#", "g#zz" },
    { "Q", "<cmd>q!<CR>" },
    { "<c-q>", "<cmd>qall!<CR>" },
    { "<c-s>", "<cmd>w!<CR>" },
    { "<c-q>", "<cmd>q!<CR>" },

    -- dap
    { "<M-x>", ":Telescope commands<cr>" },
    { "<M-r>", ":lua require('dap').start()<cr>" },
    { "<M-t>", ":lua require('dap').toggle_breakpoint()<cr>" },
    { "<M-n>", ":lua require('dap').step_over()<cr>" },
    { "<M-o>", ":lua require('dap').step_out()<cr>" },
    { "<M-i>", ":lua require('dap').step_into()<cr>" },
    { "<M-c>", ":lua require('dap').continue()<cr>" },
    { "<M-u>", ":lua require('dap').run_to_cursor()<cr>" },
    { "<M-k>", ":lua require('dapui').eval()<cr>" },
    { "<M-k>", ":lua require('dapui').eval()<cr>" },

    -- bufferline
    { "<tab>", "<cmd>BufferLineCyclePrev<CR>" },
    { "<s-tab>", "<cmd>BufferLineCycleNext<CR>" },
    { "<C-d>", "<C-d>zz" },
    { "<C-u>", "<C-u>zz" },
    -- Remap for dealing with line wrap
    -- { "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, } },
    -- { "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, } },
    -- open link under cursor
    { "gx", '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>' },
  },
  t = {
    -- Terminal mode
    -- Terminal window navigation
    -- { "<C-h>", "<C-\\><C-N><C-w>h" },
    -- { "<C-j>", "<C-\\><C-N><C-w>j" },
    -- { "<C-k>", "<C-\\><C-N><C-w>k" },
    -- { "<C-l>", "<C-\\><C-N><C-w>l" },
    -- map escape to normal mode in terminal
    { "<Esc>", [[ <C-\><C-n> ]] },
    { "jj", [[ <C-\><C-n> ]] },
  },
  v = {
    -- Visual/Select mode
    -- Better indenting
    { "<", "<gv" },
    { ">", ">gv" },
    -- hop words
    { "S", require("hop").hint_words },
    -- moving text
    { "J", "<cmd>m '>+1<CR>gv=gv" },
    { "K", "<cmd>m '<-2<CR>gv=gv" },
  },
  x = {
    -- remap p to always paste from last yank
    { "<leader>p", '"_dP' },

    { "ga", "<Plug>(LiveEasyAlign)" },
  },
  c = {
    { "<C-a>", "<Home>" },
    { "<C-a>", "<Home>" },
    { "<C-b>", "<Left>" },
    { "<C-d>", "<Del>" },
    { "<C-e>", "<End>" },
    { "<C-f>", "<Right>" },
    { "<C-n>", "<Down>" },
    { "<C-j>", "<Down>" },
    { "<C-p>", "<Up>" },
    { "<C-k>", "<Up>" },
    { "<C-y>", "<C-r>*" },
    { "<C-g>", "<C-c>" },
  },
}

register_mappings(mappings, { silent = true, noremap = true })

-- S for search and replace in buffer
-- vim.cmd("nnoremap S :%s/")

-- hop in motion
local actions = { "d", "c", "<", ">", "y" }
for _, a in ipairs(actions) do
  vim.keymap.set("n", a .. "f", a .. "<cmd>lua require'hop'.hint_char1()<cr>")
end
