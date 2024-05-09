local cmd = vim.cmd
local o = vim.o


cmd.colorscheme("github_dark_high_contrast")

o.number = true

-- Tabs
o.softtabstop = 0
o.expandtab = true
o.smarttab = true
o.shiftwidth = 2

-- Statusline
o.laststatus = 3
