local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.g.no_italic = vim.env.TERMUX_VERSION ~= nil ---@type boolean

require "options"
require "autocmds"
vim.g.mapleader = " "
require "keymap"
require("lazy").setup "plugins"
