return {
  "your-username/latex-preview.nvim",
  enabled = vim.env.TERM == "xterm-kitty",
  dependencies = { "folke/snacks.nvim" },
  ft = { "tex", "latex", "markdown", "rmd", "quarto" },
  opts = {
    setup_keymap = true, -- bind <leader>ih in supported filetypes
    cache = true, -- persist renders to disk
    cache_dir = "aux", -- default: <texfile-dir>/aux/latex-preview-cache/
  },
}
