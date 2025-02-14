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
        python = { "black" },
        json = { "jq" },
      },
    },
  },
}
