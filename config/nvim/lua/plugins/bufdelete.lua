return {
  {
    "famiu/bufdelete.nvim",
    init = function()
      vim.keymap.set("n", "<leader>d", function()
        require("bufdelete").bufdelete(0)
      end, { desc = "Delete current buffer and move to next" })
    end,
  },
}
