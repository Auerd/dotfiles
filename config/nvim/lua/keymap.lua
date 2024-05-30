-- vim:fileencoding=utf-8:foldmethod=marker
-- Warning! This file executed before nvim. That means you can't use plugins there
-- If it's needed to use plugin in keymap, you can map key in the init() function of plugin
vim.cmd.let "mapleader = ' '"

local map = vim.keymap.set

-- Window navigation {{{
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
-- }}}

-- Buffer navigation {{{
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
map("n", "<S-Tab>", "<cmd>bprev<cr>", { desc = "Go to previous buffer" })
-- }}}

-- View navigation {{{
map("n", "<A-h>", "zh", { desc = "Move view to the left" })
map("n", "<A-j>", "<C-e>", { desc = "Move view down" })
map("n", "<A-k>", "<C-y>", { desc = "Move view up" })
map("n", "<A-l>", "zl", { desc = "Move view to the right" })
-- }}}

-- Neotree toggle {{{
-- But you can use this workaround
map("n", "<leader>e", function()
  return ":Neotree position=right toggle=true<CR>"
end, { desc = "Toggle neo-tree", expr = true })
-- }}}

-- Lsp {{{
map("n", "<leader>lr", function()
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { desc = "Lsp rename", expr = true })

map("n", "<leader>lf", function()
  vim.lsp.buf.references()
end, { desc = "Lsp references" })

map("n", "<leader>ld", function()
  vim.lsp.buf.definition()
end, { desc = "Lsp definitions" })
-- }}}

-- Numbers toggle {{{
map("n", "<leader>nn", function()
  return vim.o.number and "<cmd>setlocal nonumber<cr>" or "<cmd>setlocal number<cr>"
end, { desc = "Toggle lines number", expr = true })
-- }}}

-- Mode switch {{{
map("t", "<C-x>", "<C-\\><C-n>", { desc = "Switch to normal mode" })
map("i", "jj", "<Esc>", { desc = "Switch to normal mode" })
-- }}}
