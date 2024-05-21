local cmd = vim.cmd
local o = vim.o

-- Colors
cmd.colorscheme "github_dark_high_contrast"
o.termguicolors = true

-- Number of line
o.number = true

-- Tabs
o.softtabstop = 0
o.expandtab = true
o.smarttab = true
o.shiftwidth = 2

-- Statusline
o.laststatus = 3

-- End of buffer character
o.fcs = "eob: "

-- But "vim.wo.number = false" works for all buffers
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = { "*" },
  command = "setlocal nonumber norelativenumber",
})

-- Keymap
vim.o.timeout = true
vim.o.timeoutlen = 300
