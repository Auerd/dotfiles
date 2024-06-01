-- vim:fileencoding=utf-8:foldmethod=marker
-- Warning! This file executed before "lazy.nvim". That means plugins may not work there
-- If it's needed to use plugin in "keymap()", you can map key in the "init()" function of plugin
vim.cmd.let "mapleader = ' '"

local map = vim.keymap.set

-- Window navigation {{{
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
-- }}}

-- Buffer navigation {{{
local bp = vim.cmd.bp
local bn = vim.cmd.bn
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
map("n", "<S-Tab>", "<cmd>bprev<cr>", { desc = "Go to previous buffer" })
map("n", "<leader>dd", function()
  require("bufdelete").bufdelete(0)
end, { desc = "Delete current buffer and move to next" })
map("n", "<leader>dc", function()
  require("bufdelete").bufdelete(0)
  bp()
end, { desc = "Delete current buffer and move to previous" })
map("n", "<leader>dp", function()
  bp()
  require("bufdelete").bufdelete(0)
end, { desc = "Delete previous buffer" })
map("n", "<leader>dn", function()
  bn()
  require("bufdelete").bufdelete(0)
end, { desc = "Delete next buffer" })
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
  require("neo-tree.command").execute { toggle = true }
end, { desc = "Toggle neo-tree" })
-- }}}

-- Lsp {{{
map("n", "<leader>i", function()
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { desc = "Lsp rename", expr = true })

map("n", "<leader>u", function()
  vim.lsp.buf.references()
end, { desc = "Lsp references" })

map("n", "<leader>o", function()
  vim.lsp.buf.definition()
end, { desc = "Lsp definitions" })
-- }}}

-- Numbers toggle {{{
map("n", "<leader>nn", function()
  if vim.o.number then
    vim.cmd.set "nonumber"
  else
    vim.cmd.set "number"
  end
end, { desc = "Toggle lines number" })
-- }}}

-- Mode switch {{{
map("t", "<C-x>", "<C-\\><C-n>", { desc = "Switch to normal mode" })
map("i", "jj", "<Esc>", { desc = "Switch to normal mode" })
-- }}}
