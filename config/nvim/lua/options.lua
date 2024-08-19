local o = vim.o

-- Number of line
o.number = true

-- Tabs
o.tabstop = 4
o.softtabstop = 2
o.expandtab = true
o.smarttab = true
o.shiftwidth = 2

-- Statusline
o.laststatus = 3

-- End of buffer character
o.fcs = "eob: "

-- Keymap
o.timeout = true
o.timeoutlen = 300

local g = vim.g
g.loaded_perl_provider = 0
g.loaded_node_provider = 0
g.loaded_ruby_provider = 0
g.netrw_banner = 0
