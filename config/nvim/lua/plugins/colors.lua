return{
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    event = "VeryLazy",
    opts = {
      no_italic = vim.env.TERMUX_VERSION ~= nil,
    },
  }
}
