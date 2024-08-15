return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        html = { "djlint" },
        javascript = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 5000,
        lsp_fallback = true,
      },
    },
  },
}
