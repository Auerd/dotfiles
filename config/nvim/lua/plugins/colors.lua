local no_italic = vim.g.no_italic

return {
  {
    "raddari/last-color.nvim",
    config = function()
      vim.cmd.colorscheme(require("last-color").recall())
    end,
  },
  {
    "iagorrr/noctis-high-contrast.nvim",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      no_italic = no_italic,
    },
  },
  {
    "projekt0n/github-nvim-theme",
    config = function()
      require("github-theme").setup {
        options = {
          styles = {
            comments = no_italic and "NONE" or "italic",
            conditionals = no_italic and "NONE" or "italic",
          },
        },
      }
    end,
  },
}
