return {
  {
    "nvim-tree/nvim-tree.lua",
    lazy = "true",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    name = "nvim-tree",
    opts = {
      view = {
        side = "right",
        width = "15%",
      },
    },
  },
}
