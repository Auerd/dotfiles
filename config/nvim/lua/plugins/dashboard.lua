-- vim:fileencoding=utf-8:foldmethod=marker
-- source of art = https://www.asciiart.eu/food-and-drinks/other
return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    opts = function()
      local art = -- {{{
        [[
                  _           
              /> //  __       
          ___/ \// _/ /       
        ,' , \_/ \/ _/__      
       /    _/ |--\  `  `~,   
      ' , ,/  /`\ / `  `   `, 
      |    |  |  \> `  `  ` | 
      |  ,  \/ ' '    `  `  / 
      `,   '  '    ' `  '  /  
        \ `      '  ' ,  ,'   
         \ ` ` '    ,  ,/     
          `,  `  '  , ,'      
            \ `  ,   /        
             `~----~'         ]] ---@type string }}}
      return {
        theme = "doom",
        config = {
          header = vim.split(art, "\n"),
          center = {
            {
              action = "Neotree position=right toggle=true",
              desc = " Toggle neo-tree",
              icon = "󰔱",
              key = "t",
            },
            {
              action = "qa",
              desc = " Quit",
              icon = " ",
              key = "q",
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }
    end,
  },
}
