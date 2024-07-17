return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      require("lazydev").setup()
      local lspconfig = require "lspconfig"
      local servers = { "clangd", "bashls", "pyright", "cmake", "lua_ls" }
      for _, lsp in ipairs(servers) do
        if lsp == "bashls" then
          lspconfig[lsp].setup { filetypes = { "sh", "zsh" } }
        else
          lspconfig[lsp].setup {}
        end
      end
    end,
  },
}
