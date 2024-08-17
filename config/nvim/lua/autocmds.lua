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

autocmd("BufWritePre", {
  pattern = "*.scss",
  callback = function(data)
    if vim.fn.executable "sass" ~= 1 then
      return
    end
    local filename = data.file:match "(.+)%..+"
    vim.fn.jobstart("sass " .. filename .. ".scss " .. filename .. ".css")
  end,
})
