return {
  {
    "4e554c4c/darkman.nvim",
    build = "go build -o bin/darkman.nvim",
    enabled = vim.fn.executable "darkman" == 1,
    opts = {
      change_background = true,
      send_user_event = false,
      colorscheme = {
        dark = "github_dark_high_contrast",
        light = "github_light",
      },
    },
  },
}
