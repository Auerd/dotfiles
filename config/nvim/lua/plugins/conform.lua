return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").formatters.shfmt = {
        prepend_args = "-ln=auto",
      }
    end,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
