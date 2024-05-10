return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    name = "nvim-tree",
    opts = {
      hijack_cursor = true,
      view = {
        side = "right",
        width = "15%",
      },
    },
  },
}
