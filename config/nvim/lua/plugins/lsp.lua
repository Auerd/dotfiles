return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      require("lazydev").setup()
      local lspconfig = require "lspconfig"
      local servers = { "clangd", "bashls", "pyright", "cmake", "lua_ls", "html" }
      for _, lsp in ipairs(servers) do
        if lsp == "bashls" then
          lspconfig[lsp].setup { filetypes = { "sh", "zsh" } }
        elseif lsp == "html" then
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.completion.completionItem.snippetSupport = true
          lspconfig[lsp].setup { capabilities = capabilities }
        else
          lspconfig[lsp].setup {}
        end
      end
    end,
  },
}
