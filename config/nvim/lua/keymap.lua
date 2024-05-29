-- Warning! This file executed before nvim. That means you can't use plugins there
-- If it's needed to use plugin in keymap, you can map key in the init() function of plugin
vim.cmd.let "mapleader = ' '"

local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Ok, I don't know how it works...
map("n", "<leader>e", function()
  return ":Neotree position=right toggle=true<CR>"
end, { desc = "Toggle neo-tree", expr = true })

-- But you can use this workaround
map("n", "<leader>lr", function()
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { desc = "Lsp rename", expr = true })

map("n", "<leader>lf", function()
  vim.lsp.buf.references()
end, { desc = "Lsp references" })

map("n", "<leader>ld", function()
  vim.lsp.buf.definition()
end, { desc = "Lsp definitions" })

map("n", "<leader>nn", function()
  return vim.o.number and "<cmd>setlocal nonumber<cr>" or "<cmd>setlocal number<cr>"
end, { desc = "Toggle lines number", expr = true })

map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
map("n", "<S-Tab>", "<cmd>bprev<cr>", { desc = "Go to previous buffer" })

map("t", "<C-x>", "<C-\\><C-n>", { desc = "Switch to normal mode" })
map("i", "jj", "<Esc>", { desc = "Switch to normal mode" })
