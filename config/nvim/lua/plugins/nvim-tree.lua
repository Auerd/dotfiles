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
      view = {
        side = "right",
        centralize_selection = true,
        width = "15%",
      }
    },
  }
}
