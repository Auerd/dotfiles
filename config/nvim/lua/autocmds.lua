local autocmd = vim.api.nvim_create_autocmd
local doautocmds = vim.api.nvim_exec_autocmds

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

-- Linter
autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf, timeout_ms = 5000, lsp_format = "fallback" }, function(err, did_edit)
      if err == nil and did_edit then
        doautocmds("User", { pattern = "BufLintAfter" })
      end
    end)
  end,
})

-- Indent
autocmd("BufEnter", {
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
