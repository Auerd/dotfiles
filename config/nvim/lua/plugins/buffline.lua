return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
    opts = function()
      local bufferline = require "bufferline"
      local default = bufferline.style_preset.default
      local no_italic = bufferline.style_preset.no_italic
      return {
        options = {
          style_preset = vim.g.no_italic and no_italic or default,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            },
          },
        },
      }
    end,
  },
}
