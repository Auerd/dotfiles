vim.cmd.let "mapleader = ' '"

local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

map("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle nvim-tree" })

map({ "n", "i" }, "<Tab>", "<cmd>bnext<cr>", { desc = "Got to next buffer" })
map({ "n", "i" }, "<S-Tab>", "<cmd>bprev<cr>", { desc = "Got to previous buffer" })

map("i", "jj", "<Esc>", { desc = "Switch to normal mode" })
