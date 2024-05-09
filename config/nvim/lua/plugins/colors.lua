local is_termx = vim.env.TERMUX_VERSION ~= nil

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      no_italic = is_termx,
    },
  },
  {
    "projekt0n/github-nvim-theme",
    config = function()
      require("github-theme").setup {
        options = {
          styles = {
            comments = is_termx and "NONE" or "italic",
            conditionals = is_termx and "NONE" or "italic",
          },
        },
      }
    end,
  },
}
