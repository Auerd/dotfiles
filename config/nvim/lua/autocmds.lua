local autocmd = vim.api.nvim_create_autocmd

-- But "vim.wo.number = false" works for all buffers
autocmd("TermOpen", {
  pattern = { "*" },
  command = "setlocal nonumber norelativenumber",
})

autocmd("BufWritePost", {
  pattern = "*.scss",
  callback = function(data)
    if vim.fn.executable "sass" ~= 1 then
      return
    end
    local filename = data.file:match "(.+)%..+"
    vim.fn.jobstart("sass " .. filename .. ".scss " .. filename .. ".css")
  end,
})

-- Indent
autocmd({ "BufNew", "VimEnter" }, {
  callback = function(data)
    local ft = vim.o.filetype
    local bo = vim.bo[data.buf]
    if ft == "lua" then
      bo.expandtab = true
      bo.tabstop = 2
      bo.shiftwidth = 2
    end
  end,
})
