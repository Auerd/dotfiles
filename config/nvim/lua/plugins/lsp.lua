return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      require("lazydev").setup()
      local lspconfig = vim.lsp.config
      local servers = { "clangd", "bashls", "pyright", "cmake", "lua_ls", "html", "rust_analyzer", "cssls" }
      for _, lsp in ipairs(servers) do
        vim.lsp.enable(lsp)
        if lsp == "bashls" then
          lspconfig(lsp,  { filetypes = { "sh", "zsh" } })
        elseif lsp == "html" then
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.completion.completionItem.snippetSupport = true
          lspconfig(lsp,  { capabilities = capabilities })
        end
      end
    end,
  },
}
