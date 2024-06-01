local autocmd = vim.api.nvim_create_autocmd

-- But "vim.wo.number = false" works for all buffers
autocmd("TermOpen", {
  pattern = { "*" },
  command = "setlocal nonumber norelativenumber",
})

autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "neo-tree" },
  callback = function()
    require("ufo").detach()
  end,
})
