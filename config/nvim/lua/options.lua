local o = vim.o

-- Disable start screen
o.shortmess = o.shortmess .. "I"

-- Number of line
o.number = true

-- Indent
o.tabstop = 4
o.softtabstop = 2
o.expandtab = true
o.smarttab = true
o.shiftwidth = 2

-- Windows
o.splitbelow = true
o.splitright = true

-- Statusline
o.laststatus = 3

-- Moving
o.smoothscroll = true

-- End of buffer character
o.fcs = "eob: "

-- Keymap
o.timeout = true
o.timeoutlen = 300

local g = vim.g

-- Providers
g.loaded_perl_provider = 0
g.loaded_node_provider = 0
g.loaded_ruby_provider = 0

-- Netrw
g.netrw_banner = 0
