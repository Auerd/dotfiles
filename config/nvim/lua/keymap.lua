vim.cmd.let "mapleader = ' '"

local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

map("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle nvim-tree" })

map("n", "<leader>a", function()
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { desc = "Lsp rename", expr = true })

map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
map("n", "<S-Tab>", "<cmd>bprev<cr>", { desc = "Go to previous buffer" })

map("t", "<C-x>", "<C-\\><C-n>", { desc = "Switch to normal mode" })
map("i", "jj", "<Esc>", { desc = "Switch to normal mode" })
