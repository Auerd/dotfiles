-- source: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua
-- I had big headache with it
return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = { "VeryLazy", "BufReadPost", "BufWritePost", "BufNewFile" },
  init = function(plugin)
    -- source: https://github.com/nvim-treesitter/nvim-treesitter/issues/655
    vim.treesitter.language.register("bash", "zsh")
  end,
  dependencies = {
    "raddari/last-color.nvim",
  },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<c-space>", desc = "Increment Selection" },
    { "<bs>", desc = "Decrement Selection", mode = "x" },
  },
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    sync_install = false,
    highlight = {
      enable = true,
      disable = { "latex" },
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = false },
    ensure_installed = {
      "c",
      "cpp",
      "rust",
      "make",
      "cmake",
      "xcompose",
      "python",
      "bash",
      "xml",
      "toml",
      "yaml",
      "arduino",
      "java",
      "html",
      "css",
      "javascript",
      "gitcommit",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitignore",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      move = {
        enable = false,
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
      },
    },
  },
}
