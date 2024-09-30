return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      defaults = {
        borderchars = { " ", "", "", "", "", "", "", "" },
        mappings = {
          i = {
            ["<esc>"] = function(bufnr)
              require("telescope.actions").close(bufnr)
            end
          },
        },
      },
    },
  },
}
