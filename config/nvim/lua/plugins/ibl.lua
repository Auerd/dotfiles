return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    scope = { enabled = false },
    indent = {
      char = "┃",
    },
    exclude = {
      filetypes = {
        "lspinfo",
        "packer",
        "checkhealth",
        "help",
        "man",
        "gitcommit",
        "TelescopePrompt",
        "TelescopeResults",
        "",
        "dashboard",
      },
    },
  },
  dependencies = {
    "raddari/last-color.nvim",
  },
}
