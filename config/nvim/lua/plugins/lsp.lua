return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      require("neodev").setup()
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
    dependencies = {
      {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
      },
      {
        "folke/neodev.nvim",
      },
      {
        "L3MON4D3/LuaSnip",
      },
      {
        "hrsh7th/cmp-nvim-lsp",
      },
      {
        "saadparwaiz1/cmp_luasnip",
      },
      {
        "hrsh7th/cmp-path",
      },
      {
        "hrsh7th/nvim-cmp",
        opts = function()
          local cmp = require "cmp"
          local luasnip = require "luasnip"
          cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
          return {
            snippet = {
              expand = function(args)
                luasnip.lsp_expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert {
              ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Up
              ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Down
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<CR>"] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
              },
              ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end, { "i", "s" }),
              ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" }),
            },
            sources = {
              { name = "nvim_lsp" },
              { name = "luasnip" },
              { name = "path" },
            },
          }
        end,
      },
      {
        "smjonas/inc-rename.nvim",
        config = true,
      },
    },
  },
}
