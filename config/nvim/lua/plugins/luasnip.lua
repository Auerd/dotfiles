return {
  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip").config.setup {
        history = true,
        update_events = { "TextChanged", "TextChangedI" },
        enable_autosnippets = true, -- <--- ENABLES AUTOSNIPPETS GLOBALLY
        store_selection_keys = "<Tab>",
      }
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").load()
    end,
    build = "make install_jsregexp",
  },
}
