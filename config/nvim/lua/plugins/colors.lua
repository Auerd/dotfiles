local is_termx = vim.env.TERMUX_VERSION ~= nil

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      no_italic = is_termx,
    }
  },
  {
    'projekt0n/github-nvim-theme',
  },
}
