-- vim:fileencoding=utf-8:foldmethod=marker
-- Warning! This file executed before "lazy.nvim". That means plugins may not work there
-- If it's needed to use plugin in "keymap()" not in separate function, you can map the key in the "init()" function of plugin
-- With functions plugin call can be delayed. That's the main purpose
local map = vim.keymap.set

-- This will work!
-- Telescope {{{
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Find file" })
map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Grep threw the files" })
map("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, { desc = "List availible buffers" })
map("n", "<leader>fh", function()
  require("telescope.builtin").help_tags()
end, { desc = "Help tags" })
-- }}}

-- Windows navigation {{{
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("t", "<C-h>", "<Esc><C-w>h", { desc = "Go to Left Window", remap = true })
map("t", "<C-j>", "<Esc><C-w>j", { desc = "Go to Lower Window", remap = true })
map("t", "<C-k>", "<Esc><C-w>k", { desc = "Go to Upper Window", remap = true })
map("t", "<C-l>", "<Esc><C-w>l", { desc = "Go to Right Window", remap = true })
-- }}}

-- Window size {{{
map("n", "<A-h>", "<C-w><", { desc = "Decrease width" })
map("n", "<A-l>", "<C-w>>", { desc = "Increase width" })
map("n", "<A-j>", "<C-w>+", { desc = "Decrease height" })
map("n", "<A-k>", "<C-w>-", { desc = "Increase height" })
-- }}}

-- Browsing {{{
map("n", "cd", "<cmd>cd %:h<CR>", { desc = "Go to parent directory" })
-- }}}

-- Or you can use this workaround
-- Lsp {{{
-- Just bind it command
map("n", "<leader>i", function()
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { desc = "Lsp rename", expr = true })

map("n", "<leader>u", function()
  vim.lsp.buf.references()
end, { desc = "Lsp references" })

map("n", "<leader>o", function()
  vim.lsp.buf.definition()
end, { desc = "Lsp definitions" })

map("n", "<leader>d", function()
  vim.diagnostic.open_float()
end, { desc = "Open diagnostic window" })
-- }}}

-- Numbers toggle {{{
map("n", "<leader>n", function()
  vim.opt_local.number = not vim.o.number
end, { desc = "Toggle lines number" })
-- }}}

-- Wrapping toggle {{{
map("n", "<leader>w", function()
  vim.opt_local.wrap = not vim.o.wrap
end, { desc = "Toggle wrapping" })
-- }}}

-- Mode switch {{{
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Switch to normal mode" })
map("i", "jj", "<Esc>", { desc = "Switch to normal mode" })
-- }}}

-- LuaSnip {{{
-- source: https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
-- This is not acceptable:
--local ls = require "luasnip"
-- But this is OK
map({ "i", "s" }, "<C-L>", function()
  require("luasnip").jump(1)
end, { silent = true })
map({ "i", "s" }, "<C-J>", function()
  require("luasnip").jump(-1)
end, { silent = true })
-- }}}

-- Run file {{{
map("n", "<F5>", function()
  local expr = " %<CR>"
  local ft = vim.o.filetype
  local ifexec = vim.fn.executable
  local fttoexec = {
    ["python"] = "python",
    ["lua"] = "lua",
    ["tex"] = "pdflatex",
    ["bash"] = "bash",
  }
  local toexec = fttoexec[ft]
  if toexec ~= nil and ifexec(toexec) then
    expr = toexec .. expr
  else
    return ""
  end
  expr = "<cmd>!" .. expr
  if vim.o.modified then
    return "<cmd>w<CR>" .. expr
  end
  return expr
end, { desc = "Run file", expr = true })
-- }}}
