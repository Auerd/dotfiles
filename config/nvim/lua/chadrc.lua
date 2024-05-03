-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "ayu_dark",

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
  nvdash = {
    load_on_startup = true,
  },
  tabufline = {
    enabled = false,
    lazyload = true,
    order = {"buffers", "tabs", "btns", "treeOffset" },
    modules = nil,
  }
}

return M
