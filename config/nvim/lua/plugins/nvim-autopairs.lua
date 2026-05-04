return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require "nvim-autopairs"
      npairs.setup()
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules {
        Rule("$", "$", { "tex", "latex" })
          -- don't add a pair if the next character is %
          :with_pair(cond.not_after_regex "%%")
          -- don't add a pair if  the previous character is xxx
          :with_pair(cond.not_before_regex("xxx", 3))
          -- move right
          :with_move(cond.is_bracket_line_move())
          -- don't delete if the next character is xx
          :with_del(cond.not_after_regex "xx")
          -- disable adding a newline when you press <cr>
          :with_cr(cond.none()),
      }
    end,
  },
}
